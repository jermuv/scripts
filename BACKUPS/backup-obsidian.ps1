# purpose of the script:
# to do daily backups of the obsidian database
#
# how?
# - run the script hourly?
# - if there is already a backup, do not try to do backup anymore
# - the backup file name does not matter - only 1 file allowed per day?
# - the variable $DailyBackupFiles is there for determining how many backups is needed until skipped backup for today

# Assumption: 7-zip installed (for the command line purposes)
# why 7-zip? powershell archive command does not understand hidden files!!!

# Note to self: store this script to c:\scripts and schedule it

# variables

$debug = $true
$ThisDay = [datetime]::Today
$BackupTime = Get-Date -Format "yyyy-MM-dd HHmm"
$BackupFile = $BackupTime + " ObsidianBackup.zip"
$DailyBackupFiles = 2
$7z = "C:\Program Files\7-Zip\7z.exe"

$sourceDirectory = "C:\iCloudDrive"
$targetDirectory = "C:\users\jermu\OneDrive\BACKUPS"

$obsidianSourceDirectory = $sourceDirectory + "\Icloud~md~obsidian"
$obsidianBackupDirectory = $targetDirectory + "\Obsidian"

if ($debug -eq $true) { Write-Host "Debug: obsidian Source Directory" $obsidianSourceDirectory }
if ($debug -eq $true) { Write-Host "Debug: obsidian backup Target Directory" $obsidianBackupDirectory }

# Let's ensure the backup folder exists
$strBackupfolderExists = Test-Path -Path $obsidianBackupDirectory
if ($strBackupfolderExists -eq $false) {
    Write-Host "Error: backup folder do not exist"
    Write-Host "Trying to create a new one"
    mkdir -Path $obsidianBackupDirectory
}

# here should be a routine to check source folder as well
# routine...

# routine for checking if there is backups already?
$isDailybackupsDone = $false
$checkCountOfBackupFiles = 0
# check if there is at least 1 file for today
if ($debug -eq $true) { write-host "Debug: todays date" $ThisDay } # let's output variable "format"
Get-ChildItem $obsidianBackupDirectory | 
    ForEach-Object {
        if ($debug -eq $true) {
            Write-Host "Debug:" $_.name $_.LastWriteTime.Date
        }
        if ($_.LastWriteTime.Date -eq $ThisDay) { $checkCountOfBackupFiles = $checkCountOfBackupFiles +1 }
    }

if ($debug -eq $true) { Write-Host "Debug: Count of backup files (written today) -" $checkCountOfBackupFiles }

# routine to check if we have enough of the backup files
if ($checkCountOfBackupFiles -lt $DailyBackupFiles) {
    if ($debug -eq $true) { Write-Host "Debug: there is less than needed backup files" $checkCountOfBackupFiles"/"$DailyBackupFiles }
} else {
    if ($debug -eq $true) { Write-Host "Debug: there is more than needed backup files" $checkCountOfBackupFiles"/"$DailyBackupFiles }
    $isDailybackupsDone = $true
}

if ($debug -eq $true) { Write-Host "Debug: Daily backups status -" $isDailybackupsDone }


# routine for backing up the obsidian database
if ($isDailybackupsDone -eq $false) {
    $fullFilename = $obsidianBackupDirectory + "\" + $BackupFile
    if ($debug -eq $true) { Write-Host "Debug: Backup file name" $BackupFile }
    if ($debug -eq $true) { Write-Host "Debug: backup full name" $fullFilename }
    Write-Host "tähän tulee backup rutiini"

    # variables used
    # $7z = 7zip executable
    # $fullFilename = backup file including full path
    # $obsidianSourceDirectory, full path which is being backed up

    . $7z a $fullFilename $obsidianSourceDirectory

    # note - there is no error checking?
    # todo

    # finally, setting backup status to be true
    $isDailybackupsDone = $true
}

if ($isDailybackupsDone -eq $true) { Write-Host "backup completed" }