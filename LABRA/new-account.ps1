#region templaattidadaa

#endregion

#region tier0 accounts
if (!(get-aduser -filter "samaccountname -eq 't54.jermu'"))
    { new-aduser `
    -Name "Jermu Virtanen (t0)" `
    -Givenname "Jermu" `
    -Surname "Virtanen" `
    -Samaccountname "t54.jermu" `
    -AccountPassword (Read-Host -AsSecureString "Input User Password") `
    -ChangePasswordAtLogon $False `
    -DisplayName "Jermu Virtanen (t0)" `
    -Enabled $True
    } else { write-host "user found, nothing is done" }
