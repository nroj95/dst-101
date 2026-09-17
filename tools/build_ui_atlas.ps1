# =============================================================================
# dst 101 ui atlas builder
#
# builds one runtime atlas containing the standalone ui artwork:
# - dividers
# - fleur-de-lis footer dividers
# - page buttons
# - related-topic tiles
# - scrollbar handle
#
# source assets remain untouched.
# =============================================================================

$ErrorActionPreference = 'Stop'

$projectRoot = Split-Path $PSScriptRoot -Parent

$sourceDirectory = Join-Path $projectRoot 'source\assets\ui'
$buildDirectory = Join-Path $projectRoot '.build\ui'
$outputDirectory = Join-Path $projectRoot 'images\ui'

$atlasName = 'dst101_ui'
$atlasSize = 1024

$atlasPng = Join-Path $buildDirectory "$atlasName.png"
$atlasXml = Join-Path $outputDirectory "$atlasName.xml"
$atlasTex = Join-Path $outputDirectory "$atlasName.tex"

New-Item -ItemType Directory -Force -Path `
    $buildDirectory,
    $outputDirectory |
    Out-Null


# =============================================================================
# atlas layout
#
# each element uses the whole shared source canvas for its group.
# this preserves consistent alignment between related variants.
# =============================================================================

$assets = @(
    # related-topic tiles: 240 x 240
    @{
        Name = 'related_topic_tile_01'
        File = 'related_topic_tile_01.png'
        ExpectedSource = '1254x1254'
        X = 8
        Y = 8
        Width = 240
        Height = 240
    },
    @{
        Name = 'related_topic_tile_02'
        File = 'related_topic_tile_02.png'
        ExpectedSource = '1254x1254'
        X = 256
        Y = 8
        Width = 240
        Height = 240
    },
    @{
        Name = 'related_topic_tile_03'
        File = 'related_topic_tile_03.png'
        ExpectedSource = '1254x1254'
        X = 504
        Y = 8
        Width = 240
        Height = 240
    },
    @{
        Name = 'related_topic_tile_04'
        File = 'related_topic_tile_04.png'
        ExpectedSource = '1254x1254'
        X = 8
        Y = 256
        Width = 240
        Height = 240
    },
    @{
        Name = 'related_topic_tile_05'
        File = 'related_topic_tile_05.png'
        ExpectedSource = '1254x1254'
        X = 256
        Y = 256
        Width = 240
        Height = 240
    },
    @{
        Name = 'related_topic_tile_06'
        File = 'related_topic_tile_06.png'
        ExpectedSource = '1254x1254'
        X = 504
        Y = 256
        Width = 240
        Height = 240
    },

    # page buttons: 120 x 109
    @{
        Name = 'page_button_previous'
        File = 'page_button_previous.png'
        ExpectedSource = '473x429'
        X = 760
        Y = 8
        Width = 120
        Height = 109
    },
    @{
        Name = 'page_button_next'
        File = 'page_button_next.png'
        ExpectedSource = '473x429'
        X = 888
        Y = 8
        Width = 120
        Height = 109
    },

    # scrollbar handle: 56 x 240
    @{
        Name = 'slider_handle'
        File = 'slider_handle.png'
        ExpectedSource = '121x518'
        X = 856
        Y = 144
        Width = 56
        Height = 240
    },

    # content dividers: 496 x 25
    @{
        Name = 'divider_01'
        File = 'divider_01.png'
        ExpectedSource = '2112x106'
        X = 8
        Y = 496
        Width = 496
        Height = 25
    },
    @{
        Name = 'divider_02'
        File = 'divider_02.png'
        ExpectedSource = '2112x106'
        X = 520
        Y = 496
        Width = 496
        Height = 25
    },
    @{
        Name = 'divider_03'
        File = 'divider_03.png'
        ExpectedSource = '2112x106'
        X = 8
        Y = 534
        Width = 496
        Height = 25
    },
    @{
        Name = 'divider_04'
        File = 'divider_04.png'
        ExpectedSource = '2112x106'
        X = 520
        Y = 534
        Width = 496
        Height = 25
    },
    @{
        Name = 'divider_05'
        File = 'divider_05.png'
        ExpectedSource = '2112x106'
        X = 8
        Y = 572
        Width = 496
        Height = 25
    },
    @{
        Name = 'divider_06'
        File = 'divider_06.png'
        ExpectedSource = '2112x106'
        X = 520
        Y = 572
        Width = 496
        Height = 25
    },

    # optional note artwork
    @{
        Name = 'note_strip'
        File = 'note_strip.png'
        ExpectedSource = '2067x439'
        X = 8
        Y = 728
        Width = 496
        Height = 105
    },
    @{
        Name = 'note_animal_crow'
        File = 'note_animal_crow.png'
        ExpectedSource = '1031x1172'
        X = 520
        Y = 728
        Width = 152
        Height = 173
    },
    @{
        Name = 'note_animal_catcoon'
        File = 'note_animal_catcoon.png'
        ExpectedSource = '1222x990'
        X = 680
        Y = 728
        Width = 176
        Height = 143
    },
    @{
        Name = 'note_animal_splumonkey'
        File = 'note_animal_splumonkey.png'
        ExpectedSource = '1073x1221'
        X = 864
        Y = 728
        Width = 152
        Height = 173
    },

    # footer dividers: 496 x 82
    @{
        Name = 'fleur_de_lis_divider'
        File = 'fleur_de_lis_divider.png'
        ExpectedSource = '1722x286'
        X = 8
        Y = 616
        Width = 496
        Height = 82
    },
    @{
        Name = 'fleur_de_lis_divider_asymmetric'
        File = 'fleur_de_lis_divider_asymmetric.png'
        ExpectedSource = '1722x286'
        X = 520
        Y = 616
        Width = 496
        Height = 82
    }
)


# =============================================================================
# validation
# =============================================================================

foreach ($asset in $assets) {
    $sourcePath = Join-Path $sourceDirectory $asset.File

    if (-not (Test-Path $sourcePath)) {
        throw "Missing source asset: $sourcePath"
    }

    $sourceSize = & magick identify `
        -format '%wx%h' `
        $sourcePath

    if ($sourceSize -ne $asset.ExpectedSource) {
        throw (
            "Unexpected source size for {0}: expected {1}, got {2}" -f
                $asset.File,
                $asset.ExpectedSource,
                $sourceSize
        )
    }

    if (
        $asset.X -lt 0 -or
        $asset.Y -lt 0 -or
        ($asset.X + $asset.Width) -gt $atlasSize -or
        ($asset.Y + $asset.Height) -gt $atlasSize
    ) {
        throw "Atlas element lies outside the atlas: $($asset.Name)"
    }
}

for ($leftIndex = 0; $leftIndex -lt $assets.Count; $leftIndex++) {
    $left = $assets[$leftIndex]

    for (
        $rightIndex = $leftIndex + 1;
        $rightIndex -lt $assets.Count;
        $rightIndex++
    ) {
        $right = $assets[$rightIndex]

        $overlaps = (
            $left.X -lt ($right.X + $right.Width) -and
            ($left.X + $left.Width) -gt $right.X -and
            $left.Y -lt ($right.Y + $right.Height) -and
            ($left.Y + $left.Height) -gt $right.Y
        )

        if ($overlaps) {
            throw (
                "Atlas elements overlap: {0} and {1}" -f
                    $left.Name,
                    $right.Name
            )
        }
    }
}


# =============================================================================
# atlas png generation
# =============================================================================

$arguments = @(
    '-size',
    "${atlasSize}x${atlasSize}",
    'xc:none'
)

foreach ($asset in $assets) {
    $sourcePath = Join-Path $sourceDirectory $asset.File

    $arguments += '('
    $arguments += $sourcePath
    $arguments += '-filter'
    $arguments += 'Lanczos'
    $arguments += '-resize'
    $arguments += "$($asset.Width)x$($asset.Height)!"
    $arguments += ')'

    $arguments += '-geometry'
    $arguments += "+$($asset.X)+$($asset.Y)"

    $arguments += '-composite'
}

$arguments += '-define'
$arguments += 'png:color-type=6'
$arguments += $atlasPng

& magick @arguments

if ($LASTEXITCODE -ne 0) {
    throw 'ImageMagick failed while building the ui atlas.'
}


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

$lines = @(
    '<?xml version="1.0"?>',
    '<Atlas>',
    "    <Texture filename=`"$atlasName.tex`" />",
    '    <Elements>'
)

