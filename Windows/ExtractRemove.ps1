$targetFolder = Split-Path -Parent $MyInvocation.MyCommand.Definition

$sevenZipPath = "C:\Program Files\7-Zip\7z.exe"

$zipFiles = Get-ChildItem -Path $targetFolder -Filter *.zip

$total = $zipFiles.Count
$current = 0

foreach ($zipFile in $zipFiles) {
    $current++
    Write-Progress -Activity "Extracting ZIP files" -Status "$($zipFile.Name)" -PercentComplete (($current / $total) * 100)

    $extractFolder = Join-Path $targetFolder ($zipFile.BaseName)
    if (-not (Test-Path $extractFolder)) {
        New-Item -ItemType Directory -Path $extractFolder | Out-Null
    }

    try {
        $process = Start-Process -FilePath "$sevenZipPath" `
            -ArgumentList @("x", "`"$($zipFile.FullName)`"", "-o`"$extractFolder`"", "-y") `
            -NoNewWindow -Wait -PassThru -RedirectStandardError "$extractFolder\7zip_error.txt" -RedirectStandardOutput "$extractFolder\7zip_output.txt"
    } catch {
    }

    Remove-Item $zipFile.FullName
}

Write-Progress -Activity "Extracting ZIP files" -Completed
