# prereqs

# softwares needed

```
winget install -e --id JanDeDobbeleer.OhMyPosh  --Source winget
```

# Modules wished


| Module | Install instructions | Link(s) |
| --- | ---| --- |
| PSReadline | Install-Module PSReadLine -AllowPrerelease -Force |  |
| Terminal Icons | Install-Module -Name Terminal-Icons -Repository PSGallery | |
| Azure | Install-Module -Name Az -Repository PSGallery | |

# Fonts

1. Nerd fonts can be found from here: https://www.nerdfonts.com/
2. Download CaskaydiaCove Nerd Font
3. Set powershell (7) profile font to be CaskaydiaCove NF

# Set oh-my-posh automatic updates on

**Enable automatic updates**
```
oh-my-posh enable upgrade
```

**Update one time**

```
oh-my-posh upgrade --force
```

Links for oh-my-posh:
- https://ohmyposh.dev/docs/faq/

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