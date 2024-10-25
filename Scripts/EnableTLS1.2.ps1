# Enable TLS 1.2 on Windows Server 2016

# Define the registry paths
$tls12Path = "HKLM:\SOFTWARE\Microsoft\.NETFramework\v4.0.30319"
$tls12SchPath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings"
$tls12SchKey = "SchUseStrongCrypto"

# Create the registry key for .NET Framework
if (-not (Test-Path $tls12Path)) {
    New-Item -Path $tls12Path -Force
}

# Enable TLS 1.2 for .NET Framework
Set-ItemProperty -Path $tls12Path -Name "Enabled" -Value 1 -Type DWord -Force
Set-ItemProperty -Path $tls12Path -Name "SchUseStrongCrypto" -Value 1 -Type DWord -Force

# Enable TLS 1.2 for Internet Settings
if (-not (Test-Path $tls12SchPath)) {
    New-Item -Path $tls12SchPath -Force
}
Set-ItemProperty -Path $tls12SchPath -Name $tls12SchKey -Value 1 -Type DWord -Force

# Enable TLS 1.2 on the Server
$regPath = "HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.2"
if (-not (Test-Path $regPath)) {
    New-Item -Path $regPath -Force
}

# Create subkeys for Server
New-Item -Path "$regPath\Server" -Force
Set-ItemProperty -Path "$regPath\Server" -Name "Enabled" -Value 1 -Type DWord -Force
Set-ItemProperty -Path "$regPath\Server" -Name "Disabled" -Value 0 -Type DWord -Force

# Create subkeys for Client
New-Item -Path "$regPath\Client" -Force
Set-ItemProperty -Path "$regPath\Client" -Name "Enabled" -Value 1 -Type DWord -Force
Set-ItemProperty -Path "$regPath\Client" -Name "Disabled" -Value 0 -Type DWord -Force

# Inform the user
Write-Host "TLS 1.2 has been enabled. Please restart the server for changes to take effect."

# Optionally restart the server (uncomment the next line to enable)
# Restart-Computer -Force
