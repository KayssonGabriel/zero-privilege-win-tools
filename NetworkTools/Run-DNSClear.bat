:: UserSupportToolkit/NetworkTools/Run-DNSClear.bat

@echo off
set "SCRIPT_PATH=%~dp0Clear-UserDNS.ps1"
PowerShell.exe -NoProfile -ExecutionPolicy Bypass -File "%SCRIPT_PATH%"