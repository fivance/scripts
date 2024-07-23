# Define the ports
$ports = @(1433, 1434)

# Loop through each port and add firewall rules for TCP and UDP
foreach ($port in $ports) {
    # Allow TCP traffic
    netsh advfirewall firewall add rule name="Allow TCP Port $port" dir=in action=allow protocol=TCP localport=$port
    
    # Allow UDP traffic
    netsh advfirewall firewall add rule name="Allow UDP Port $port" dir=in action=allow protocol=UDP localport=$port
}

Write-Output "Ports 1433 and 1434 for both TCP and UDP are now allowed."
