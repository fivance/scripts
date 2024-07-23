#Must be run as Admin
#Creates ECOMSQLDATA folder in C: and subfolder Updbak. Sets locale to hr-hr. Downloads SQL Server 2019 Express with advanced features
# Script to create folders in C: drive
$createFoldersScript = {
    # Define the paths
    $baseFolderPath = "C:\Users\$env:USERNAME\ECOMSQLDATA"
    $subFolderPath = "$baseFolderPath\Updbak"

    # Create the base folder if it does not exist
    if (-Not (Test-Path -Path $baseFolderPath)) {
        New-Item -ItemType Directory -Path $baseFolderPath
        Write-Output "Created folder: $baseFolderPath"
    } else {
        Write-Output "Folder already exists: $baseFolderPath"
    }

    # Create the subfolder if it does not exist
    if (-Not (Test-Path -Path $subFolderPath)) {
        New-Item -ItemType Directory -Path $subFolderPath
        Write-Output "Created folder: $subFolderPath"
    } else {
        Write-Output "Folder already exists: $subFolderPath"
    }
}

# Script to change the system locale to Croatian (Croatia)
$setLocaleScript = {
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
    Write-Output "The system locale has been set to Croatian (Croatia). A system reboot is required for changes to take effect."
}

# Script to download SQL Server Express Edition with Advanced Services
$downloadSqlServerScript = {
    # Define the URL for the SQL Server Express Edition with Advanced Services
    $url = "https://go.microsoft.com/fwlink/?linkid=866658"

    # Get the user's Downloads folder path
    $downloadsFolder = [System.IO.Path]::Combine([System.Environment]::GetFolderPath('UserProfile'), 'Downloads')

    # Define the output file path
    $outputFile = [System.IO.Path]::Combine($downloadsFolder, "SQLEXPRADV_x64_ENU.exe")

    # Download the file
    Write-Output "Downloading SQL Server Express Edition with Advanced Services to $outputFile..."
    Invoke-WebRequest -Uri $url -OutFile $outputFile

    Write-Output "Download completed successfully."

    # Prompt to reboot the system
    $response = Read-Host "A system reboot is required for changes to take effect. Do you want to reboot now? (Y/N)"
    if ($response -eq 'Y' -or $response -eq 'y') {
        Restart-Computer
    } else {
        Write-Output "Please remember to reboot the system later for the changes to take effect."
    }
}

# Execute the scripts in order
& $createFoldersScript
& $setLocaleScript
& $downloadSqlServerScript
