# Downloads UniGetUI and its dependencies
winget install --exact --id MartiCliment.UniGetUI --source winget
dotnet tool install --global dotnet-tools-outdated --add-source https://api.nuget.org/v3/index.json


# URL to the raw bundle file in your GitHub repository
$bundleUrl = "https://raw.githubusercontent.com/fivance/files/main/apps-bundle.json"

# Location to save the file temporarily
$tempFile = "$env:temp\apps-bundle.json"

# Download the bundle file from GitHub
Invoke-WebRequest -Uri $bundleUrl -OutFile $tempFile

# Notify the user
Write-Host "Bundle downloaded successfully to $tempFile. You can now import it into WingetUI."
Start-Sleep -Seconds 3
Write-Host "It will install the following:
-7zip
-PowerShell 7
-Everything
-EverythingToolbar
-Ditto
-Notepad++
-Total Commander
-Lightshot
-Geek Uninstaller
-VLC 
-Wiztree"
Start-Sleep -Seconds 3

# Open the folder containing the downloaded bundle (optional)
Start-Process "explorer.exe" -ArgumentList "/select, $tempFile"

# Optionally, launch WingetUI
Start-Process "$env:USERPROFILE\AppData\Local\Programs\UniGetUI\UniGetUI.exe"
