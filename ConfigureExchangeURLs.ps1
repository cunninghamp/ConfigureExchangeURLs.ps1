<#
.SYNOPSIS
ConfigureExchangeURLs.ps1

.DESCRIPTION 
PowerShell script to configure the Client Access server URLs
for Microsoft Exchange Server 2013. All Client Access server
URLs will be set to the same namespace.

If you are using separate namespaces for each CAS service this script will
not handle that.

The script sets Outlook Anywhere to use NTLM with SSL required. If you have
different auth requirements for Outlook Anywhere modify that command
in the script first.

.PARAMETER Server
The name of the server you are configuring.

.PARAMETER InternalURL
The internal namespace you are using.

.PARAMETER ExternalURL
The internal namespace you are using.

.EXAMPLE
.\ConfigureURLs.ps1 -Server ex2013srv1 -InternalURL mail.exchangeserverpro.net -ExternalURL mail.exchangeserverpro.net

.LINK
http://exchangeserverpro.com/exchange-server-2010-2013-migration-configuring-client-access-servers/

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
V1.00, 13/11/2014 - Initial version
#>

#requires -version 2

param(
	[Parameter( Mandatory=$true)]
	[string]$Server,

	[Parameter( Mandatory=$true)]
	[string]$InternalURL,

	[Parameter( Mandatory=$true)]
	[string]$ExternalURL
	)

Write-Host "Configuring Outlook Anywhere URLs"
Get-OutlookAnywhere -Server $Server | Set-OutlookAnywhere -ExternalHostname $externalurl -InternalHostname $internalurl -ExternalClientsRequireSsl $true -InternalClientsRequireSsl $true -DefaultAuthenticationMethod NTLM

Write-Host "Configuring Outlook Web App URLs"
Get-OwaVirtualDirectory -Server $server | Set-OwaVirtualDirectory -ExternalUrl https://$externalurl/owa -InternalUrl https://$internalurl/owa

Write-Host "Configuring Exchange Control Panel URLs"
Get-EcpVirtualDirectory -Server $server | Set-EcpVirtualDirectory -ExternalUrl https://$externalurl/ecp -InternalUrl https://$internalurl/ecp

Write-Host "Configuring ActiveSync URLs"
Get-ActiveSyncVirtualDirectory -Server $server | Set-ActiveSyncVirtualDirectory -ExternalUrl https://$externalurl/Microsoft-Server-ActiveSync -InternalUrl https://$internalurl/Microsoft-Server-ActiveSync

Write-Host "Configuring Exchange Web Services URLs"
Get-WebServicesVirtualDirectory -Server $server | Set-WebServicesVirtualDirectory -ExternalUrl https://$externalurl/EWS/Exchange.asmx -InternalUrl https://$internalurl/EWS/Exchange.asmx

Write-Host "Configuring Offline Address Book URLs"
Get-OabVirtualDirectory -Server $server | Set-OabVirtualDirectory -ExternalUrl https://$externalurl/OAB -InternalUrl https://$internalurl/OAB

Write-Host "Configuring MAPI/HTTP URLs"
Get-MapiVirtualDirectory -Server $server | Set-MapiVirtualDirectory -ExternalUrl https://$externalurl/mapi -InternalUrl https://$internalurl/mapi

Write-Host "Configuring Autodiscover"
Get-ClientAccessServer $server | Set-ClientAccessServer -AutoDiscoverServiceInternalUri https://$internalurl/Autodiscover/Autodiscover.xml
