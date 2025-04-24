############################################################
#                                                          #
#  Script: WSLBackupAutomation                             #
#  Last Updated: 2025-04-23                  Version 1.3   #
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

# Function to export the WSL distribution
function Export-WSL {
    try {
        # Execute the export command
        wsl --export $distributionName $backupPath
        Write-Host "Backup created: $backupPath"
    } catch {
        Write-Host "Error during export: $_"
    }
}

# Function to clean up old backup files
function Clean-Up-OldBackups {
    # Get all backup files, sorted by last write time (newest first)
    $files = Get-ChildItem -Path $backupDir -Filter "ubuntu_export_*.tar" | Sort-Object LastWriteTime -Descending

    # Check if there are more than 3 files
    if ($files.Count -gt 3) {
        # Select files to delete (all except the 3 most recent)
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
