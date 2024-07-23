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
