# Exchange Server URL Configuration Scripts

This repository contains two scripts that are useful for reviewing or configuring the URLs for the various Client Access services on Exchange Servers.

## GetExchangeURLs.ps1

The **GetExchangeURLs.ps1** script will return a list of the URLs configured on a Client Access server. This can be used to quickly review the existing configuration.

Example:

```
.\Get-ExchangeURLs.ps1 -Server sydex1
```

## ConfigureExchangeURLs.ps1

The **ConfigureExchangeURLs.ps1** script will configure one or more Client Access servers for the namespaces you specify. All Client Access server
URLs will be set to the same namespace.

If you are using separate namespaces for each CAS service this script will not handle that.

The script sets Outlook Anywhere to use NTLM with SSL required by default. If you have different auth requirements for Outlook Anywhere  use the optional
parameters to set those.

Parameters:
- **-Server** - The name(s) of the server(s) you are configuring.
- **-InternalURL** - The internal namespace you are using.
- **-ExternalURL** - The external namespace you are using.
- **-AutodiscoverSCP** - Used to set a different Autodiscover URL if you need to.
- **-InternalSSL** - Specifies the internal SSL requirement for Outlook Anywhere. Defaults to True (SSL required).
- **-ExternalSSL** - Specifies the external SSL requirement for Outlook Anywhere. Defaults to True (SSL required).

Examples:

```
.\ConfigureExchangeURLs.ps1 -Server sydex1 -InternalURL mail.exchangeserverpro.net -ExternalURL mail.exchangeserverpro.net
```

```
.\ConfigureExchangeURLs.ps1 -Server sydex1,sydex2 -InternalURL mail.exchangeserverpro.net -ExternalURL mail.exchangeserverpro.net
```

```
.\ConfigureExchangeURLs.ps1 -Server sydex1 -InternalURL mail.exchangeserverpro.net -ExternalURL mail.exchangeserverpro.net -AutodiscoverSCP autodiscover.exchangeserverpro.net
```

## More Info

http://exchangeserverpro.com/powershell-script-configure-exchange-urls/

## Credits
Written by: Paul Cunningham

Find me on:

* My Blog:	https://paulcunningham.me
* Twitter:	https://twitter.com/paulcunningham
* LinkedIn:	https://au.linkedin.com/in/cunninghamp/
* Github:	https://github.com/cunninghamp

Check out my [books](https://paulcunningham.me/books/) and [courses](https://paulcunningham.me/training/) to learn more about Office 365 and Exchange Server.
