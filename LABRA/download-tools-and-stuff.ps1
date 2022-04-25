#region general good download

#region downloadfolder variable + generation
$download = "c:\temp5"
if ($debug) { write-host $download }
if (!(Test-Path $download)) { md $download }
#endregion downloadfolder

#region clear download folder
if ($download.length -ge 4) { Get-ChildItem $download | Remove-Item -Recurse -Force -Verbose }
#endregion clear download folder

#region laps download
$lapsdownload = "$download\laps"
if ($debug) { write-host $lapsdownload }
if (!(Test-Path $lapsdownload)) { md $lapsdownload }
invoke-webrequest -uri https://download.microsoft.com/download/C/7/A/C7AAD914-A8A6-4904-88A1-29E657445D03/LAPS.x64.msi -outfile "$lapsdownload\LAPS.x64.msi"
"LAPS_TechnicalSpecification.docx","LAPS_OperationsGuide.docx" | ForEach-Object { invoke-webrequest -uri "https://download.microsoft.com/download/C/7/A/C7AAD914-A8A6-4904-88A1-29E657445D03/$_" -outfile "$lapsdownload\$_" }
#endregion laps

#region wsus cab jos koskaan tarvii...
# wsus cab file:
# http://go.microsoft.com/fwlink/?linkid=74689
$wsusdownload = "$download\wsuscab"
if ($debug) { write-host $wsusdownload }
if (!(Test-Path $wsusdownload)) { md $wsusdownload }
invoke-webrequest -uri http://go.microsoft.com/fwlink/?linkid=74689 -outfile "$wsusdownload\wsusscn2.cab"
#endregion wsus cab

#region dotnet
$dotnetdownload = "$download\dotnet"
if ($debug) { write-host $dotnetdownload }
if (!(Test-Path $dotnetdownload)) { md $dotnetdownload }
invoke-webrequest -uri https://go.microsoft.com/fwlink/?linkid=2088631 -outfile "$dotnetdownload\netframework48_offline.exe"
#endregion dotnet

#region edge offline install
$edgeofflinedownload = "$download\edgeoffline"
if ($debug) { write-host $edgeofflinedownload }
if (!(Test-Path $edgeofflinedownload)) { md $edgeofflinedownload }
invoke-webrequest -uri http://go.microsoft.com/fwlink/?LinkID=2093437 -OutFile "$edgeofflinedownload\MicrosoftEdgeEnterpriseX64.msi"
#endregion edge offline

#region powerbi desktop
# https://aka.ms/pbiSingleInstaller
$powerbidesktop = "$download\powerbidesktop"
if ($debug) { write-host $powerbidesktop }
if (!(Test-Path $powerbidesktop)) { md $powerbidesktop }
invoke-webrequest -uri https://download.microsoft.com/download/8/8/0/880BCA75-79DD-466A-927D-1ABF1F5454B0/PBIDesktopSetup_x64.exe -Outfile "$powerbidesktop\PBIDesktopSetup_x64.exe"
#endregion powerbi desktop

#region powerbi gateway
$powerbigateway = "$download\powerbigateway"
if ($debug) { write-host $powerpowerbigateway }
if (!(Test-Path $powerbigateway)) { md $powerbigateway }
invoke-webrequest -uri https://go.microsoft.com/fwlink/?LinkId=2116849 -OutFile "$powerbigateway\GatewayInstall.exe"
#endregion powerbi gateway

#region mma download
$mmadownload = "$download\mma"
if ($debug) { write-host $mmadownload }
if (!(Test-Path $mmadownload)) { md $mmadownload }
invoke-webrequest -uri https://go.microsoft.com/fwlink/?LinkId=828603 -outfile "$mmadownload\MMASetup-AMD64.exe"
#endregion mma download

#region aad connect
$aadconnectdownload = "$download\aadconnect"
if ($debug) { write-host $aadconnectdownload }
if (!(Test-Path $aadconnectdownload)) { md $aadconnectdownload }
invoke-webrequest -uri https://download.microsoft.com/download/B/0/0/B00291D0-5A83-4DE7-86F5-980BC00DE05A/AzureADConnect.msi -outfile "$aadconnectdownload\AzureADConnect.msi"
#endregion aad connect

#region bginfo
$bginfodownload = "$download\bginfo"
if ($debug) { write-host $bginfodownload }
if (!(Test-Path $bginfodownload)) { md $bginfodownload }
Invoke-WebRequest -uri https://download.sysinternals.com/files/BGInfo.zip -Outfile "$bginfodownload\BGInfo.zip"
#endregion bginfo

#todo:
# - security baselines
# - policy analyzer

#endregion general good download