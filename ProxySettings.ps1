# function to read Registry Value
function Get-RegistryValue { param (
    [parameter(Mandatory=$true)]
    [ValidateNotNullOrEmpty()]$Path,
    [parameter(Mandatory=$true)]
    [ValidateNotNullOrEmpty()]$Value
    )

    if (Test-Path -path $Path) {
        return Get-ItemProperty -Path $Path | Select-Object -ExpandProperty $Value -ErrorAction silentlycontinue
    } else {
        return $false
    }
}

#Read the registry locations for Internet proxy and WinHTTP settings to determined if they are present and enabled

$RegPathHKLM = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings"
$RegPathHKU = "HKU:\S-1-5-18\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings"
$RegPathHKCU = "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings"
$RegPathDefault = "HKU:\.DEFAULT\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings"

Write-Host
Write-Host "Proxy settings for user"(whoami)"for machine"(hostname) -ForegroundColor Yellow -BackgroundColor Blue
Write-Host

#(netsh winhttp show proxy)

    if (Get-RegistryValue -Path $RegPathHKLM\Connections -Value "WinHttpSettings") {
        Write-Host
		Write-Host "WinHttpSettings proxy settings via NETSH on the Local Machine were detected" -ForegroundColor Yellow -BackgroundColor Red
        Write-Host
        Write-Host "netsh winhttp show proxy Results" (netsh winhttp show proxy) -ForegroundColor Yellow
        Write-Host
		Write-Host "The WinHttpSettings in machine path (HKLM) are :  "  (Get-RegistryValue -Path $RegPathHKLM\Connections -Value "WinHttpSettings" ) -ForegroundColor Yellow
        Write-Host
        Write-Host "WinHttpSettings is set to :  "  (Get-RegistryValue -Path $RegPathHKLM\Connections -Value "WinHttpSettings" | Format-Hex) -ForegroundColor Yellow
        Write-Host
	} Else {Write-Host
		    Write-Host "WinHttpSettings proxy settings on the Local Machine were detected" -ForegroundColor Green
            Write-Host}

    if (Get-RegistryValue -Path $RegPathHKLM -Value "ProxyServer") {
        Write-Host
		Write-Host "Proxy settings on the Local Machine were detected" -ForegroundColor Yellow -BackgroundColor Red
        Write-Host
		Write-Host "The detected Proxy settings in machine path (HKLM) are :  "  (Get-RegistryValue -Path $RegPathHKLM -Value "ProxyServer" ) -ForegroundColor Yellow
        Write-Host
        Write-Host "ProxyEnable is set to :  "  (Get-RegistryValue -Path $RegPathHKLM -Value "ProxyEnable" ) -ForegroundColor Yellow
        Write-Host
	} Else {Write-Host
		    Write-Host "Proxy settings on the Local Machine were NOT detected" -ForegroundColor Green
            Write-Host}
             
	if (Get-RegistryValue -Path $RegPathHKU -Value "ProxyServer") {
        Write-Host
	    Write-Host "Proxy settings in SYSTEM SID level were detected" -ForegroundColor Yellow -BackgroundColor Red
        Write-Host
	    Write-Host "The detected proxy settings in SYSTEM HKU path (S-1-5-18) are :  "  (Get-RegistryValue -Path $RegPathHKU -Value "ProxyServer" ) -ForegroundColor Yellow
        Write-Host
		Write-Host "ProxyEnable is set to :  "  (Get-RegistryValue -Path $RegPathHKU -Value "ProxyEnable" ) -ForegroundColor Yellow
        Write-Host
	} Else {Write-Host
		    Write-Host "Proxy settings in SYSTEM SID level were NOT detected" -ForegroundColor Green
            Write-Host}

    if (Get-RegistryValue -Path $RegPathHKU\Connections -Value "WinHttpSettings") {
        Write-Host
		Write-Host "WinHttpSettings in SYSTEM SID level were detected" -ForegroundColor Yellow -BackgroundColor Red
        Write-Host
		Write-Host "The WinHttpSettings in SYSTEM HKU path (S-1-5-18) are :  "  (Get-RegistryValue -Path $RegPathHKU\Connections -Value "WinHttpSettings" ) -ForegroundColor Yellow
        Write-Host
        Write-Host "WinHttpSettings is set to :  "  (Get-RegistryValue -Path $RegPathHKU\Connections -Value "WinHttpSettings" | Format-Hex) -ForegroundColor Yellow
        Write-Host
	} Else {Write-Host
		    Write-Host "WinHttpSettings in SYSTEM SID level were NOT detected" -ForegroundColor Green
            Write-Host}
              
	if (Get-RegistryValue -Path $RegPathHKCU -Value "ProxyServer") {
        Write-Host
	    Write-Host "Proxy setting in current user" (whoami) "level were detected" -ForegroundColor Yellow -BackgroundColor Red
        Write-Host
		Write-Host "The detected proxy settings in current user path (HKCU) are :  "  (Get-RegistryValue -Path $RegPathHKCU -Value "ProxyServer" ) -ForegroundColor Yellow
        Write-Host
		Write-Host "ProxyEnable is set to :  "  (Get-RegistryValue -Path $RegPathHKCU -Value "ProxyEnable" ) -ForegroundColor Yellow
        Write-Host
	} Else {Write-Host
		    Write-Host "Proxy setting in current user" (whoami) "level were NOT detected" -ForegroundColor Green
            Write-Host}

    if (Get-RegistryValue -Path $RegPathHKCU\Connections -Value "WinHttpSettings") {
        Write-Host
		Write-Host "WinHttpSettings on the current user" (whoami) "were detected" -ForegroundColor Yellow -BackgroundColor Red
        Write-Host
		Write-Host "The WinHttpSettings in current user path (HKCU) are :  "  (Get-RegistryValue -Path $RegPathHKCU\Connections -Value "WinHttpSettings" ) -ForegroundColor Yellow
        Write-Host
        Write-Host "WinHttpSettings is set to :  "  (Get-RegistryValue -Path $RegPathHKCU\Connections -Value "WinHttpSettings" | Format-Hex) -ForegroundColor Yellow
        Write-Host
	} Else {Write-Host
		    Write-Host "WinHttpSettings on the current user" (whoami) "were NOT detected" -ForegroundColor Green
            Write-Host}

	if (Get-RegistryValue -Path $RegPathDefault -Value "ProxyServer") {
        Write-Host
	    Write-Host "Proxy setting in .DEFAULT user level were detected" -ForegroundColor Yellow -BackgroundColor Red
        Write-Host
		Write-Host "The detected proxy settings in the default user path (.DEFAULT) are :  "  (Get-RegistryValue -Path $RegPathDefault -Value "ProxyServer" ) -ForegroundColor Yellow
        Write-Host
		Write-Host "ProxyEnable is set to :  "  (Get-RegistryValue -Path $RegPathDefault -Value "ProxyEnable" ) -ForegroundColor Yellow
        Write-Host
	} Else {Write-Host
		    Write-Host "Proxy setting in .DEFAULT user level were NOT detected" -ForegroundColor Green
            Write-Host}

    if (Get-RegistryValue -Path $RegPathDefault\Connections -Value "WinHttpSettings") {
        Write-Host
		Write-Host "WinHttpSettings on the .DEFAULT were detected" -ForegroundColor Yellow -BackgroundColor Red
        Write-Host
		Write-Host "The WinHttpSettings in machine path (.Default) are :  "  (Get-RegistryValue -Path $RegPathDefault\Connections -Value "WinHttpSettings" ) -ForegroundColor Yellow
        Write-Host
        Write-Host "WinHttpSettings is set to :  "  (Get-RegistryValue -Path $RegPathDefault\Connections -Value "WinHttpSettings" | Format-Hex) -ForegroundColor Yellow
        Write-Host
	} Else {Write-Host
		    Write-Host "WinHttpSettings on the .DEFAULT were NOT detected" -ForegroundColor Green
            Write-Host}

