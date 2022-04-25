{



#region general good download
{
    #region downloadfolder variable + generation
    $download = "c:\temp"
    if ($debug) { write-host $download }
    if (!(Test-Path $download)) { md $download }
    #endregion downloadfolder

    #region laps download
    $lapsdownload = "$download\laps"
    if ($debug) { write-host $lapsdownload }
    if (!(Test-Path $lapsdownload)) { md $lapsdownload }        
    invoke-webrequest -uri https://download.microsoft.com/download/C/7/A/C7AAD914-A8A6-4904-88A1-29E657445D03/LAPS.x64.msi -outfile "$lapsdownload\LAPS.x64.msi"
    "LAPS_TechnicalSpecification.docx","LAPS_OperationsGuide.docx" | ForEach-Object { invoke-webrequest -uri "https://download.microsoft.com/download/C/7/A/C7AAD914-A8A6-4904-88A1-29E657445D03/$_" -outfile "$lapsdownload\$_" }
    #endregion laps

}
#endregion general good download

    {

        # download latest offline version of edge
        # https://www.microsoft.com/fi-fi/edge/business/download

        # visual studio download site:
        # https://my.visualstudio.com/downloads

        # wsus cab file:
        # http://go.microsoft.com/fwlink/?linkid=74689

        Start-BitsTransfer -Source http://go.microsoft.com/fwlink/?linkid=74689 -Destination "c:\wsusscn2.cab"

        # dotnet download
        Start-BitsTransfer -Source https://go.microsoft.com/fwlink/?linkid=2088631 -Destination "c:\temp\netframework48_offline.exe"

        # edge offline install
        invoke-webrequest -uri http://go.microsoft.com/fwlink/?LinkID=2093437 -OutFile "C:\temp\MicrosoftEdgeEnterpriseX64.msi"

        #region mma
        # mma agent download
        invoke-webrequest -uri https://go.microsoft.com/fwlink/?LinkId=828603 -outfile "c:\temp\MMASetup-AMD64.exe"
        ### https://docs.microsoft.com/en-us/azure/azure-monitor/agents/agent-windows
        #endregion

        #region aad connect
        invoke-webrequest -uri https://download.microsoft.com/download/B/0/0/B00291D0-5A83-4DE7-86F5-980BC00DE05A/AzureADConnect.msi -outfile "c:\temp\AzureADConnect.msi"
        #endregion

            }
        
         #region schema stuff
         Import-module AdmPwd.PS
         Update-AdmPwdADSchema
         #endregion laps schema

        #region laps groups
        $OUpath = "ou=t2, OU=admin, dc=jevirtan1,dc=lab"
        New-ADGroup -Name LAPS_Readers -GroupScope Global -Path $OUPath
        New-ADGroup -Name LAPS_Resetters -GroupScope Global -Path $OUPath
        #endregion laps groups

        #region blank gpo
        New-Gpo -Name 'LAPS' | New-GPLink -Target $OUPath
        #endregion blank gpo

        #endregion laps

        # misc download
        #endregion

        #region vast related
        #Reg Add HKLM\SYSTEM\CurrentControlSet\Services\NTDS\Diagnostics /v "16 LDAP Interface Events" /t REG_DWORD /d 2
        #reg add "HKLM\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL" /v "EventLogging" /t REG_DWORD /d 7 /f
        #set-SmbServerConfiguration –AuditSmb1Access $true

        start-bitstransfer -source https://go.microsoft.com/fwlink/?LinkId=2116849 -Destination "c:\temp\GatewayInstall.exe"

        start-bitstransfer -source https://go.microsoft.com/fwlink/?LinkId=2085155 -Destination "c:\temp\netframework.exe"
        start-bitstransfer -source https://go.microsoft.com/fwlink/?linkid=2088631 -Destination "c:\temp\netframework_4.8_offlineinstaller.exe"

        # powerbi desktop
        # https://aka.ms/pbiSingleInstaller
        ###start-bitstransfer -source https://www.microsoft.com/en-us/download/confirmation.aspx?id=58494 -Destination "c:\temp\PBIDesktopSetup_x64.exe"
        start-bitstransfer -source https://download.microsoft.com/download/8/8/0/880BCA75-79DD-466A-927D-1ABF1F5454B0/PBIDesktopSetup_x64.exe -Destination "c:\temp\PBIDesktopSetup_x64.exe"
        #endregion

        # vast related
        #endregion

        #region scheduled tasks stuff

        ## Get-ScheduledTask | Get-ScheduledTaskInfo

        # scheduled tasks
        #endregion

        # AD content

        #region background info
        $destination = "C:\temp"
        if(!(Test-Path $destination))
        {
            New-Item -ItemType Directory -Force -Path $destination | Out-Null
        }

        start-bitstransfer -source https://download.sysinternals.com/files/BGInfo.zip -Destination "$destination\BGInfo.zip"
        #endregion


        #region preparing tools server
        mkdir c:\share
        New-SmbShare -path "c:\share" -name "share"
        #endregion
    }
}