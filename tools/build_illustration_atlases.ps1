#Requires -Version 7.0

<#
.SYNOPSIS
Builds the runtime atlases for dst 101 handbook illustrations.

.DESCRIPTION
Production illustrations are expected to be 573x321 PNG files created by
prepare_illustration.ps1.

Illustration atlases use a 3x5 grid of 672x400 cells, with 2048x2048 as
the maximum atlas size. Partially filled atlases shrink to the smallest
power-of-two canvas that fits their contents. The cells intentionally leave
padding around each 573x321 illustration to protect atlas sampling at the edges.

The builder also generates scripts/dst101illustrations.lua. Runtime code uses
that manifest to find the atlas containing each illustration.
#>

[CmdletBinding()]
param()

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$projectRoot = Split-Path -Parent $PSScriptRoot

$sourceDirectory =
    Join-Path $projectRoot 'source\assets\illustrations'

$buildDirectory =
    Join-Path $projectRoot '.build\illustrations\atlases'

$outputDirectory =
    Join-Path $projectRoot 'images\illustrations'

$manifestPath =
    Join-Path $projectRoot 'scripts\dst101illustrations.lua'

$atlasSize = 2048
$imageWidth = 573
$imageHeight = 321
$cellWidth = 672
$cellHeight = 400

$columns = [math]::Floor($atlasSize / $cellWidth)
$rows = [math]::Floor($atlasSize / $cellHeight)
$imagesPerAtlas = $columns * $rows

if ($columns -lt 1 -or $rows -lt 1) {
    throw 'Illustration cells do not fit inside the configured atlas.'
}

$magick = Get-Command magick -ErrorAction Stop

New-Item -ItemType Directory -Force `
    $sourceDirectory,
    $buildDirectory,
    $outputDirectory |
    Out-Null

$illustrations = @(
    Get-ChildItem $sourceDirectory -Filter '*.png' -File |
        Sort-Object Name
)

if ($illustrations.Count -eq 0) {
    throw "No illustration PNG files found in $sourceDirectory"
}

foreach ($illustration in $illustrations) {
    $name = $illustration.BaseName

    if ($name -notmatch '^[a-z0-9]+(?:_[a-z0-9]+)*$') {
        throw "Invalid illustration name: $($illustration.Name)"
    }

    $dimensions =
        & $magick.Source identify `
            -format '%w %h' `
            $illustration.FullName

    if ($LASTEXITCODE -ne 0) {
        throw "Could not inspect $($illustration.Name)"
    }

    $parts = $dimensions -split '\s+'
    $width = [int] $parts[0]
    $height = [int] $parts[1]

    if ($width -ne $imageWidth -or $height -ne $imageHeight) {
        throw (
            "$($illustration.Name) is ${width}x${height}; " +
            "expected ${imageWidth}x${imageHeight}. " +
            'Run tools\prepare_illustration.ps1 first.'
        )
    }
}

Remove-Item `
    (Join-Path $buildDirectory 'dst101_illustrations_*.png') `
    -Force `
    -ErrorAction SilentlyContinue

Remove-Item `
    (Join-Path $outputDirectory 'dst101_illustrations_*.xml') `
    -Force `
    -ErrorAction SilentlyContinue

Remove-Item `
    (Join-Path $outputDirectory 'dst101_illustrations_*.tex') `
    -Force `
    -ErrorAction SilentlyContinue

$culture =
    [System.Globalization.CultureInfo]::InvariantCulture

function Format-Uv {
    param(
        [double] $Value
    )

    return $Value.ToString(
        '0.########',
        $culture
    )
}


function Get-NextPowerOfTwo {
    param(
        [Parameter(Mandatory)]
        [int] $Value
    )

    $result = 1

    while ($result -lt $Value) {
        $result *= 2
    }

    return $result
}


$atlasRecords = [System.Collections.Generic.List[object]]::new()
$illustrationRecords = [System.Collections.Generic.List[object]]::new()

$atlasCount =
    [math]::Ceiling(
        $illustrations.Count / $imagesPerAtlas
    )

