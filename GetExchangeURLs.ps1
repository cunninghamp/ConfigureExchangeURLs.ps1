<#
.SYNOPSIS
GetExchangeURLs.ps1

.DESCRIPTION 
PowerShell script to display the Client Access server URLs
for Microsoft Exchange Server 2013/2016.

.PARAMETER Server
The name(s) of the server(s) you want to view the URLs for.

.EXAMPLE
.\Get-ExchangeURLs.ps1 -Server sydex1

.LINK
http://exchangeserverpro.com/powershell-script-configure-exchange-urls/

.NOTES
Written by: Paul Cunningham

For more Exchange Server tips, tricks and news
check out Exchange Server Pro.

* Website:	http://exchangeserverpro.com
* Twitter:	http://twitter.com/exchservpro

Find me on:

* My Blog:	http://paulcunningham.me
* Twitter:	https://twitter.com/paulcunningham
* LinkedIn:	http://au.linkedin.com/in/cunninghamp/
* Github:	https://github.com/cunninghamp

Change Log:
V1.00, 27/08/2015 - Initial version
#>

#requires -version 2


[CmdletBinding()]
param(
	[Parameter( Position=0,Mandatory=$true)]
	[string[]]$Server
	)


#...................................
# Script
#...................................

Begin {

    #Add Exchange snapin if not already loaded in the PowerShell session
    if (Test-Path $env:ExchangeInstallPath\bin\RemoteExchange.ps1)
    {
	    . $env:ExchangeInstallPath\bin\RemoteExchange.ps1
	    Connect-ExchangeServer -auto -AllowClobber
    }
    else
    {
        Write-Warning "Exchange Server management tools are not installed on this computer."
        EXIT
    }
}

Process {

    foreach ($i in $server)
    {
        if ((Get-ExchangeServer $i -ErrorAction SilentlyContinue).IsClientAccessServer)
        {
            Write-Host "----------------------------------------"
            Write-Host " Querying $i"
            Write-Host "----------------------------------------`r`n"
            Write-Host "`r`n"

            $OA = Get-OutlookAnywhere -Server $i -AdPropertiesOnly | Select InternalHostName,ExternalHostName
            Write-Host "Outlook Anywhere"
            Write-Host " - Internal: $($OA.InternalHostName)"
            Write-Host " - External: $($OA.ExternalHostName)"
            Write-Host "`r`n"

            $OWA = Get-OWAVirtualDirectory -Server $i -AdPropertiesOnly | Select InternalURL,ExternalURL
            Write-Host "Outlook Web App"
            Write-Host " - Internal: $($OWA.InternalURL)"
            Write-Host " - External: $($OWA.ExternalURL)"
            Write-Host "`r`n"

            $ECP = Get-ECPVirtualDirectory -Server $i -AdPropertiesOnly | Select InternalURL,ExternalURL
            Write-Host "Exchange Control Panel"
            Write-Host " - Internal: $($ECP.InternalURL)"
            Write-Host " - External: $($ECP.ExternalURL)"
            Write-Host "`r`n"

            $OAB = Get-OABVirtualDirectory -Server $i -AdPropertiesOnly | Select InternalURL,ExternalURL
            Write-Host "Offline Address Book"
            Write-Host " - Internal: $($OAB.InternalURL)"
            Write-Host " - External: $($OAB.ExternalURL)"
            Write-Host "`r`n"

            $EWS = Get-WebServicesVirtualDirectory -Server $i -AdPropertiesOnly | Select InternalURL,ExternalURL
            Write-Host "Exchange Web Services"
            Write-Host " - Internal: $($EWS.InternalURL)"
            Write-Host " - External: $($EWS.ExternalURL)"
            Write-Host "`r`n"

            $MAPI = Get-MAPIVirtualDirectory -Server $i -AdPropertiesOnly | Select InternalURL,ExternalURL
            Write-Host "MAPI"
            Write-Host " - Internal: $($MAPI.InternalURL)"
            Write-Host " - External: $($MAPI.ExternalURL)"
            Write-Host "`r`n"

            $EAS = Get-ActiveSyncVirtualDirectory -Server $i -AdPropertiesOnly | Select InternalURL,ExternalURL
            Write-Host "ActiveSync"
            Write-Host " - Internal: $($EAS.InternalURL)"
            Write-Host " - External: $($EAS.ExternalURL)"
            Write-Host "`r`n"

            $AutoD = Get-ClientAccessServer $i | Select AutoDiscoverServiceInternalUri
            Write-Host "Autodiscover"
            Write-Host " - Internal SCP: $($AutoD.AutoDiscoverServiceInternalUri)"
            Write-Host "`r`n"

        }
        else
        {
            Write-Host -ForegroundColor Yellow "$i is not a Client Access server."
        }
    }
}

End {

    Write-Host "Finished querying all servers specified."

}

#...................................
# Finished
#...................................