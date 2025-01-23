# prereqs

# softwares needed

winget install -e --id JanDeDobbeleer.OhMyPosh  --Source winget

# Modules wished


| Module | Install instructions | Link(s) |
| --- | ---| --- |
| x | y | z |

```
Install-Module PSReadLine -AllowPrerelease -Force
```

# Profile

File: .\Microsoft.PowerShell_profile.ps1

```
# oh-my-posh --version
# 23.20.1
oh-my-posh init pwsh --config 'c:\users\<here samaccountname>\appdata\local\programs\oh-my-posh\themes\kali.omp.json' | invoke-expression
import-module -name terminal-icons

$DocExtensions = ".pdf", ".doc", ".docx", ".csv", ".xls", ".xlsx", ".ptt", ".pptx"
foreach ($allDocs in $DocExtensions) {
    $psstyle.fileinfo.Extension.add($allDocs,"`e[32;5;123m")
}
```