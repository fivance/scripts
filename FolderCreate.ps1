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
