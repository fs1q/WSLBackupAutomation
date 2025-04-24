# WSL Backup Automation

PowerShell Script to automate the backup of a WSL Distribution

This project automates the backup of a Windows Subsystem for Linux (WSL) distribution, specifically designed to export the specified distribution to a designated backup directory.

## Requirements

- Windows 10 version 2004 and higher (Build 19041 and higher) or Windows 11.
- PowerShell.

## Features

- Automated Backup: Exports the specified WSL distribution to a tar file.
- Retention Policy: Keeps only the 3 most recent backup files, deleting older ones.
- Error Handling: Provides feedback on the success or failure of the backup and cleanup processes.

## WSL Backup Script

- PowerShell Script: `WSLBackupAutomation.ps1`
- Batch File: `RunWSLBackup.bat` (Optional)

### Automating Backups

You can automate the backup process using either Task Scheduler or a Windows Service. Below are the steps for each method.

#### Method 1: Using Task Scheduler

1. Open Task Scheduler:
   - Press `Windows + R`, type `taskschd.msc`, and hit `Enter`.

2. Create a New Task:
   - In the right pane, click on Create Basic Task.

3. Name Your Task:
   - Give your task a name (Example: "WSL Backup") and click Next.

4. Set the Trigger:
   - Choose how often you want the backup to run (Daily, Weekly, etc.) and click Next.
   - Configure the specific settings for the trigger and click Next.

5. Action:
   - Select Start a program and click Next.

6. Program/Script:
   - If you want to use the batch file, enter the path to `RunWSLBackup.bat` (Example: "C:\...\RunWSLBackup.bat").
   - If you prefer to run the PowerShell script directly, enter `powershell.exe` in the Program/script field and add the following in the "Add arguments (optional)" field:
     ```
     -ExecutionPolicy Bypass -File "C:\...\WSLBackupAutomation.ps1"
     ```

7. Finish:
   - Review your settings and click Finish to create the task.

#### Method 2: Using a Windows Service

If you prefer to run the backup as a Windows Service, you can use a tool like NSSM (Non-Sucking Service Manager) to create a service that runs your batch file or PowerShell script.

1. Download NSSM:
   - Download NSSM from nssm.cc and extract it to a folder.

2. Open Command Prompt as Administrator:
   - Press `Windows + X` and select Command Prompt (Admin) or Windows PowerShell (Admin).

3. Install the Service:
   - Navigate to the folder where you extracted NSSM using the `cd` command.
   - Run the following command to install the service:
     ```
     nssm install WSLBackupService
     ```

4. Configure the Service:
   - In the NSSM GUI that appears:
     - Path: Enter the path to `RunWSLBackup.bat` (Example:
     `C:\...\RunWSLBackup.bat`).
     - Startup directory: Set this to the directory where your batch file is located (Example:
     `C:\...\`).
     - Optionally, configure other settings like restart behavior.

5. Start the Service:
   - After configuring, click Install service.
   - You can start the service using the following command:
     ```
     nssm start WSLBackupService
     ```

### Conclusion

You now have two methods to automate the backup of your WSL distribution. Choose the one that best fits your needs. For any questions or issues, feel free to open an issue in this repository.

## License

This project is licensed under the [GNU General Public License (GPL)](https://www.gnu.org/licenses/gpl-3.0.html). You are free to use, modify, and distribute this software, but any derivative work must also be licensed under the GPL.
