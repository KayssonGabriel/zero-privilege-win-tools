:: UserSupportToolkit/SystemMaintenance/Run-TempClean.bat

@echo off
set "SCRIPT_PATH=%~dp0Clean-UserTemp.ps1"
PowerShell.exe -NoProfile -ExecutionPolicy Bypass -File "%SCRIPT_PATH%"