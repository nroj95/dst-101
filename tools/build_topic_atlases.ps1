# =============================================================================
# dst 101 topic atlas builder
#
# builds:
# - coloured topic icon atlas for the sidebar
# - grayscale topic icon atlas for related-topic tiles
#
# source icons remain untouched.
# =============================================================================

$ErrorActionPreference = 'Stop'

$projectRoot = Split-Path $PSScriptRoot -Parent

$sourceDirectory = Join-Path $projectRoot 'source\assets\icons'
$buildDirectory = Join-Path $projectRoot '.build\topics'
$outputDirectory = Join-Path $projectRoot 'images\topics'

$atlasSize = 1024
$cellSize = 128
$iconSize = 112
$padding = [int](($cellSize - $iconSize) / 2)
$columns = 8

$colorAtlasName = 'dst101_topics_color'
$grayAtlasName = 'dst101_topics_gray'

$colorPng = Join-Path $buildDirectory "$colorAtlasName.png"
$grayPng = Join-Path $buildDirectory "$grayAtlasName.png"

New-Item -ItemType Directory -Force -Path `
    $buildDirectory,
    $outputDirectory |
    Out-Null

$icons = @(
    Get-ChildItem $sourceDirectory -File -Filter '*.png' |
        Sort-Object Name
)

if ($icons.Count -eq 0) {
    throw "No topic icons found in: $sourceDirectory"
}

if ($icons.Count -gt 64) {
    throw "The 8x8 atlas supports at most 64 icons."
}

Write-Host "Building atlases from $($icons.Count) topic icons..."


# =============================================================================
# atlas png generation
# =============================================================================

function Build-AtlasPng {
    param(
        [Parameter(Mandatory)]
        [System.IO.FileInfo[]]$Icons,

        [Parameter(Mandatory)]
        [string]$OutputPath,

        [switch]$Grayscale
    )

    $arguments = @(
        '-size',
        "${atlasSize}x${atlasSize}",
        'xc:none'
    )

    for ($index = 0; $index -lt $Icons.Count; $index++) {
        $column = $index % $columns
        $row = [math]::Floor($index / $columns)

        $x = $column * $cellSize + $padding
        $y = $row * $cellSize + $padding

        $arguments += '('
        $arguments += $Icons[$index].FullName
        $arguments += '-filter'
        $arguments += 'Lanczos'
        $arguments += '-resize'
        $arguments += "${iconSize}x${iconSize}"

        if ($Grayscale) {
            # Keep grayscale appearance but return to RGB channels for ktech.
            $arguments += '-colorspace'
            $arguments += 'Gray'
            $arguments += '-colorspace'
            $arguments += 'sRGB'
        }

        $arguments += ')'
        $arguments += '-geometry'
        $arguments += "+$x+$y"
        $arguments += '-composite'
    }

    # Force truecolor + alpha instead of PNG grayscale optimization.
    $arguments += '-define'
    $arguments += 'png:color-type=6'
    $arguments += $OutputPath

    & magick @arguments

    if ($LASTEXITCODE -ne 0) {
        throw "ImageMagick failed while building: $OutputPath"
    }
}

Build-AtlasPng `
    -Icons $icons `
    -OutputPath $colorPng

Build-AtlasPng `
    -Icons $icons `
    -OutputPath $grayPng `
    -Grayscale


# =============================================================================
# atlas xml generation
# =============================================================================

function Format-Uv {
    param(
        [double]$Value
    )

    return $Value.ToString(
        '0.#########',
        [System.Globalization.CultureInfo]::InvariantCulture
    )
}

function Write-AtlasXml {
    param(
        [Parameter(Mandatory)]
        [System.IO.FileInfo[]]$Icons,

        [Parameter(Mandatory)]
        [string]$AtlasName
    )

    $xmlPath = Join-Path $outputDirectory "$AtlasName.xml"

    $lines = @(
        '<?xml version="1.0"?>',
        '<Atlas>',
        "    <Texture filename=`"$AtlasName.tex`" />",
        '    <Elements>'
    )

    for ($index = 0; $index -lt $Icons.Count; $index++) {
        $column = $index % $columns
        $row = [math]::Floor($index / $columns)

        $x = $column * $cellSize + $padding
        $y = $row * $cellSize + $padding

        # Half-pixel inset matches DST/Klei atlas UV conventions.
        $u1 = ($x + 0.5) / $atlasSize
        $u2 = ($x + $iconSize - 0.5) / $atlasSize

        $v1 = (
            $atlasSize - ($y + $iconSize) + 0.5
        ) / $atlasSize

        $v2 = (
            $atlasSize - $y - 0.5
        ) / $atlasSize

        $elementName = [IO.Path]::GetFileNameWithoutExtension(
            $Icons[$index].Name
        ) + '.tex'

        $lines += (
            '        <Element name="{0}" u1="{1}" u2="{2}" v1="{3}" v2="{4}" />' -f
                $elementName,
                (Format-Uv $u1),
                (Format-Uv $u2),
                (Format-Uv $v1),
                (Format-Uv $v2)
        )
    }

    $lines += @(
        '    </Elements>',
        '</Atlas>'
    )

    Set-Content `
        -Path $xmlPath `
        -Value $lines `
        -Encoding utf8
}

Write-AtlasXml -Icons $icons -AtlasName $colorAtlasName
Write-AtlasXml -Icons $icons -AtlasName $grayAtlasName


# =============================================================================
# tex conversion
# =============================================================================

function Convert-AtlasToTex {
    param(
        [Parameter(Mandatory)]
        [string]$AtlasName
    )

    $containerInput = "/data/.build/topics/$AtlasName.png"
    $containerOutput = "/data/images/topics/$AtlasName.tex"

    & docker run --rm `
        -v "${projectRoot}:/data/" `
        dstmodders/ktools:4.5.1 `
        ktech --pow2 --extend `
        $containerInput `
        $containerOutput

    if ($LASTEXITCODE -ne 0) {
        throw "ktech failed while converting: $AtlasName"
    }
}

Convert-AtlasToTex $colorAtlasName
Convert-AtlasToTex $grayAtlasName


# =============================================================================
# summary
# =============================================================================

Write-Host
Write-Host 'Generated:'

Get-ChildItem $outputDirectory -File |
    Where-Object {
        $_.BaseName -in @(
            $colorAtlasName,
            $grayAtlasName
        )
    } |
    Sort-Object Name |
    Select-Object Name, Length