foreach ($asset in $assets) {
    # Half-pixel inset matches the topic-atlas/Klei UV convention.
    $u1 = ($asset.X + 0.5) / $atlasSize
    $u2 = (
        $asset.X + $asset.Width - 0.5
    ) / $atlasSize

    $v1 = (
        $atlasSize -
        ($asset.Y + $asset.Height) +
        0.5
    ) / $atlasSize

    $v2 = (
        $atlasSize -
        $asset.Y -
        0.5
    ) / $atlasSize

    $lines += (
        '        <Element name="{0}.tex" u1="{1}" u2="{2}" v1="{3}" v2="{4}" />' -f
            $asset.Name,
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
    -Path $atlasXml `
    -Value $lines `
    -Encoding utf8


# =============================================================================
# tex conversion
# =============================================================================

$containerInput = "/data/.build/ui/$atlasName.png"
$containerOutput = "/data/images/ui/$atlasName.tex"

& docker run --rm `
    -v "${projectRoot}:/data/" `
    dstmodders/ktools:4.5.1 `
    ktech --pow2 --extend `
    $containerInput `
    $containerOutput

if ($LASTEXITCODE -ne 0) {
    throw 'ktech failed while converting the ui atlas.'
}


# =============================================================================
# summary
# =============================================================================

Write-Host
Write-Host 'Generated UI atlas:'

Get-Item `
    $atlasPng,
    $atlasXml,
    $atlasTex |
    Select-Object Name, Length

Write-Host
Write-Host 'Elements:'

$assets |
    Select-Object Name, X, Y, Width, Height |
    Format-Table -AutoSize

