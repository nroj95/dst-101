#Requires -Version 7.0

# =============================================================================
# dst 101 base-template builder
#
# converts the authored 1533x865 handbook backdrop into the runtime KTEX.
# the existing XML UVs remain valid as long as the source dimensions stay
# exactly 1533x865.
# =============================================================================

[CmdletBinding()]
param()

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$projectRoot = Split-Path -Parent $PSScriptRoot

$sourcePath =
    Join-Path $projectRoot 'source\assets\ui\base_template.png'

$xmlPath =
    Join-Path $projectRoot 'images\ui\base_template.xml'

$texPath =
    Join-Path $projectRoot 'images\ui\base_template.tex'

$expectedWidth = 1533
$expectedHeight = 865


# =============================================================================
# validation
# =============================================================================

if (-not (Test-Path $sourcePath)) {
    throw "Missing source asset: $sourcePath"
}

if (-not (Test-Path $xmlPath)) {
    throw "Missing runtime atlas XML: $xmlPath"
}

$sourceSize = & magick identify `
    -format '%wx%h' `
    $sourcePath

$expectedSize =
    "${expectedWidth}x${expectedHeight}"

if ($sourceSize -ne $expectedSize) {
    throw (
        "Unexpected base_template.png size: expected {0}, got {1}. " +
        "The existing XML UVs would need to be regenerated." -f
            $expectedSize,
            $sourceSize
    )
}


# =============================================================================
# tex conversion
# =============================================================================

$containerInput =
    '/data/source/assets/ui/base_template.png'

$containerOutput =
    '/data/images/ui/base_template.tex'

& docker run --rm `
    -v "${projectRoot}:/data/" `
    dstmodders/ktools:4.5.1 `
    ktech --pow2 --extend `
    $containerInput `
    $containerOutput

if ($LASTEXITCODE -ne 0) {
    throw 'ktech failed while rebuilding base_template.tex.'
}


# =============================================================================
# summary
# =============================================================================

Write-Host
Write-Host 'Generated base template:'

Get-Item `
    $sourcePath,
    $xmlPath,
    $texPath |
    Select-Object Name, Length, LastWriteTime
