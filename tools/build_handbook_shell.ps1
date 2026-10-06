#Requires -Version 7.0

# =============================================================================
# dst 101 handbook-shell builder
#
# converts the two full-size handbook shells into standalone runtime KTEX
# atlases. handbook_page is the normal framed shell; handbook_base is the
# frameless shell reserved for pages such as the table of contents.
# =============================================================================

[CmdletBinding()]
param()

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$projectRoot = Split-Path -Parent $PSScriptRoot
$sourceDirectory = Join-Path $projectRoot 'source\assets\ui'
$outputDirectory = Join-Path $projectRoot 'images\ui'

$assets = @(
    [pscustomobject]@{
        Name = 'handbook_base'
        Width = 1533
        Height = 865
    },
    [pscustomobject]@{
        Name = 'handbook_page'
        Width = 1533
        Height = 865
    }
)


# =============================================================================
# helpers
# =============================================================================

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

function Format-Uv {
    param(
        [Parameter(Mandatory)]
        [double] $Value
    )

    return $Value.ToString(
        '0.#########',
        [System.Globalization.CultureInfo]::InvariantCulture
    )
}

function Build-HandbookAsset {
    param(
        [Parameter(Mandatory)]
        [pscustomobject] $Asset
    )

    $sourcePath =
        Join-Path $sourceDirectory "$($Asset.Name).png"

    $xmlPath =
        Join-Path $outputDirectory "$($Asset.Name).xml"

    $texPath =
        Join-Path $outputDirectory "$($Asset.Name).tex"

    if (-not (Test-Path $sourcePath)) {
        throw "Missing source asset: $sourcePath"
    }

    $sourceSize = & magick identify `
        -format '%wx%h' `
        $sourcePath

    if ($LASTEXITCODE -ne 0) {
        throw "ImageMagick failed while reading $($Asset.Name).png."
    }

    $expectedSize =
        "$($Asset.Width)x$($Asset.Height)"

    if ($sourceSize -ne $expectedSize) {
        throw (
            'Unexpected {0}.png size: expected {1}, got {2}.' -f
                $Asset.Name,
                $expectedSize,
                $sourceSize
        )
    }

    $containerInput =
        "/data/source/assets/ui/$($Asset.Name).png"

    $containerOutput =
        "/data/images/ui/$($Asset.Name).tex"

    $dockerOutput = & docker run --rm `
        -v "${projectRoot}:/data/" `
        dstmodders/ktools:4.5.1 `
        ktech --pow2 --extend `
        $containerInput `
        $containerOutput

    $dockerExitCode = $LASTEXITCODE
    $dockerOutput | Out-Host

    if ($dockerExitCode -ne 0) {
        throw "ktech failed while building $($Asset.Name).tex."
    }

    $textureWidth =
        Get-NextPowerOfTwo -Value $Asset.Width

    $textureHeight =
        Get-NextPowerOfTwo -Value $Asset.Height

    # Half-pixel insets match DST/Klei atlas UV conventions.
    $u1 = 0.5 / $textureWidth
    $u2 = ($Asset.Width - 0.5) / $textureWidth

    $v1 = (
        $textureHeight -
        $Asset.Height +
        0.5
    ) / $textureHeight

    $v2 = (
        $textureHeight -
        0.5
    ) / $textureHeight

    $lines = @(
        '<?xml version="1.0"?>',
        '<Atlas>',
        "    <Texture filename=`"$($Asset.Name).tex`" />",
        '    <Elements>',
        (
            '        <Element name="{0}.tex" u1="{1}" u2="{2}" v1="{3}" v2="{4}" />' -f
                $Asset.Name,
                (Format-Uv -Value $u1),
                (Format-Uv -Value $u2),
                (Format-Uv -Value $v1),
                (Format-Uv -Value $v2)
        ),
        '    </Elements>',
        '</Atlas>'
    )

    [IO.File]::WriteAllText(
        $xmlPath,
        (($lines -join "`n") + "`n"),
        [Text.UTF8Encoding]::new($false)
    )

    return Get-Item $sourcePath, $xmlPath, $texPath
}


# =============================================================================
# build
# =============================================================================

New-Item `
    -ItemType Directory `
    -Force `
    -Path $outputDirectory |
    Out-Null

$results = foreach ($asset in $assets) {
    Build-HandbookAsset -Asset $asset
}

Write-Host
Write-Host 'Generated handbook shell assets:'

$results |
    Select-Object Name, Length, LastWriteTime |
    Format-Table -AutoSize
