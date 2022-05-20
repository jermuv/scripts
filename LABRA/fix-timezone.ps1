$a = get-adcomputer -filter * -properties name | select name
Invoke-command -computername a.name  -scriptblock { tzutil /s "FLE Standard Time" }