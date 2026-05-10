:: UserSupportToolkit/ADPolicySync/Run-ADSync.bat

@echo off
set "SCRIPT_PATH=%~dp0Sync-ADUserPolicy.ps1"
PowerShell.exe -NoProfile -ExecutionPolicy Bypass -File "%SCRIPT_PATH%"