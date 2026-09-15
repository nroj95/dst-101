Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$projectRoot = (Resolve-Path (Join-Path $PSScriptRoot '..')).Path

$bmfont = 'D:\toolbox\graphics\bmfont-1.14b\bmfont64.exe'
$dockerImage = 'dstmodders/ktools:4.5.1'

$sourceDir = Join-Path $projectRoot 'source\fonts\alegreya'
$charsetPath = Join-Path $sourceDir 'charset.txt'

$buildRoot = Join-Path $projectRoot '.build\fonts'
$runtimeDir = Join-Path $projectRoot 'fonts'

$variants = @(
    @{
        Name = 'dst101_alegreya_regular'
        File = 'Alegreya-Regular.ttf'
    },
    @{
        Name = 'dst101_alegreya_italic'
        File = 'Alegreya-Italic.ttf'
    }
)

if (-not (Test-Path $bmfont)) {
    throw "BMFont not found: $bmfont"
}

if (-not (Test-Path $charsetPath)) {
    throw "Character set not found: $charsetPath"
}

if (-not (Get-Command docker -ErrorAction SilentlyContinue)) {
    throw 'Docker was not found in PATH.'
}

New-Item -ItemType Directory -Force -Path $buildRoot | Out-Null
New-Item -ItemType Directory -Force -Path $runtimeDir | Out-Null

foreach ($variant in $variants) {
    $name = $variant.Name
    $fontFile = Join-Path $sourceDir $variant.File

    if (-not (Test-Path $fontFile)) {
        throw "Font source not found: $fontFile"
    }

    Write-Host
    Write-Host "Building $name..."

    $buildDir = Join-Path $buildRoot $name

    if (Test-Path $buildDir) {
        Remove-Item $buildDir -Recurse -Force
    }

    New-Item -ItemType Directory -Force -Path $buildDir | Out-Null

    $configPath = Join-Path $buildDir 'font.bmfc'
    $outputFnt = Join-Path $buildDir 'font.fnt'
    $outputPng = Join-Path $buildDir 'font_0.png'
    $outputTex = Join-Path $buildDir 'font.tex'
    $runtimeZip = Join-Path $runtimeDir "$name.zip"

    @"
# AngelCode Bitmap Font Generator configuration file
fileVersion=1

# font settings
fontName=Alegreya
fontFile=$fontFile
charSet=0
fontSize=50
aa=1
scaleH=100
useSmoothing=1
isBold=0
isItalic=0
useUnicode=1
disableBoxChars=1
outputInvalidCharGlyph=0
dontIncludeKerningPairs=0
useHinting=1
renderFromOutline=1
useClearType=0
autoFitNumPages=0
autoFitFontSizeMin=0
autoFitFontSizeMax=0

# character alignment
paddingDown=1
paddingUp=1
paddingRight=1
paddingLeft=1
spacingHoriz=2
spacingVert=2
useFixedHeight=0
forceZero=0
widthPaddingFactor=0.00

# output file
outWidth=1024
outHeight=1024
outBitDepth=32
fontDescFormat=1
fourChnlPacked=0
textureFormat=png
textureCompression=0
alphaChnl=1
redChnl=0
greenChnl=0
blueChnl=0
invA=0
invR=0
invG=0
invB=0

# outline
outlineThickness=0

# selected chars

# imported icon images
"@ | Set-Content $configPath -Encoding ascii

    $process = Start-Process `
        -FilePath $bmfont `
        -ArgumentList @(
            '-c', "`"$configPath`"",
            '-t', "`"$charsetPath`"",
            '-o', "`"$outputFnt`""
        ) `
        -Wait `
        -PassThru

    if ($process.ExitCode -ne 0) {
        throw "BMFont failed for $name with exit code $($process.ExitCode)."
    }

    if (-not (Test-Path $outputPng)) {
        throw "BMFont did not create: $outputPng"
    }

    $dockerPng = "/data/.build/fonts/$name/font_0.png"
    $dockerTex = "/data/.build/fonts/$name/font.tex"

    & docker run --rm `
        -v "${projectRoot}:/data/" `
        $dockerImage `
        ktech `
            --compression dxt5 `
            --type 2d `
            $dockerPng `
            $dockerTex

    if ($LASTEXITCODE -ne 0) {
        throw "ktech failed for $name."
    }

    if (-not (Test-Path $outputTex)) {
        throw "ktech did not create: $outputTex"
    }

    Remove-Item $runtimeZip -Force -ErrorAction SilentlyContinue

    Compress-Archive `
        -Path $outputFnt, $outputTex `
        -DestinationPath $runtimeZip

    $zipContents = @(tar -tf $runtimeZip)

    if (
        $zipContents.Count -ne 2 -or
        'font.fnt' -notin $zipContents -or
        'font.tex' -notin $zipContents
    ) {
        throw "Unexpected contents in $runtimeZip."
    }

    Write-Host "Created fonts\$name.zip"
}

Write-Host
Write-Host 'Built Alegreya fonts:'

Get-ChildItem $runtimeDir -Filter 'dst101_alegreya_*.zip' |
    Select-Object Name, Length |
    Format-Table -AutoSize

