[CmdletBinding()]
param(
    [ValidateSet('Summary', 'Names', 'Details', 'Full')]
    [string] $View = 'Summary'
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$repoRoot = Split-Path -Parent $PSScriptRoot
$dataPath = Join-Path $repoRoot 'scripts\dst101data.lua'
$topicDirectory = Join-Path $repoRoot 'scripts\dst101topics'

if (-not (Test-Path -LiteralPath $dataPath)) {
    throw "Could not find topic loader: $dataPath"
}

# dst101data.lua is the source of truth for sidebar order.
$topicNames = Get-Content -LiteralPath $dataPath |
    ForEach-Object {
        if ($_ -match '^\s*"dst101topics/([^"]+)",?\s*$') {
            $Matches[1]
        }
    }

if (-not $topicNames) {
    throw "No topic entries were found in $dataPath"
}

function Get-LuaStringField {
    param(
        [Parameter(Mandatory)]
        [string] $Text,

        [Parameter(Mandatory)]
        [string] $Field
    )

    $escapedField = [regex]::Escape($Field)
    $match = [regex]::Match(
        $Text,
        "(?m)^\s*$escapedField\s*=\s*`"([^`"]+)`""
    )

    if ($match.Success) {
        return $match.Groups[1].Value
    }

    return $null
}

$topics = foreach ($topicName in $topicNames) {
    $topicPath = Join-Path $topicDirectory "$topicName.lua"

    if (-not (Test-Path -LiteralPath $topicPath)) {
        throw "Topic listed in dst101data.lua does not exist: $topicPath"
    }

    $text = Get-Content -LiteralPath $topicPath -Raw

    # Every authored page has one regions table.
    $pageCount = [regex]::Matches(
        $text,
        '(?m)^\s*regions\s*=\s*\{\s*$'
    ).Count

    $pageHeadings = @(
        [regex]::Matches(
            $text,
            'type\s*=\s*"page_heading"\s*,\s*text\s*=\s*"([^"]+)"'
        ) | ForEach-Object {
            $_.Groups[1].Value
        }
    )

    $illustrations = @(
        [regex]::Matches(
            $text,
            '(?m)^\s*illustration\s*=\s*"([^"]+)"'
        ) | ForEach-Object {
            $_.Groups[1].Value
        }
    )

    [pscustomobject]@{
        Name          = $topicName
        Title         = Get-LuaStringField -Text $text -Field 'title'
        Id            = Get-LuaStringField -Text $text -Field 'id'
        Pages         = $pageCount
        PageHeadings  = $pageHeadings
        Illustrations = $illustrations
        Path          = $topicPath
    }
}

switch ($View) {
    'Names' {
        $topics.Name
        break
    }

    'Details' {
        for ($index = 0; $index -lt $topics.Count; $index++) {
            $topic = $topics[$index]

            '{0,2}. {1} [{2}]' -f ($index + 1), $topic.Title, $topic.Name
            "    pages: $($topic.Pages)"

            if ($topic.PageHeadings.Count -gt 0) {
                "    secondary: $($topic.PageHeadings -join ' | ')"
            }

            if ($topic.Illustrations.Count -gt 0) {
                "    illustrations: $($topic.Illustrations -join ' | ')"
            }

            ''
        }

        break
    }

    'Full' {
        foreach ($topic in $topics) {
            "`n$('=' * 80)"
            "  $($topic.Name).lua"
            "$('=' * 80)`n"

            Get-Content -LiteralPath $topic.Path
        }

        break
    }

    default {
        $rows = for ($index = 0; $index -lt $topics.Count; $index++) {
            $topic = $topics[$index]

            [pscustomobject]@{
                '#'     = $index + 1
                Topic   = $topic.Name
                Title   = $topic.Title
                Pages   = $topic.Pages
            }
        }

        $rows | Format-Table -AutoSize

        $totalPages = ($topics | Measure-Object -Property Pages -Sum).Sum
        $multiPageTopics = @($topics | Where-Object Pages -gt 1).Count

        ''
        '-- totals --'
        "topics:           $($topics.Count)"
        "pages:            $totalPages"
        "multi-page topics: $multiPageTopics"
    }
}
