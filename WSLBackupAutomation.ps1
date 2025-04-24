############################################################
#                                                          #
#  Script: WSLBackupAutomation                             #
#  Last Updated: 2025-04-24                  Version 1.4   #
#  Written by: Fabio Siqueira                              #
#                                                          #
############################################################
# PowerShell Script to automate the backup of a WSL        #
# Distribution                                             #
############################################################

# Settings - You need to configure this part!
param (
    [string]$distributionName = "Distribution", #Example: "Ubuntu"
    [string]$backupDir = "C:\..." #Example: "C:\WSLBackup"
)

# Check if backup directory exists, if not, create it
if (-not (Test-Path -Path $backupDir)) {
    New-Item -ItemType Directory -Path $backupDir
    Write-Host "Backup directory created: $backupDir"
}

# Create the backup file name with the current date and time
$backupFile = "wsl_export_$(Get-Date -Format 'yyyy-MM-dd_HH-mm-ss').tar"
$backupPath = Join-Path -Path $backupDir -ChildPath $backupFile

# Function to export the WSL distribution
function Export-WSL {
    try {
        wsl --export $distributionName $backupPath
        Write-Host "Backup created: $backupPath"
    } catch {
        Write-Host "Error during export: $_"
    }
}

# Function to clean up old backup files
function Clean-Up-OldBackups {
    # Get all backup files matching the new pattern
    $files = Get-ChildItem -Path $backupDir -Filter "wsl_export_*.tar" | Sort-Object LastWriteTime -Descending

    if ($files.Count -gt 3) {
        $filesToDelete = $files[3..($files.Count - 1)]
        foreach ($file in $filesToDelete) {
            try {
                Remove-Item -Path $file.FullName -Force
                Write-Host "Deleted old backup: $($file.FullName)"
            } catch {
                Write-Host "Error deleting file: $_"
            }
        }
    } else {
        Write-Host "No old backups to delete. Keeping the latest 3 files."
    }
}

# Running Script
Write-Host "Starting WSL backup process..."
Export-WSL
Clean-Up-OldBackups
