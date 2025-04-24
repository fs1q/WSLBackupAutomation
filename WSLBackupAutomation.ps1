############################################################
#                                                          #
#  Script: WSLBackupAutomation                             #
#  Last Updated: 2025-04-23                  Version 1.1   #
#  Written by: Fabio Siqueira                              #
#                                                          #
############################################################
# PowerShell Script to automate the backup of a WSL        #
# Distribution                                             #
############################################################

# Settings
$distributionName = "Ubuntu" # WSL distribution to export
$backupDir = "C:\..." # Directory for backups

# Create the backup file name with the current date
$backupFile = "ubuntu_export_$(Get-Date -Format 'yyyy-MM-dd').tar"
$backupPath = Join-Path -Path $backupDir -ChildPath $backupFile

# Execute the export command
wsl --export $distributionName $backupPath
Write-Host "Backup created: $backupPath"

# Cleanup old backups (keep only the latest one)
$files = Get-ChildItem -Path $backupDir -Filter "ubuntu_export_*.tar" | Sort-Object LastWriteTime -Descending
if ($files.Count -gt 1) {
    Remove-Item -Path $files[1..($files.Count - 1)].FullName -Force
    Write-Host "Deleted old backups, keeping the latest one."
}
