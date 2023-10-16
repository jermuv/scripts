# variables
$backupfolder = 'D:\BACKUP'

Get-ChildItem $backupfolder -Recurse -File | Get-FileHash -Algorithm MD5 | Export-Csv -Path d:\BACKUP.CSV