for ($atlasIndex = 0; $atlasIndex -lt $atlasCount; $atlasIndex++) {
    $atlasNumber = $atlasIndex + 1

    $atlasName =
        'dst101_illustrations_{0:D2}' -f $atlasNumber

    $atlasPng =
        Join-Path $buildDirectory "$atlasName.png"

    $atlasXml =
        Join-Path $outputDirectory "$atlasName.xml"

    $atlasTex =
        Join-Path $outputDirectory "$atlasName.tex"

    $start = $atlasIndex * $imagesPerAtlas

    $count = [math]::Min(
        $imagesPerAtlas,
        $illustrations.Count - $start
    )

    $atlasIllustrations =
        @($illustrations[$start..($start + $count - 1)])

    $usedColumns = [math]::Min(
        $columns,
        $atlasIllustrations.Count
    )

    $usedRows = [math]::Ceiling(
        $atlasIllustrations.Count / $columns
    )

    $currentAtlasWidth = Get-NextPowerOfTwo (
        $usedColumns * $cellWidth
    )

    $currentAtlasHeight = Get-NextPowerOfTwo (
        $usedRows * $cellHeight
    )

    if (
        $currentAtlasWidth -gt $atlasSize -or
        $currentAtlasHeight -gt $atlasSize
    ) {
        throw "Calculated atlas exceeds ${atlasSize}x${atlasSize}."
    }

    $magickArguments = @(
        '-size',
        "${currentAtlasWidth}x${currentAtlasHeight}",
        'xc:none'
    )

    $elements = [System.Collections.Generic.List[object]]::new()

    for ($localIndex = 0; $localIndex -lt $atlasIllustrations.Count; $localIndex++) {
        $illustration = $atlasIllustrations[$localIndex]

        $column = $localIndex % $columns
        $row = [math]::Floor($localIndex / $columns)

        $cellX = $column * $cellWidth
        $cellY = $row * $cellHeight

        $x =
            $cellX +
            [math]::Floor(
                ($cellWidth - $imageWidth) / 2
            )

        $y =
            $cellY +
            [math]::Floor(
                ($cellHeight - $imageHeight) / 2
            )

        $magickArguments += @(
            $illustration.FullName,
            '-geometry',
            "+$x+$y",
            '-composite'
        )

        $elements.Add(
            [PSCustomObject]@{
                Name = $illustration.BaseName
                X = $x
                Y = $y
                Width = $imageWidth
                Height = $imageHeight
            }
        )

        $illustrationRecords.Add(
            [PSCustomObject]@{
                Name = $illustration.BaseName
                AtlasName = $atlasName
            }
        )
    }

    $magickArguments += $atlasPng

    & $magick.Source @magickArguments

    if ($LASTEXITCODE -ne 0) {
        throw "ImageMagick failed while building $atlasName."
    }

    $xmlLines = @(
        '<Atlas>',
        "    <Texture filename=`"$atlasName.tex`" />",
        '    <Elements>'
    )

    foreach ($element in $elements) {
        # Half-pixel insets match the convention used by the existing topic
        # and UI atlas builders and reduce sampling from neighboring elements.
        $u1 =
            ($element.X + 0.5) /
            $currentAtlasWidth

        $u2 =
            (
                $element.X +
                $element.Width -
                0.5
            ) /
            $currentAtlasWidth

        $v1 =
            (
                $currentAtlasHeight -
                (
                    $element.Y +
                    $element.Height
                ) +
                0.5
            ) /
            $currentAtlasHeight

        $v2 =
            (
                $currentAtlasHeight -
                $element.Y -
                0.5
            ) /
            $currentAtlasHeight

        $xmlLines += (
            '        <Element name="{0}.tex" u1="{1}" u2="{2}" v1="{3}" v2="{4}" />' -f
                $element.Name,
                (Format-Uv $u1),
                (Format-Uv $u2),
                (Format-Uv $v1),
                (Format-Uv $v2)
        )
    }

    $xmlLines += @(
        '    </Elements>',
        '</Atlas>'
    )

    Set-Content `
        -Path $atlasXml `
        -Value $xmlLines `
        -Encoding utf8

    $containerInput =
        "/data/.build/illustrations/atlases/$atlasName.png"

    $containerOutput =
        "/data/images/illustrations/$atlasName.tex"

    & docker run --rm `
        -v "${projectRoot}:/data/" `
        dstmodders/ktools:4.5.1 `
        ktech --pow2 --extend `
        $containerInput `
        $containerOutput

    if ($LASTEXITCODE -ne 0) {
        throw "ktech failed while converting $atlasName."
    }

    $atlasRecords.Add(
        [PSCustomObject]@{
            Atlas =
                "images/illustrations/$atlasName.xml"
            Image =
                "images/illustrations/$atlasName.tex"
        }
    )
}

$manifest = [System.Collections.Generic.List[string]]::new()

$manifest.Add('return {')
$manifest.Add('    atlases = {')

foreach ($atlas in $atlasRecords) {
    $manifest.Add('        {')
    $manifest.Add(
        '            atlas = "' +
        $atlas.Atlas +
        '",'
    )
    $manifest.Add(
        '            image = "' +
        $atlas.Image +
        '",'
    )
    $manifest.Add('        },')
}

$manifest.Add('    },')
$manifest.Add('')
$manifest.Add('    illustrations = {')

foreach ($illustration in $illustrationRecords) {
    $manifest.Add(
        '        ' +
        $illustration.Name +
        ' = {'
    )
    $manifest.Add(
        '            atlas = "images/illustrations/' +
        $illustration.AtlasName +
        '.xml",'
    )
    $manifest.Add(
        '            texture = "' +
        $illustration.Name +
        '.tex",'
    )
    $manifest.Add('        },')
}

$manifest.Add('    },')
$manifest.Add('}')

Set-Content `
    -Path $manifestPath `
    -Value $manifest `
    -Encoding utf8

Write-Host
Write-Host (
    'Built {0} illustration(s) into {1} atlas file(s).' -f
        $illustrations.Count,
        $atlasCount
)

Write-Host
Write-Host 'Runtime atlases:'

Get-ChildItem $outputDirectory `
    -Filter 'dst101_illustrations_*' |
    Sort-Object Name |
    Select-Object Name, Length

Write-Host
Write-Host 'Generated manifest:'
Write-Host $manifestPath
