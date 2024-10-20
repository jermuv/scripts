Set-Location ~ 
Set-Location .\OneDrive
(get-childitem -recurse `
| where { $_.lastwritetime -gt (get-date).AddDays(-1) }).count