# WSLBackupAutomation

## Description

PowerShell Script to automate the backup of a WSL Distribution

This project automates the backup of a Windows Subsystem for Linux (WSL) distribution, specifically designed to export the specified distribution to a designated backup directory.



## Features

- Automated Backup: Exports the specified WSL distribution to a tar file.
- Retention Policy: Keeps only the 3 most recent backup files, deleting older ones.
- Error Handling: Provides feedback on the success or failure of the backup and cleanup processes.



## Requirements

- Windows 10 version 2004 and higher (Build 19041 and higher) or Windows 11.
- PowerShell.



## Installation

1. Clone the Repository:
   git clone https://github.com/fs1q/WSLBackupAutomation.git
   cd WSLBackupAutomation

2. Edit the Script:
   - Open the 'WSLBackupAutomation.ps1' file in a text editor.
   - Update the '$distributionName' variable to match the name of your WSL distribution (e.g., "Ubuntu").
   - Set the '$backupDir' variable to the desired backup directory path.



## Usage

1. Run the Script Manually:
   - Open PowerShell.
   - Navigate to the directory where the script is located.
   - Execute the script:
     .\WSLBackupAutomation.ps1

2. Check Backup Directory:
   - After running the script, check the specified backup directory to confirm that the backup file has been created and that old backups have been cleaned up according to the retention policy.



## Automating with Task Scheduler

To automate the backup process, you can use Windows Task Scheduler to run the PowerShell script at specified intervals. Follow these steps:

1. Open Task Scheduler:
   - Press 'Win + R', type 'taskschd.msc', and press Enter.

2. Create a New Task:
   - Click on "Create Task..." in the right-hand Actions pane.

3. General Tab:
   - Name your task (suggestion: "WSL Backup").
   - Select "Run only when user is logged on".

4. Triggers Tab:
   - Click "New..." and set the task to begin "On a schedule".
   - Choose "Daily" and set the time you desire. Configure the advanced settings according to your needs.

5. Actions Tab:
   - Click "New...".
   - Set Action to "Start a program".
   - In Program/script, enter 'powershell.exe'.
   - In Add arguments (optional), enter:
     -ExecutionPolicy Bypass -File "C:\...\WSLBackupAutomation.ps1"
   - Replace "C:\...\WSLBackupAutomation.ps1" with the actual path to your script.

6. Conditions and Settings Tabs:
   - Adjust any additional settings as needed, then click OK to save the task.



## License

This project is licensed under the [GNU General Public License (GPL)](https://www.gnu.org/licenses/gpl-3.0.html). You are free to use, modify, and distribute this software, but any derivative work must also be licensed under the GPL.
