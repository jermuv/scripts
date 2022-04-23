# scribu 1
get-adcomputer -ldapfilter "(!(ms-mcs-admpwdexpirationtime=*))" -properties distinguishedname, `
    name, useraccountcontrol, pwdlastset | select-object distinguishedname, name, useraccountcontrol, `
    @{n='pwdlastset';e={[datetime]::fromfiletime($_.'pwdlastset').tostring('g')}} | ft

# scribu 2
get-adcomputer -ldapfilter "(!(ms-mcs-admpwdexpirationtime=*))" -properties distinguishedname, `
name, useraccountcontrol, pwdlastset | select-object distinguishedname, name, useraccountcontrol, `
@{n='pwdlastset';e={[datetime]::fromfiletime($_.'pwdlastset').tostring('g')}} | export-csv -path .\dumppi2.csv

# scribu 3
get-adcomputer -ldapfilter "(ms-mcs-admpwdexpirationtime=*)" -properties distinguishedname, ms-mcs-admpwdexpirationtime, `
useraccountcontrol, pwdlastset | select-object distinguishedname, @{n='Computer';e='Name'}, `
@{n='Laps-Expiration';e={[datetime]::fromfiletime($_.'ms-mcs-admpwdexpirationtime').tostring('g')}}, `
useraccountcontrol, @{n='pwdlastset';e={[datetime]::fromfiletime($_.'pwdlastset').tostring('g')}} | ft
