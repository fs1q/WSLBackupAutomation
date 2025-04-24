############################################################
#                                                          #
#  Script: WSLBackupAutomation                             #
#  Last Updated: 2025-04-23                  Version 1.0   #
#  Written by: Fabio Siqueira                              #
#                                                          #
############################################################
# PowerShell Script to automate the backup of a WSL        #
# Distribution                                             #
############################################################

# Settings
$distributionName = "Ubuntu" # WSL Distribution to export
$backupDir = "C:\..." # Directory for backups

# Create the backup file name with the current date
$backupFile = "ubuntu_export_$(Get-Date -Format 'yyyy-MM-dd').tar"
$backupPath = Join-Path -Path $backupDir -ChildPath $backupFile

# Execute the export command
wsl --export $distributionName $backupPath
Write-Host "Backup created: $backupPath"
