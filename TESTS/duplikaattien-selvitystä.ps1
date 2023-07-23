# purpose of the script:
# dump file name and hash of the file to the CSV file
# reaosn for this: 2 almost identical onedrive subfolders and to be decided what files and folders are identical (to be deleted for example)

# Defining variables here
$strOriginalFolder = Read-Host -Prompt "Gimme original folder here"

# getting suffix for the files
$strSuffix = Read-Host -Prompt "Gimme suffix for the extracted files"

# testing if the folder exists
$strOriginalFolderExists = Test-Path -path $strOriginalFolder
Write-Host "You gave folder $strOriginalFolder and does it exist? $strOriginalFolderExists" 

# if folder exists, then proceeding
if ($strOriginalFolderExists -eq $true) {
    # Just list subfolders under the "root" of search folder
    $dirikat = Get-ChildItem -Path $strOriginalFolder -Attributes directory

    # for easier comparison, each of the subfolder under "root" will get own .csv file which can be used against excel file
    foreach ($dirikka in $dirikat) {

        $subFolder = $dirikka.name
                
        # finally, list the files and calculate hashes - dump the results as a csv file
        Get-ChildItem -Path $strOriginalFolder\$subFolder -Recurse -File -Force | Get-FileHash -Algorithm MD5 | Export-Csv -Path c:\temp\$strSuffix$subfolder.csv -Delimiter "|" -UseQuotes Never

    }
}
else
{
    Write-Host "Folder did not exist"
}