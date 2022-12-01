#region DVD

# list VM's with DVD assigned
get-vm | where {$_state -eq 'running'} | Get-VMDvdDrive | where {$_.path -ne $null}

# eject DVD from the running virtual machienes
get-vm | where {$_.state -eq 'running'} | Get-VMDvdDrive | where {$_.path -ne $null} | Set-VMDvdDrive -path $null

#endregion DVD


#region groups

# get just a list of groups created
Get-VMGroup | Select -Property Name

# adding a group
New-VMGroup -Name "all-jve5dtest" -GroupType VMCollectionType

# adding members to a group
Add-VMGroupMember -Name "all-jve5dtest" -VM (get-vm | where -Property 'State' -eq 'Running')

#endregion groups
