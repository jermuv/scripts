#region valinta
write-host "valitse:"
write-host " "
write-host "1: wac, baselines, sysinternals, sysmonconfig, laps, bginfo"
write-host "2: wsuscab"
write-host "3: dotnet, edge offline"
write-host "4: powerbi desktop, gateway"
write-host "5: mma, aadconnect"
write-host "6: ALL"
write-host " "
[int]$valinta = read-host "Valinta (1-5) "
# //todo: error detection
#endregion valinta

#region downloadfolder variable + generation
$debug = $true
$download = "c:\utils"
if ($debug) { write-host $download }
if (!(Test-Path $download)) { mkdir $download }
#endregion downloadfolder

#region clear download folder
if ($download.length -ge 4) { Get-ChildItem $download | Remove-Item -Recurse -Force -Verbose }
#endregion clear download folder

#region interesting stuff
if ($valinta -eq 1 -or $valinta -eq 6) {
    #region laps download
    $lapsdownload = "$download\laps"
    if ($debug) { write-host $lapsdownload }
    if (!(Test-Path $lapsdownload)) { mkdir $lapsdownload }
    invoke-webrequest -uri https://download.microsoft.com/download/C/7/A/C7AAD914-A8A6-4904-88A1-29E657445D03/LAPS.x64.msi -outfile "$lapsdownload\LAPS.x64.msi"
    "LAPS_TechnicalSpecification.docx","LAPS_OperationsGuide.docx" | ForEach-Object { invoke-webrequest -uri "https://download.microsoft.com/download/C/7/A/C7AAD914-A8A6-4904-88A1-29E657445D03/$_" -outfile "$lapsdownload\$_" }
    #endregion laps

    #region bginfo
    $bginfodownload = "$download\bginfo"
    if ($debug) { write-host $bginfodownload }
    if (!(Test-Path $bginfodownload)) { mkdir $bginfodownload }
    Invoke-WebRequest -uri https://download.sysinternals.com/files/BGInfo.zip -Outfile "$bginfodownload\BGInfo.zip"
    #endregion bginfo

    #region wac
    $wacdownload = "$download\wac"
    if ($debug) { write-host $wacdownload }
    if (!(Test-Path $wacdownload)) { mkdir $wacdownload }
    Invoke-WebRequest -uri https://aka.ms/wacdownload -Outfile "$wacdownload\WindowsAdminCenter.msi"
    #endregion wac

    #region sysinternals
    $sysinternalsdownload = "$download\sysinternals"
    if ($debug) { write-host $sysinternalsdownload }
    if (!(Test-Path $sysinternalsdownload)) { mkdir $sysinternalsdownload }
    Invoke-WebRequest -uri https://download.sysinternals.com/files/SysinternalsSuite.zip -OutFile "$sysinternalsdownload\SysinternalsSuite.zip"
    Expand-Archive -path $sysinternalsdownload\SysinternalsSuite.zip -DestinationPath $sysinternalsdownload
    #endregion sysinternals

    #region swiftonsecurity sysmon
    $sysmonconfig = "$download\sysmonconfig"
    if ($debug) { write-host $sysmonconfig }
    if (!(Test-Path $sysmonconfig)) { mkdir $sysmonconfig }
    Invoke-WebRequest -uri https://raw.githubusercontent.com/SwiftOnSecurity/sysmon-config/master/sysmonconfig-export.xml -Outfile "$sysmonconfig\sysmonconfig-export.xml"
    #endregion swiftonsecurity sysmon

    #region security baseline
    $securitybaselines = "$download\securitybaselines"
    if ($debug) { write-host $securitybaselines }
    if (!(Test-Path $securitybaselines)) { mkdir $securitybaselines }

    #tools
    Invoke-WebRequest -uri https://download.microsoft.com/download/8/5/C/85C25433-A1B0-4FFA-9429-7E023E7DA8D8/PolicyAnalyzer.zip -OutFile "$securitybaselines\PolicyAnalyzer.zip"
    Invoke-WebRequest -uri https://download.microsoft.com/download/8/5/C/85C25433-A1B0-4FFA-9429-7E023E7DA8D8/LGPO.zip -OutFile "$securitybaselines\LGPO.zip"

    #servers
    Invoke-WebRequest -uri https://download.microsoft.com/download/8/5/C/85C25433-A1B0-4FFA-9429-7E023E7DA8D8/Windows%20Server%202022%20Security%20Baseline.zip -OutFile "$securitybaselines\Windows Server 2022 Security Baseline.zip"
    Invoke-WebRequest -uri https://download.microsoft.com/download/8/5/C/85C25433-A1B0-4FFA-9429-7E023E7DA8D8/Windows%20Server%202012%20R2%20Security%20Baseline.zip -OutFile "$securitybaselines\Windows Server 2012 R2 Security Baseline.zip"
    Invoke-WebRequest -uri https://download.microsoft.com/download/8/5/C/85C25433-A1B0-4FFA-9429-7E023E7DA8D8/Windows%2010%20Version%201809%20and%20Windows%20Server%202019%20Security%20Baseline.zip -OutFile "$securitybaselines\Windows 10 Version 1809 and Windows Server 2019 Security Baseline.zip"
    Invoke-WebRequest -uri https://download.microsoft.com/download/8/5/C/85C25433-A1B0-4FFA-9429-7E023E7DA8D8/Windows%2010%20Version%201607%20and%20Windows%20Server%202016%20Security%20Baseline.zip -OutFile "$securitybaselines\Windows 10 Version 1607 and Windows Server 2016 Security Baseline.zip"

    #clients
    Invoke-WebRequest -uri https://download.microsoft.com/download/8/5/C/85C25433-A1B0-4FFA-9429-7E023E7DA8D8/Windows%2011%20Security%20Baseline.zip -Outfile "$securitybaselines\Windows 11 Security Baseline.zip"
    Invoke-WebRequest -uri https://download.microsoft.com/download/8/5/C/85C25433-A1B0-4FFA-9429-7E023E7DA8D8/Windows%2010%20version%2021H2%20Security%20Baseline.zip -OutFile "$securitybaselines\Windows 10 version 21H2 Security Baseline.zip"

    #other
    Invoke-WebRequest -uri https://download.microsoft.com/download/8/5/C/85C25433-A1B0-4FFA-9429-7E023E7DA8D8/Microsoft%20Edge%20v98%20Security%20Baseline.zip -Outfile "$securitybaselines\Microsoft Edge v98 Security Baseline.zip"
    #endregion security baselines
}
#endregion interesting stuff

