############################################################
#                                                          #
#  Script: WSLBackupAutomation                             #
#  Last Updated: 2025-04-23                  Version 1.2   #
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

# Cleanup old backups (keep only the 3 most recent)
$files = Get-ChildItem -Path $backupDir -Filter "ubuntu_export_*.tar" | Sort-Object LastWriteTime -Descending
if ($files.Count -gt 3) {
    $filesToDelete = $files[3..($files.Count - 1)]
    foreach ($file in $filesToDelete) {
        Remove-Item -Path $file.FullName -Force
        Write-Host "Deleted old backup: $($file.FullName)"
    }
} else {
    Write-Host "No old backups to delete. Keeping the latest 3 files."
}
