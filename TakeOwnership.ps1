# PowerShell Script to add "Take Ownership" to the Context Menu

$regPath1 = "HKCR:\*\shell\TakeOwnership"
$regPath2 = "HKCR:\*\shell\runas"
$regPath3 = "HKCR:\Directory\shell\TakeOwnership"
$regPath4 = "HKCR:\Directory\shell\TakeOwnership\command"
$regPath5 = "HKCR:\Drive\shell\runas"
$regPath6 = "HKCR:\Drive\shell\runas\command"

# Remove existing "Take Ownership" entries if they exist
Remove-Item -Path $regPath1 -Force -ErrorAction SilentlyContinue
Remove-Item -Path $regPath2 -Force -ErrorAction SilentlyContinue

# Add "Take Ownership" for files
New-Item -Path $regPath1 -Force
Set-ItemProperty -Path $regPath1 -Name "(default)" -Value "Take Ownership"
Remove-ItemProperty -Path $regPath1 -Name "Extended" -ErrorAction SilentlyContinue
Set-ItemProperty -Path $regPath1 -Name "HasLUAShield" -Value ""
Set-ItemProperty -Path $regPath1 -Name "NoWorkingDirectory" -Value ""
Set-ItemProperty -Path $regPath1 -Name "NeverDefault" -Value ""

New-Item -Path "$regPath1\command" -Force
Set-ItemProperty -Path "$regPath1\command" -Name "(default)" -Value 'powershell -windowstyle hidden -command "Start-Process cmd -ArgumentList ''/c takeown /f ""%1"" && icacls ""%1"" /grant *S-1-3-4:F /t /c /l & pause'' -Verb runAs"'
Set-ItemProperty -Path "$regPath1\command" -Name "IsolatedCommand" -Value 'powershell -windowstyle hidden -command "Start-Process cmd -ArgumentList ''/c takeown /f ""%1"" && icacls ""%1"" /grant *S-1-3-4:F /t /c /l & pause'' -Verb runAs"'

# Add "Take Ownership" for directories
New-Item -Path $regPath3 -Force
Set-ItemProperty -Path $regPath3 -Name "(default)" -Value "Take Ownership"
Set-ItemProperty -Path $regPath3 -Name "AppliesTo" -Value 'NOT (System.ItemPathDisplay:="C:\\Users" OR System.ItemPathDisplay:="C:\\ProgramData" OR System.ItemPathDisplay:="C:\\Windows" OR System.ItemPathDisplay:="C:\\Windows\\System32" OR System.ItemPathDisplay:="C:\\Program Files" OR System.ItemPathDisplay:="C:\\Program Files (x86)")'
Remove-ItemProperty -Path $regPath3 -Name "Extended" -ErrorAction SilentlyContinue
Set-ItemProperty -Path $regPath3 -Name "HasLUAShield" -Value ""
Set-ItemProperty -Path $regPath3 -Name "NoWorkingDirectory" -Value ""
Set-ItemProperty -Path $regPath3 -Name "Position" -Value "middle"

New-Item -Path $regPath4 -Force
Set-ItemProperty -Path $regPath4 -Name "(default)" -Value 'powershell -windowstyle hidden -command "$Y = ($null | choice).Substring(1,1); Start-Process cmd -ArgumentList (''/c takeown /f ""%1"" /r /d '' + $Y + '' && icacls ""%1"" /grant *S-1-3-4:F /t /c /l /q & pause'') -Verb runAs"'
Set-ItemProperty -Path $regPath4 -Name "IsolatedCommand" -Value 'powershell -windowstyle hidden -command "$Y = ($null | choice).Substring(1,1); Start-Process cmd -ArgumentList (''/c takeown /f ""%1"" /r /d '' + $Y + '' && icacls ""%1"" /grant *S-1-3-4:F /t /c /l /q & pause'') -Verb runAs"'

# Add "Take Ownership" for drives
New-Item -Path $regPath5 -Force
Set-ItemProperty -Path $regPath5 -Name "(default)" -Value "Take Ownership"
Remove-ItemProperty -Path $regPath5 -Name "Extended" -ErrorAction SilentlyContinue
Set-ItemProperty -Path $regPath5 -Name "HasLUAShield" -Value ""
Set-ItemProperty -Path $regPath5 -Name "NoWorkingDirectory" -Value ""
Set-ItemProperty -Path $regPath5 -Name "Position" -Value "middle"
Set-ItemProperty -Path $regPath5 -Name "AppliesTo" -Value 'NOT (System.ItemPathDisplay:="C:\\")'

New-Item -Path $regPath6 -Force
Set-ItemProperty -Path $regPath6 -Name "(default)" -Value 'cmd.exe /c takeown /f "%1" /r /d y && icacls "%1" /grant *S-1-3-4:F /t /c & Pause'
Set-ItemProperty -Path $regPath6 -Name "IsolatedCommand" -Value 'cmd.exe /c takeown /f "%1" /r /d y && icacls "%1" /grant *S-1-3-4:F /t /c & Pause'

Write-Host "Take Ownership has been added to the context menu."
