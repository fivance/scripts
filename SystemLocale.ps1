# Ensure the script is run as an administrator
if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator"))
{
    Write-Output "You need to run this script as an Administrator."
    exit
}

# Set the locale to Croatian (Croatia)
$locale = "hr-HR"
$command = "Set-WinSystemLocale -SystemLocale $locale"

# Execute the command to change the system locale
Invoke-Expression $command

# Notify the user
Write-Output "The system locale has been set to Croatian (Croatia)."

# Prompt to reboot the system
$response = Read-Host "A system reboot is required for changes to take effect. Do you want to reboot now? (Y/N)"
if ($response -eq 'Y' -or $response -eq 'y') {
    Restart-Computer
} else {
    Write-Output "Please remember to reboot the system later for the changes to take effect."
}
