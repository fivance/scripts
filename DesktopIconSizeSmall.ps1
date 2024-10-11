# Change desktop icon size to small (value: 32 for small icons)
$desktopIconSizeKey = "HKCU:\Software\Microsoft\Windows\Shell\Bags\1\Desktop"
$iconSizeValue = 32

# Create the registry key path if it doesn't exist
If (-not (Test-Path $desktopIconSizeKey)) {
    New-Item -Path $desktopIconSizeKey -Force
}

# Set the Icon Size for desktop
Set-ItemProperty -Path $desktopIconSizeKey -Name IconSize -Value $iconSizeValue

# Restart explorer.exe to apply changes
Stop-Process -Name explorer -Force
Start-Process explorer
