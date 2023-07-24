# purpose of the script:
# dump file name and hash of the file to the CSV file
# reason for this: 2 almost identical onedrive subfolders and to be decided what files and folders are identical (to be deleted for example)

# Defining variables here
$strOriginalFolder = Read-Host -Prompt "Provide original folder here"

# testing if the folder exists
$strOriginalFolderExists = Test-Path -path $strOriginalFolder
if ($strOriginalFolderExists -eq $false) {
    write-host "Error: original folder do not exist"
    exit
}

$resultsfolder = Read-Host -Prompt "Provide results folder here"

# testing if the results folder exists
$strResultsFolderExists = Test-Path -Path $resultsfolder
if ($strResultsFolderExists -eq $false) {
    Write-Host "Error: results folder do not exist"
    exit
}

# getting suffix for the files
$strSuffix = Read-Host -Prompt "Provide suffix for the log files"

# Just list subfolders under the "root" of search folder
$listofsubfolders = Get-ChildItem -Path $strOriginalFolder -Attributes directory

# for easier comparison, each of the subfolder under "root" will get own .csv file which can be used against excel file
foreach ($subfolder in $listofsubfolders) {
    $subFolder = $subfolder.name
            
    # finally, list the files and calculate hashes - dump the results as a csv file
    Get-ChildItem -Path $strOriginalFolder\$subFolder -Recurse -File -Force | Get-FileHash -Algorithm MD5 | Export-Csv -Path $resultsfolder\$strSuffix$subfolder.csv -Delimiter "|" -UseQuotes Never        
}

write-host "Task completed - results can be found from $resultsfolder"
