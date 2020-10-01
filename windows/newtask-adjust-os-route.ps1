$Trigger = New-ScheduledTaskTrigger -AtStartup
$Action = New-ScheduledTaskAction -Execute "PowerShell.exe" -Argument "-ExecutionPolicy Bypass -Command C:\infra_scripts\adjust_os_route.ps1"
$Settings = New-ScheduledTaskSettingsSet -AllowStartIfOnBatteries -Compatibility Win8

Register-ScheduledTask -TaskName "AdjustOSRoute" -TaskPath "\InfraTask\" -User "SYSTEM" -RunLevel Highest -Trigger $Trigger -Action $Action -Settings $Settings
