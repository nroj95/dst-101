#Requires -Version 7.0

<#
.SYNOPSIS
Prepares one handbook illustration for the dst 101 runtime pipeline.

.DESCRIPTION
- accepts a full-quality source image from anywhere.
- center-crops/resizes to the canonical handbook illustration size.
- quantizes the production png with pngquant when that produces a useful result.
- keeps the original source file untouched.
- writes the canonical production image to source/assets/illustrations.

The production asset is intentionally 573x321, matching the authored handbook
illustration opening exactly. Production illustrations therefore render at 1:1
source-pixel size without aspect-ratio correction or runtime stretching.
#>

[CmdletBinding()]
param(
    [Parameter(Mandatory)]
    [string] $Source,

    [Parameter(Mandatory)]
    [ValidatePattern('^[a-z0-9]+(?:_[a-z0-9]+)*$')]
    [string] $Name,

    [ValidateRange(1, 4096)]
    [int] $Width = 573,

    [ValidateRange(1, 4096)]
    [int] $Height = 321,

    [string] $PngQuantQuality = '80-95'
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$projectRoot = Split-Path -Parent $PSScriptRoot
$outputDirectory = Join-Path $projectRoot 'source\assets\illustrations'
$buildDirectory = Join-Path $projectRoot '.build\illustrations\prepare'

$magick = Get-Command magick -ErrorAction Stop
$pngquant = Get-Command pngquant -ErrorAction Stop

$sourcePath = (Resolve-Path $Source).Path
$outputPath = Join-Path $outputDirectory "$Name.png"

New-Item -ItemType Directory -Force `
    $outputDirectory,
    $buildDirectory |
    Out-Null

$resizedPath = Join-Path $buildDirectory "$Name-resized.png"
$quantizedPath = Join-Path $buildDirectory "$Name-quantized.png"

Remove-Item $resizedPath, $quantizedPath -Force -ErrorAction SilentlyContinue

# Crop from the center only as much as required to reach the canonical 16:9
# production ratio. Masters remain untouched so a crop can always be revised.
& $magick.Source `
    $sourcePath `
    -auto-orient `
    -resize "${Width}x${Height}^" `
    -gravity center `
    -extent "${Width}x${Height}" `
    $resizedPath

if ($LASTEXITCODE -ne 0) {
    throw 'ImageMagick failed while preparing the illustration.'
}

# Quantization is applied only to the derived production asset. If pngquant
# cannot meet the requested quality floor, keep the lossless resized version.
& $pngquant.Source `
    --quality $PngQuantQuality `
    --speed 1 `
    --strip `
    --force `
    --output $quantizedPath `
    -- $resizedPath

$quantizedSucceeded =
    $LASTEXITCODE -eq 0 -and
    (Test-Path $quantizedPath)

$resizedFile = Get-Item $resizedPath

if ($quantizedSucceeded) {
    $quantizedFile = Get-Item $quantizedPath

    if ($quantizedFile.Length -lt $resizedFile.Length) {
        Copy-Item $quantizedPath $outputPath -Force
        $selected = 'pngquant'
    }
    else {
        Copy-Item $resizedPath $outputPath -Force
        $selected = 'lossless resized png'
    }
}
else {
    Copy-Item $resizedPath $outputPath -Force
    $selected = 'lossless resized png'
}

$result = Get-Item $outputPath

Write-Host
Write-Host "Prepared illustration: $Name"
Write-Host "Method: $selected"
Write-Host "Output: $($result.FullName)"
Write-Host ('Size: {0:N1} KiB' -f ($result.Length / 1KB))
