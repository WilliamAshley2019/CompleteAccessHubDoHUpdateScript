$action  = New-ScheduledTaskAction `
    -Execute 'powershell.exe' `
    -Argument '-NoProfile -ExecutionPolicy Bypass -File "C:\Tools\Update-CAHHosts.ps1"'

$trigger1 = New-ScheduledTaskTrigger -AtLogOn
$trigger2 = New-ScheduledTaskTrigger -Once -At (Get-Date) `
    -RepetitionInterval (New-TimeSpan -Hours 6)

$principal = New-ScheduledTaskPrincipal -UserId "$env:USERDOMAIN\$env:USERNAME" `
    -RunLevel Highest -LogonType S4U

Register-ScheduledTask -TaskName 'Update-CAHHosts' `
    -Action $action -Trigger $trigger1, $trigger2 `
    -Principal $principal -Description 'Refresh Complete Access Hub hosts entries' `
    -Force