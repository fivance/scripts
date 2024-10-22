# Define the color (light blue atm)
$Color = 0xFF7700

# Enable custom colors
New-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\DWM" -Name ColorPrevalence -Value 1 -PropertyType DWord -Force

# Set the color for active titlebars
New-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\DWM" -Name AccentColor -Value $Color -PropertyType DWord -Force

# Set the color for inactive titlebars
New-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\DWM" -Name AccentColorInactive -Value $Color -PropertyType DWord -Force

# Apply the changes
Stop-Process -Name explorer -Force
Start-Process explorer
exit