# Install Grok AI Memory wrapper into ~/.grok (does not install Docker server)
param(
    [switch]$Project,
    [switch]$WireHooks,
    [string]$KitRoot = (Split-Path -Parent $PSScriptRoot)
)

$ErrorActionPreference = "Stop"

if ($Project) {
    $base = Join-Path (Get-Location) ".grok"
    Write-Host "Install mode: PROJECT -> $base"
} else {
    $base = Join-Path $env:USERPROFILE ".grok"
    Write-Host "Install mode: GLOBAL -> $base"
}

$skills = Join-Path $base "skills"
$commands = Join-Path $base "commands"
$dst = Join-Path $skills "ai-memory"
$docsDst = Join-Path $dst "docs"

New-Item -ItemType Directory -Force -Path $skills, $commands, $dst, $docsDst | Out-Null
Copy-Item -Recurse -Force (Join-Path $KitRoot "skills\ai-memory\*") $dst
Copy-Item -Force (Join-Path $KitRoot "docs\grok-pi-setup.md") (Join-Path $docsDst "grok-pi-setup.md")
Write-Host "  skill: ai-memory"

Get-ChildItem (Join-Path $KitRoot "commands") -Filter "*.md" | ForEach-Object {
    Copy-Item -Force $_.FullName (Join-Path $commands $_.Name)
    Write-Host "  command: $($_.Name)"
}

$cli = Get-Command ai-memory -ErrorAction SilentlyContinue
if ($cli) {
    Write-Host "  ai-memory CLI: found at $($cli.Source)"
    if ($WireHooks) {
        Write-Host "  wiring hooks --agent grok ..."
        & ai-memory install-hooks --agent grok --apply
        Write-Host "  (optional) wire Pi: ai-memory install-hooks --agent pi --apply"
    }
} else {
    Write-Host "  ai-memory CLI: NOT on PATH"
    Write-Host "  Install server+CLI first (Docker). See skill docs/grok-pi-setup.md"
}

Write-Host ""
Write-Host "Done. Wrapper only - start ai-memory server separately."
Write-Host "  Try: /memory-status  |  /memory-handoff  |  /memory-search topic"
Write-Host "  Setup guide: $docsDst\grok-pi-setup.md"
Write-Host "  Wire hooks when ready: .\scripts\install.ps1 -WireHooks"
