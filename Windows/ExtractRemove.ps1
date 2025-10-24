# Extract all ZIP files in the current directory and delete originals

$zipFiles = Get-ChildItem -Path . -Filter *.zip

if ($zipFiles.Count -eq 0) {
    Write-Host "No ZIP files found in the current directory." -ForegroundColor Yellow
    exit
}

Write-Host "Found $($zipFiles.Count) ZIP file(s) to process." -ForegroundColor Cyan

foreach ($zip in $zipFiles) {
    # Create folder name by removing .zip extension
    $destFolder = Join-Path -Path $zip.DirectoryName -ChildPath $zip.BaseName
    
    Write-Host "`nProcessing: $($zip.Name)" -ForegroundColor Green
    
    try {
        # Create destination folder if it doesn't exist
        if (-not (Test-Path $destFolder)) {
            New-Item -Path $destFolder -ItemType Directory | Out-Null
            Write-Host "  Created folder: $($zip.BaseName)" -ForegroundColor Gray
        } else {
            Write-Host "  Folder already exists: $($zip.BaseName)" -ForegroundColor Gray
        }
        
        # Extract ZIP file
        Expand-Archive -Path $zip.FullName -DestinationPath $destFolder -Force
        Write-Host "  Extracted successfully" -ForegroundColor Gray
        
        # Delete original ZIP file
        Remove-Item -Path $zip.FullName -Force
        Write-Host "  Deleted original ZIP file" -ForegroundColor Gray
        
    } catch {
        Write-Host "  ERROR: Failed to process $($zip.Name)" -ForegroundColor Red
        Write-Host "  $($_.Exception.Message)" -ForegroundColor Red
    }
}

Write-Host "`nAll done!" -ForegroundColor Cyan