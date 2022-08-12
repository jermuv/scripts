# visual studio code tip: f8 -> run selected row(s)

#region connect azure account
Connect-AzAccount
#endregion

#region demo
Get-AzResourceGroup | select-object -Property resourcegroupname, location | where-object { $_.location -ne "eastus2" } | where-object { $_.location -ne "eastus" }
Get-AzResource | Where-Object { $_.location -EQ "westus" }
Get-AzResource | Select-Object -Property ResourceType -unique | sort-object -Property ResourceType
#endregion

#region azuread
Get-AzADGroup
#endregion azuread

Get-AzADUser | select -Property UserPrincipalName, type, status, accountenabled | where-object accountenabled -ne 'False'
Get-AzADUser | select -Property UserPrincipalName, type, status, accountenabled | where-object accountenabled -eq 'False'