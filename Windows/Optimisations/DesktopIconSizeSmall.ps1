$desktopIconSizeKey = "HKCU:\Software\Microsoft\Windows\Shell\Bags\1\Desktop"
$iconSizeValue = 32

If (-not (Test-Path $desktopIconSizeKey)) {
    New-Item -Path $desktopIconSizeKey -Force
}

Set-ItemProperty -Path $desktopIconSizeKey -Name IconSize -Value $iconSizeValue

Stop-Process -Name explorer -Force
Start-Process explorer
