# Function to safely check if a registry key exists
function Test-RegistryKey {
    param (
        [Parameter(Mandatory = $true)]
        [string]$Path
    )
    try {
        return (Test-Path $Path)
    } catch {
        return $false
    }
}

# Initialize flags
$IsRebootPending = $false
$PendingReasons = @()

# Check Windows Update reboot flag
if (Test-RegistryKey -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\Auto Update\RebootRequired') {
    $IsRebootPending = $true
    $PendingReasons += "Windows Update"
}

# Check Component-Based Servicing (CBS) flag
if (Test-RegistryKey -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Component Based Servicing\RebootPending') {
    $IsRebootPending = $true
    $PendingReasons += "Component-Based Servicing"
}

# Check for Pending File Rename Operations
try {
    $pendingRename = Get-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager' -Name 'PendingFileRenameOperations' -ErrorAction Stop
    if ($pendingRename.PendingFileRenameOperations) {
        $IsRebootPending = $true
        $PendingReasons += "Pending File Rename Operations"
    }
} catch {
    # Do nothing if the property is not found
}

# Output the result
$DeviceName = $env:COMPUTERNAME

if ($IsRebootPending) {
    $reasonText = $PendingReasons -join ", "
    Write-Output "$DeviceName: Reboot is pending due to: $reasonText."
    exit 1
} else {
    Write-Output "$DeviceName: No reboot is pending."
    exit 0
}
