# [User Configurable Vars]
$DISPLAY_NAMES = @("Hammerdin") # Something that will help you identify the accounts, can be anything does not need to be your email
$WEB_TOKENS = @("US-REDACTED-1000000") # Token from https://us.battle.net/login/en/?externalChallenge=login&app=OSI
$D2R_EXE_PATH = "C:\Program Files (x86)\Diablo II Resurrected\D2R.exe" # The complete path to your D2R executable
$DEFAULT_REGION = "US" # Valid values ("US" "EU" "KR")
# DO NOT TOUCH ANYTHING BELOW THIS UNLESS YOU KNOW WHAT YOU ARE DOING
# [Constants]
$ENTROPY_BYTES = [byte[]] @(0xc8, 0x76, 0xf4, 0xae, 0x4c, 0x95, 0x2e, 0xfe, 0xf2, 0xfa, 0x0f, 0x54, 0x19, 0xc0, 0x9c, 0x43)
$REGISTRY_PATH = "HKCU:\SOFTWARE\Blizzard Entertainment\Battle.net\Launch Options\OSI"

# Admin check
if (!([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    if ((Get-ItemProperty HKLM:\Software\Microsoft\Windows\CurrentVersion\Policies\System).EnableLua -ne 0) {
        Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs; exit
    }
}

# Make sure we have handle.exe - do not assume the user is on a 64-bit system
if ((Get-Command "$PSScriptRoot\handle.exe" -ErrorAction SilentlyContinue) -eq $null) 
{ 
    Write-Host "Unable to find handle.exe. Please download it from https://learn.microsoft.com/en-us/sysinternals/downloads/handle and unzip handle.exe in the same folder as this script."
    Write-Host "Press enter to exit..."
    Read-Host
    exit
}

# Load System.Security so that we can encrypt the web token
Add-Type -AssemblyName System.Security

# Get accounts to launch
Write-Host "Accounts:"
for ($i=0; $i -lt @($DISPLAY_NAMES).length; $i++) {
    Write-Host "$($i+1). $($DISPLAY_NAMES[$i])"
}

if (!($accounts=Read-Host "Enter accounts to launch. E.g. ""1 3"". Press return to accept the default [ALL]") -or ($prompt -eq "ALL")) {
        $max = $DISPLAY_NAMES.length - 1
        $accounts_to_launch = 0..$max
    } else {
        $accounts_to_launch = $accounts.split()
        for ($i = 0; $i -lt $accounts_to_launch.Count; $i++) {
            $accounts_to_launch[$i] = [int]$accounts_to_launch[$i] - 1
        }
}

# Get region
Write-Host "Regions:"
Write-Host "1. Americas"
Write-Host "2. Europe"
Write-Host "3. Asia"
$region = switch (Read-Host "Enter 1, 2, or 3. Press return to accept the default [$($DEFAULT_REGION)]") {
    "1" {"US"}
    "2" {"EU"}
    "3" {"KR"}
    default {$DEFAULT_REGION}
}

# Launch each account
foreach ($index in $accounts_to_launch) {
    $display_name = $DISPLAY_NAMES[$index]

    # Kill D2R multi client prevention handle
    $handle_output = & "$PSScriptRoot\handle.exe" -v -p D2R.exe -a "DiabloII Check For Other Instances" -nobanner -accepteula
    if (@($handle_output).length -eq 2) {
        $parts = $handle_output[1].split(",")
        $process_id, $handle_id = $parts[1], $parts[3]
        & "$PSScriptRoot\handle.exe" -p $process_id -c $handle_id -y | Out-Null
    }

    # Wait for user to press enter between accounts
    if ($index -ne $accounts_to_launch[0]){
        Read-Host "Awaiting user input. Press enter to launch $($display_name)" | Out-Null
    } else {
        Write-Host("Launching $($display_name)")
    }

    # Update required registry entries
    $token = $WEB_TOKENS[$index]
    $token_bytes = [System.Text.Encoding]::UTF8.GetBytes($token)
    $protected_web_token = [System.Security.Cryptography.ProtectedData]::Protect($token_bytes, $ENTROPY_BYTES, [System.Security.Cryptography.DataProtectionScope]::CurrentUser)
    Set-ItemProperty -Path $REGISTRY_PATH -Name "REGION" -Value $region
    Set-ItemProperty -Path $REGISTRY_PATH -Name "WEB_TOKEN" -Value $protected_web_token -Type Binary
    
    # Launch the game
    Start-Process $D2R_EXE_PATH -ArgumentList "-uid OSI"

    if ($index -eq $accounts_to_launch[-1]) {
        Write-Host "Done..."
    } else {
        Start-Sleep -Seconds 8
    }
}