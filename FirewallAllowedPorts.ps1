# Define the output file path
$outputFile = "C:\FirewallAllowedPorts.csv"

# Get all firewall rules
$firewallRules = Get-NetFirewallRule | Where-Object { $_.Enabled -eq 'True' }

# Initialize an array to hold the data
$data = @()

# Loop through each rule and extract relevant information
foreach ($rule in $firewallRules) {
    # Get the rule's associated filters
    $ruleDetails = Get-NetFirewallPortFilter -AssociatedNetFirewallRule $rule
    
    foreach ($detail in $ruleDetails) {
        # Add the relevant details to the array
        $data += [PSCustomObject]@{
            DisplayName = $rule.DisplayName
            Direction = $rule.Direction
            Action = $rule.Action
            Protocol = $detail.Protocol
            LocalPort = $detail.LocalPort
            RemotePort = $detail.RemotePort
        }
    }
}

# Export the data to a CSV file
$data | Export-Csv -Path $outputFile -NoTypeInformation

Write-Output "The allowed ports have been exported to $outputFile"
