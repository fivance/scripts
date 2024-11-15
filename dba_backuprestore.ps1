#Import the dbatools module
Import-Module dbatools

# Fix for dbatools "The certificate chain was issued by an authority that is not trusted"
Set-DbatoolsConfig -FullName sql.connection.trustcert -Value $true

function show-menu {
Clear-Host
Write-Host " 1. Backup SQL Server"   
Write-Host " 2. Restore SQL Server"

}

while ($true) {
show-menu
$choice = Read-Host "Izaberi opciju"

switch ($choice) {





	1 {
# Unesi SQL instancu i db name
$serverInstance = Read-Host -Prompt "SQL Server"
$databaseName = Read-Host -Prompt "Ime baze"

# Backup direktorij path
$backupDirectory = Read-Host -Prompt "Unesi adresu backup direktorija"

# Backup dir - kreiraj direktorij ako ne postoji
if (!(Test-Path -Path $backupDirectory)) {
    Write-Host "Backup dir ne postoji. Kreiram dir: $backupDirectory"
	Start-Sleep 3
    New-Item -ItemType Directory -Path $backupDirectory
}

# Backup path filename sa timestampom
$timestamp = (Get-Date).ToString("dd-MM-yyyy_HH-mm")
$backupFile = "$backupDirectory\$($databaseName)_$timestamp.bak"

# Napravi backup
try {
    # Use the -FilePath parameter to specify the full file path
    Backup-DbaDatabase -SqlInstance $serverInstance -Database $databaseName -FilePath $backupFile
    Write-Host "Backup uspjesno izvrsen. File: $backupFile"
	Start-Sleep -Seconds 5
	Read-Host
} catch {
    Write-Host "Dogodila se greska prilikom backupa: $_"
}

	}
	
	
	2 {
		
		# Unesi SQL instancu i db name
		$serverInstance = Read-Host -Prompt "SQL Server"
		$databaseName = Read-Host -Prompt "Ime baze koja ce biti restorana iz backupa"
		$backupdir = Read-Host -Prompt "Putanja do .bak filea od backupa baze"
		
		
		
		Restore-DbaDatabase -SqlInstance $serverInstance -Path $backupdir -DatabaseName "$databaseName"
		Write-Host "Restore baze $databaseName uspjesno izvrsen."
		Start-Sleep -Seconds 5
		Read-Host
	}
	
	default {
        Write-Host "Odaberi jednu od validnih opcija (1 ili 2)"

     }
}
}