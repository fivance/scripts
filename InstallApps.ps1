# 1. Make sure the Microsoft App Installer is installed:
# https://www.microsoft.com/en-us/p/app-installer/9nblggh4nns1
# 2. Edit the list of apps to install.
# 3. Run this script as administrator.

Write-Output "Installing Apps..."
$apps = @(
    @{name = "7zip.7zip" },
    @{name = "Google.Chrome" },
    @{name = "Brave.Brave"},
    @{name = "Mozilla.Firefox" },
    @{name = "SublimeHQ.SublimeText.4" },
    @{name = "Notepad++.Notepad++" },
    @{name = "Microsoft.VisualStudioCode"},
    @{name = "Devolutions.RemoteDesktopManagerFree" },
    @{name = "Skillbrains.Lightshot" },
    @{name = "voidtools.Everything.Alpha" },
    @{name = "Ditto.Ditto" },
    @{name = "BitSum.ProcessLasso" },
    @{name = "AntibodySoftware.WizTree" },
    @{name = "Termius.Termius" },  
    @{name = "Ghisler.TotalCommander" },
    @{name = "famatech.advancedipscanner" },
    @{name = "WiresharkFoundation.Wireshark" },
    @{name = "GeekUninstaller.GeekUninstaller" },  
    @{name = "VideoLAN.VLC" },
    @{name = "TeamSpeakSystems.TeamSpeakClient" },
    @{name = "Discord.Discord" },
    @{name = "Valve.Steam" },
    @{name = "Rainmeter.Rainmeter" }

);
Foreach ($app in $apps) {
    $listApp = winget list --exact -q $app.name
    if (![String]::Join("", $listApp).Contains($app.name)) {
        Write-host "Installing: " $app.name
        winget install -e -h --accept-source-agreements --accept-package-agreements --id $app.name 
    }
    else {
        Write-host "Skipping: " $app.name " (already installed)"
    }
}