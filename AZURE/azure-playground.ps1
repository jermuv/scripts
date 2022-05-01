Get-AzResourceGroup | select-object -Property resourcegroupname, location | where-object { $_.location -ne "eastus2" } | where-object { $_.location -ne "eastus" }

Get-AzResource | Where-Object { $_.location -EQ "westus" }