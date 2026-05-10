:: UserSupportToolkit/UIRepair/Run-ExplorerReset.bat

@echo off
set "SCRIPT_PATH=%~dp0Reset-Explorer.ps1"
PowerShell.exe -NoProfile -ExecutionPolicy Bypass -File "%SCRIPT_PATH%"