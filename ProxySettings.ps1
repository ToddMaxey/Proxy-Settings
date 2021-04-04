#Read the registry locations for Internet proxy and WinHTTP settings to determined if they are present and enabled

$RegPathHKLM = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings"
$RegPathHKU = "HKU:\S-1-5-18\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings"
$RegPathHKCU = "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings"
$RegPathDefault = "HKU:\.DEFAULT\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings"

Write-Host "WinHTTP Proxy setting for current run context"(whoami)(netsh winhttp show proxy)

    if (Get-RegistryValue -Path $RegPathHKLM -Value "ProxyServer") {
		Write-Host "Proxy settings on the Local Machine were detected"
		Write-Host "The detected Proxy settings in machine path (HKLM) are :  "  (Get-RegistryValue -Path $RegPathHKLM -Value "ProxyServer" )
        Write-Host "ProxyEnable is set to :  "  (Get-RegistryValue -Path $RegPathHKLM -Value "ProxyEnable" ) 
	}
    if (Get-RegistryValue -Path $RegPathHKLM\Connections -Value "WinHttpSettings") {
		Write-Host "WinHttpSettings on the Local Machine were detected"
		Write-Host "The WinHttpSettings in machine path (HKLM) are :  "  (Get-RegistryValue -Path $RegPathHKLM\Connections -Value "WinHttpSettings" )
        Write-Host "WinHttpSettings is set to :  "  (Get-RegistryValue -Path $RegPathHKLM\Connections -Value "WinHttpSettings" | Format-Hex)
	} 
	if (Get-RegistryValue -Path $RegPathHKU -Value "ProxyServer") {
	    Write-Host "Proxy settings in SYSTEM SID level were detected" 
	    Write-Host "The detected proxy settings in SYSTEM HKU path (S-1-5-18) are :  "  (Get-RegistryValue -Path $RegPathHKU -Value "ProxyServer" ) 
		Write-Host "ProxyEnable is set to :  "  (Get-RegistryValue -Path $RegPathHKU -Value "ProxyEnable" ) 
	}
    if (Get-RegistryValue -Path $RegPathHKU\Connections -Value "WinHttpSettings") {
		Write-Host "WinHttpSettings on the Local Machine were detected"
		Write-Host "The WinHttpSettings in SYSTEM HKU path (S-1-5-18) are :  "  (Get-RegistryValue -Path $RegPathHKU\Connections -Value "WinHttpSettings" )
        Write-Host "WinHttpSettings is set to :  "  (Get-RegistryValue -Path $RegPathHKU\Connections -Value "WinHttpSettings" | Format-Hex) 
	}  
	if (Get-RegistryValue -Path $RegPathHKCU -Value "ProxyServer") {
	    Write-Host "Proxy setting in current user level were detected"
		Write-Host "The detected proxy settings in current user path (HKCU) are :  "  (Get-RegistryValue -Path $RegPathHKCU -Value "ProxyServer" )
		Write-Host "ProxyEnable is set to :  "  (Get-RegistryValue -Path $RegPathHKCU -Value "ProxyEnable" )
	}
    if (Get-RegistryValue -Path $RegPathHKCU\Connections -Value "WinHttpSettings") {
		Write-Host "WinHttpSettings on the Local Machine were detected"
		Write-Host "The WinHttpSettings in current user path (HKCU) are :  "  (Get-RegistryValue -Path $RegPathHKCU\Connections -Value "WinHttpSettings" )
        Write-Host "WinHttpSettings is set to :  "  (Get-RegistryValue -Path $RegPathHKCU\Connections -Value "WinHttpSettings" | Format-Hex) 
	} 
	if (Get-RegistryValue -Path $RegPathDefault -Value "ProxyServer") {
	    Write-Host "Proxy setting in DEFAULT user level were detected"
		Write-Host "The detected proxy settings in the default user path (.DEFAULT) are :  "  (Get-RegistryValue -Path $RegPathDefault -Value "ProxyServer" )
		Write-Host "ProxyEnable is set to :  "  (Get-RegistryValue -Path $RegPathDefault -Value "ProxyEnable" )
	}
    if (Get-RegistryValue -Path $RegPathDefault\Connections -Value "WinHttpSettings") {
		Write-Host "WinHttpSettings on the .Default were detected"
		Write-Host "The WinHttpSettings in machine path (.Default) are :  "  (Get-RegistryValue -Path $RegPathDefault\Connections -Value "WinHttpSettings" )
        Write-Host "WinHttpSettings is set to :  "  (Get-RegistryValue -Path $RegPathDefault\Connections -Value "WinHttpSettings" | Format-Hex) 
	} 

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
