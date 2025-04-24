@echo off
REM Change the path to where your PowerShell Script is located
set PowerShellScriptPath="C:\...\WSLBackupAutomation.ps1"

REM Execute the PowerShell Script
powershell -ExecutionPolicy Bypass -File %PowerShellScriptPath%

pause