#region wsus cab jos koskaan tarvii...
if ($valinta -eq 2 -or $valinta -eq 6) {
    # wsus cab file:
    # http://go.microsoft.com/fwlink/?linkid=74689
    $wsusdownload = "$download\wsuscab"
    if ($debug) { write-host $wsusdownload }
    if (!(Test-Path $wsusdownload)) { mkdir $wsusdownload }
    invoke-webrequest -uri http://go.microsoft.com/fwlink/?linkid=74689 -outfile "$wsusdownload\wsusscn2.cab"
    
}
#endregion wsus cab

#region dotnet & edge offline
if ($valinta -eq 3 -or $valinta -eq 6) {

    #region dotnet
    $dotnetdownload = "$download\dotnet"
    if ($debug) { write-host $dotnetdownload }
    if (!(Test-Path $dotnetdownload)) { mkdir $dotnetdownload }
    invoke-webrequest -uri https://go.microsoft.com/fwlink/?linkid=2088631 -outfile "$dotnetdownload\netframework48_offline.exe"
    #endregion dotnet

    #region edge offline install
    $edgeofflinedownload = "$download\edgeoffline"
    if ($debug) { write-host $edgeofflinedownload }
    if (!(Test-Path $edgeofflinedownload)) { mkdir $edgeofflinedownload }
    invoke-webrequest -uri http://go.microsoft.com/fwlink/?LinkID=2093437 -OutFile "$edgeofflinedownload\MicrosoftEdgeEnterpriseX64.msi"
    #endregion edge offline
}
#endregion dotnet & edge offline

#region powerbi
if ($valinta -eq 4 -or $valinta -eq 6) {
    #region powerbi desktop
    # https://aka.ms/pbiSingleInstaller
    $powerbidesktop = "$download\powerbidesktop"
    if ($debug) { write-host $powerbidesktop }
    if (!(Test-Path $powerbidesktop)) { mkdir $powerbidesktop }
    invoke-webrequest -uri https://download.microsoft.com/download/8/8/0/880BCA75-79DD-466A-927D-1ABF1F5454B0/PBIDesktopSetup_x64.exe -Outfile "$powerbidesktop\PBIDesktopSetup_x64.exe"
    #endregion powerbi desktop

    #region powerbi gateway
    $powerbigateway = "$download\powerbigateway"
    if ($debug) { write-host $powerpowerbigateway }
    if (!(Test-Path $powerbigateway)) { mkdir $powerbigateway }
    invoke-webrequest -uri https://go.microsoft.com/fwlink/?LinkId=2116849 -OutFile "$powerbigateway\GatewayInstall.exe"
    #endregion powerbi gateway
}
#endregion powerbi

#region mma & aadconnect
if ($valinta -eq 5 -or $valinta -eq 6) {
    #region mma download
    $mmadownload = "$download\mma"
    if ($debug) { write-host $mmadownload }
    if (!(Test-Path $mmadownload)) { mkdir $mmadownload }
    invoke-webrequest -uri https://go.microsoft.com/fwlink/?LinkId=828603 -outfile "$mmadownload\MMASetup-Amkdir64.exe"
    #endregion mma download

    #region aad connect
    $aadconnectdownload = "$download\aadconnect"
    if ($debug) { write-host $aadconnectdownload }
    if (!(Test-Path $aadconnectdownload)) { mkdir $aadconnectdownload }
    invoke-webrequest -uri https://download.microsoft.com/download/B/0/0/B00291D0-5A83-4DE7-86F5-980BC00DE05A/AzureADConnect.msi -outfile "$aadconnectdownload\AzureADConnect.msi"
    #endregion aad connect
}
#endregion mma & aadconnect