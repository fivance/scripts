$Color = 0xFF7700

New-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\DWM" -Name ColorPrevalence -Value 1 -PropertyType DWord -Force

New-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\DWM" -Name AccentColor -Value $Color -PropertyType DWord -Force

New-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\DWM" -Name AccentColorInactive -Value $Color -PropertyType DWord -Force

Stop-Process -Name explorer -Force
Start-Process explorer
exit