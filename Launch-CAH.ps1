<#
.SYNOPSIS
    Refreshes CAH hosts entries, then launches Complete Access Hub.
#>

$ErrorActionPreference = 'Stop'

$UpdaterScript = 'C:\Tools\Update-CAHHosts.ps1'
$CAHExe        = 'C:\Program Files\Slate Digital Connect\Complete Access Hub.exe'

# 1. Refresh hosts (elevated; will prompt UAC)
Write-Host 'Refreshing hosts entries for Complete Access Hub...' -ForegroundColor Cyan
& powershell.exe -NoProfile -ExecutionPolicy Bypass -File $UpdaterScript
if ($LASTEXITCODE -ne 0) {
    Write-Host 'Hosts update failed. Continuing anyway, but CAH may not reach all endpoints.' -ForegroundColor Yellow
}

# 2. Launch CAH normally (NOT elevated - it will self-elevate when needed)
if (Test-Path -LiteralPath $CAHExe) {
    Write-Host 'Launching Complete Access Hub...' -ForegroundColor Cyan
    Start-Process -FilePath $CAHExe
} else {
    Write-Host "CAH executable not found at $CAHExe" -ForegroundColor Red
    exit 1
}