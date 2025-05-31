$registryPath = "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager"

if (Test-Path $registryPath) {
    Set-ItemProperty -Path $registryPath -Name "RotatingLockScreenEnabled" -Value 0
    Set-ItemProperty -Path $registryPath -Name "RotatingLockScreenOverlayEnabled" -Value 0
    Set-ItemProperty -Path $registryPath -Name "SubscribedContent-338389Enabled" -Value 0
    Write-Output "'Learn more about this picture' has been disabled for the desktop background."
} else {
    Write-Output "The registry path for ContentDeliveryManager does not exist."
}

$registryPathDesktop = "HKCU:\Control Panel\Desktop"
Set-ItemProperty -Path $registryPathDesktop -Name "Wallpaper" -Value ""
Set-ItemProperty -Path $registryPathDesktop -Name "WallpaperStyle" -Value 0
Set-ItemProperty -Path $registryPathDesktop -Name "BackgroundType" -Value 1
Set-ItemProperty -Path $registryPathDesktop -Name "SingleColor" -Value "000000" # Black color in hex

RUNDLL32.EXE user32.dll, UpdatePerUserSystemParameters ,1 ,True
Write-Output "Wallpaper style has been set to solid black."
