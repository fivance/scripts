 If (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]"Administrator"))
    {Start-Process PowerShell.exe -ArgumentList ("-NoProfile -ExecutionPolicy Bypass -File `"{0}`"" -f $PSCommandPath) -Verb RunAs
    Exit}
    $Host.UI.RawUI.WindowTitle = $myInvocation.MyCommand.Definition + " (Administrator)"
    $Host.UI.RawUI.BackgroundColor = "Black"
	$Host.PrivateData.ProgressBackgroundColor = "Black"
    $Host.PrivateData.ProgressForegroundColor = "White"
    Clear-Host


# Check if winget is installed by attempting to get the path
$wingetPath = (Get-Command winget -ErrorAction SilentlyContinue).Path

if ($wingetPath) {
    Write-Host "winget is already installed at: $wingetPath"
} else {
    Write-Host "winget is not installed."

    # winget is part of the App Installer package from the Microsoft Store
    # Prompt the user to install it
    Write-Host "Installing winget (App Installer) from the Microsoft Store..."

    # Open Microsoft Store to the App Installer page for user to install
    Start-Process "ms-windows-store://pdp/?productid=9NBLGGH4NNS1"
    
    Write-Host "Please install 'App Installer' from the Microsoft Store to use winget."
}

Write-Output "Installing Apps..."
$apps = @(
    @{name = "7zip.7zip"},
    @{name = "Google.Chrome"},
    @{name = "Brave.Brave"},
    @{name = "Mozilla.Firefox"},
    @{name = "SublimeHQ.SublimeText.4"},
    @{name = "Notepad++.Notepad++"},
    @{name = "Microsoft.VisualStudioCode"},
    @{name = "Devolutions.RemoteDesktopManagerFree"},
    @{name = "Skillbrains.Lightshot"},
    @{name = "voidtools.Everything.Alpha"},
    @{name = "Ditto.Ditto"},
    @{name = "BitSum.ProcessLasso"},
    @{name = "AntibodySoftware.WizTree"},
    @{name = "Termius.Termius"},
    @{name = "Ghisler.TotalCommander"},
    @{name = "Famatech.AdvancedIPScanner"},
    @{name = "WiresharkFoundation.Wireshark"},
    @{name = "GeekUninstaller.GeekUninstaller"},
    @{name = "VideoLAN.VLC"},
    @{name = "TeamSpeakSystems.TeamSpeakClient"},
    @{name = "Discord.Discord"},
    @{name = "Valve.Steam"},
    @{name = "Rainmeter.Rainmeter"}
)

# Get the list of installed apps once at the beginning
$installedApps = winget list | Select-Object -Skip 1 | ForEach-Object {
    $columns = $_ -split '\s{2,}'  # Split by two or more spaces
    @{ id = $columns[0]; name = $columns[1] }
}

foreach ($app in $apps) {
    $isInstalled = $installedApps | Where-Object { $_.id -eq $app.name -or $_.name -eq $app.name }

    if (-not $isInstalled) {
        Write-Output "Installing: $($app.name)"
        try {
            winget install -e -h --accept-source-agreements --accept-package-agreements --id $app.name
        } catch {
            Write-Output "Failed to install: $($app.name) - $_"
        }
    } else {
        Write-Output "Skipping: $($app.name) (already installed)"
    }
}
