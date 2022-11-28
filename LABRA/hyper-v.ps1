#region DVD

# list VM's with DVD assigned
get-vm | where {$_state -eq 'running'} | Get-VMDvdDrive | where {$_.path -ne $null}

# eject DVD from the running virtual machienes
get-vm | where {$_.state -eq 'running'} | Get-VMDvdDrive | where {$_.path -ne $null} | Set-VMDvdDrive -path $null

#endregion DVD

