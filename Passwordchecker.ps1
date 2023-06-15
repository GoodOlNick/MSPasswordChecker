function Validate-Password {
    param (
        [Parameter(Mandatory = $true)]
        [String]$Password
    )

    # Minimum length: 8 characters
    if ($Password.Length -lt 8) {
        Write-Output "Password does not meet the minimum length requirement (8 characters)."
        return
    }

    # Complexity requirements: At least 1 uppercase, 1 lowercase, 1 digit, and 1 special character
    if (-not ($Password -match "[A-Z]") -or
        -not ($Password -match "[a-z]") -or
        -not ($Password -match "[0-9]") -or
        -not ($Password -match "[^a-zA-Z0-9]")) {
        Write-Output "Password does not meet the complexity requirements (1 uppercase, 1 lowercase, 1 digit, and 1 special character)."
        return
    }

    Write-Output "Password meets Microsoft's criteria."
}

# Loop to check multiple passwords
while ($true) {
    $password = Read-Host -AsSecureString "Enter password"
    $plainTextPassword = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto([System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($password))

    Validate-Password -Password $plainTextPassword

    Write-Output "Entered Password: $plainTextPassword"

    Write-Host "Press any key to check another password, or press 'Q' to quit."
    $key = $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown").Character
    if ($key -eq 'q' -or $key -eq 'Q') {
        break
    }
}