$csvdata = import-csv -path .\dadaa.csv -Delimiter "|"
# TODO: FIXME:
# import could ask file?

# for debugging purposes, added this variable
$adconnected = $true

foreach ($rivi in $csvdata) {
    ## for each account in the csv file, echo samaccountname and 
    ## try to create account

    # note - it is needed to expand next row into a variable, otherwise
    # "if" does not work
    $expAccount = $rivi.Samaccountname

    ## // debug: write-host $rivi.Samaccountname
    ##

    if ($adconnected) {
        if (!(Get-ADUser -filter "samaccountname -eq '$expAccount'")) {
                
                # TODO: FIXME:
                # coloring for the creation of account
                write-host "creating account $expAccount"
                New-ADUser -Name $rivi.Name `
                    -GivenName $rivi.Givenname `
                    -Surname $rivi.Surname `
                    -SamAccountName $rivi.Samaccountname `
                    -DisplayName $rivi.Displayname `
                    -Enabled $False `
                    -ChangePasswordAtLogon $False
        }
        else {
            write-host "user $expAccount found, nothing was done"
            # TODO: FIXME:
            # coloring for the error message
        }
    }
}