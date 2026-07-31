# update_stats.ps1 - refresh the devlog's embedded DEV STATS panel.
# (ASCII only in this file: PowerShell 5.1 reads BOM-less scripts as ANSI.)
#
#   powershell -ExecutionPolicy Bypass -File Informational\update_stats.ps1
#
# Reads the git history and index.html, then rewrites the block between the
# STATS:BEGIN / STATS:END markers inside Informational\changelog.html. The
# stats are embedded inline (no external .js) so the page works anywhere,
# even where file:// subresources are blocked.
# Run it whenever you add a changelog entry so the panel stays honest.
#
# Any number it fails to derive becomes null, and the panel drops that tile
# rather than showing a zero. That matters: these are scraped out of source
# with regexes, so a rename should make a stat quietly disappear, never make
# the dashboard assert something false.

$ErrorActionPreference = 'Stop'
$inv = [Globalization.CultureInfo]::InvariantCulture
$root = (Resolve-Path (Join-Path $PSScriptRoot '..')).Path
Push-Location $root
try {
  # ------------------------------------------------------------------- git
  $commits = [int](git rev-list --count HEAD)
  $dates = @(git log --format='%ad' --date=format:'%Y-%m-%d')
  $devDays = @($dates | Sort-Object -Unique).Count

  # Commits grouped by calendar week (Monday start), oldest first.
  $weekGroups = @($dates | Group-Object {
    $d = [datetime]::ParseExact($_, 'yyyy-MM-dd', $inv)
    $d.AddDays(-((([int]$d.DayOfWeek) + 6) % 7)).ToString('yyyy-MM-dd')
  } | Sort-Object Name)
  $weekJson = @($weekGroups | ForEach-Object {
    $start = [datetime]::ParseExact($_.Name, 'yyyy-MM-dd', $inv)
    '  {{ "label": "Wk {0}", "commits": {1} }}' -f $start.ToString('MMM d', $inv), $_.Count
  })

  # ------------------------------------------------------------ the one file
  # The entire generator is index.html; there is no build and no src tree.
  $appPath = Join-Path $root 'index.html'
  $appLoc = (Get-Content $appPath | Measure-Object -Line).Lines
  $app = [IO.File]::ReadAllText($appPath)

  # Classes: every class definition (SRD or expansion) declares its hit die
  # exactly once as "hitDie: N". Usage sites read ".hitDie" and do not match.
  $classes = $null
  $n = ([regex]::Matches($app, 'hitDie:\s*\d+')).Count
  if ($n -gt 0) { $classes = $n }

  # Races: each race carries a languages ARRAY ("languages:[...]"), while
  # backgrounds store a number for extra languages, so the bracket is the
  # discriminator between the two.
  $races = $null
  $n = ([regex]::Matches($app, 'languages:\s*\[')).Count
  if ($n -gt 0) { $races = $n }

  # Spells: every entry in SPELLS / SPELLS_HI opens "lvl: N, school:".
  $spells = $null
  $n = ([regex]::Matches($app, 'lvl:\s*\d+,\s*school:')).Count
  if ($n -gt 0) { $spells = $n }

  # Feats: rows of the FEATS table, counted inside its block the way the
  # sibling projects count table rows -- a rename drops the tile.
  $feats = $null
  $inFeats = $false
  foreach ($line in Get-Content $appPath) {
    if ($line -match '^const FEATS = \{') { $inFeats = $true; continue }
    if ($inFeats) {
      if ($line -match '^\};') { break }
      if ($line -match '^\s{2}"[^"]+":\s*\{') { $feats = $feats + 1 }
    }
  }

  # ------------------------------------------------------------------ emit
  function J($v) { if ($null -eq $v) { 'null' } else { $v } }
  $js = @"
window.DEVLOG_STATS = {
  "generated": "$((Get-Date).ToString('MMM d, yyyy', $inv))",
  "commits": $(J $commits),
  "devDays": $(J $devDays),
  "appLoc": $(J $appLoc),
  "classes": $(J $classes),
  "races": $(J $races),
  "spells": $(J $spells),
  "feats": $(J $feats),
  "commitsByWeek": [
$($weekJson -join ",`n")
  ]
};
"@
  $utf8 = New-Object Text.UTF8Encoding $false
  $page = Join-Path $PSScriptRoot 'changelog.html'
  $html = [IO.File]::ReadAllText($page, $utf8)
  $pattern = '(?s)(// STATS:BEGIN[^\r\n]*\r?\n).*?(// STATS:END)'
  if ($html -notmatch $pattern) { throw 'changelog.html: STATS:BEGIN/STATS:END markers not found' }
  $html = [regex]::Replace($html, $pattern, { param($m) $m.Groups[1].Value + $js + "`r`n" + $m.Groups[2].Value })
  [IO.File]::WriteAllText($page, $html, $utf8)
  Write-Output "changelog.html stats updated: $commits commits, $appLoc LOC, $($weekGroups.Count) week(s)"
  Write-Output "  classes=$(J $classes) races=$(J $races) spells=$(J $spells) feats=$(J $feats)"
}
finally { Pop-Location }
