#Requires -Version 4.0

# Map the various jobs into a hashtable. Add or remove any jobs you wish to have this script run.
# Code credit to cdituri
$jobMap = [Ordered]@{
  "Hosts"  = "\Resources\vmware-hosts.ps1"
}

# Collect data and send to dashboard
# Code credit to cdituri
$jobMap.Keys | % {
  $scriptPath = Join-Path $PSScriptRoot $jobMap[$_]
  Start-Job -Name "$($_)" -ScriptBlock { Invoke-Expression $args[0] } -ArgumentList $scriptPath | ft -AutoSize
}

# Display job status, and wait for the jobs to finish before removing them from the list (essentially garbage collection)
Get-Job | Wait-Job | ft -AutoSize
Get-Job | Remove-Job | ft -AutoSize