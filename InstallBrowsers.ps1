# URLs for the latest versions
$chromeUrl = "https://dl.google.com/chrome/install/latest/chrome_installer.exe"
$firefoxUrl = "https://download.mozilla.org/?product=firefox-latest&os=win&lang=en-US"
$braveUrl = "https://referrals.brave.com/latest/BraveBrowserSetup.exe"

# Temporary folder for storing the installers
$installDir = "$env:TEMP\browser_installs"

# Create the directory if it doesn't exist
if (-Not (Test-Path $installDir)) {
    New-Item -ItemType Directory -Path $installDir | Out-Null
}

# Function to download and install a browser silently
function Install-Browser ($browserName, $downloadUrl, $silentSwitches) {
    $installerPath = "$installDir\$browserName-installer.exe"
    Write-Host "Downloading $browserName from $downloadUrl..."
    Invoke-WebRequest -Uri $downloadUrl -OutFile $installerPath
    
    Write-Host "Installing $browserName silently..."
    Start-Process -FilePath $installerPath -ArgumentList $silentSwitches -Wait

    # Remove the installer after installation
    Write-Host "$browserName installation complete. Cleaning up..."
    Remove-Item $installerPath
}

# Install Google Chrome (silent switch is /silent /install)
Install-Browser "Chrome" $chromeUrl '/silent /install'

# Install Mozilla Firefox (silent switch is -ms)
Install-Browser "Firefox" $firefoxUrl '-ms'

# Install Brave Browser (silent switch is /silent /install)
Install-Browser "Brave" $braveUrl '/silent /install'

Write-Host "Installation of all browsers complete."
