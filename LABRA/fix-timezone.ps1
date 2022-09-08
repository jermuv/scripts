# AD powershell module needs to be present - DC or "tools" server
$a = get-adcomputer -filter * -properties name | select-object name
Invoke-command -computername $a.name  -scriptblock { tzutil /s "FLE Standard Time" }