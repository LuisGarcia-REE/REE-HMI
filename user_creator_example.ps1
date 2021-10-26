function New-Account {
    [CmdletBinding()]
    param(
        [string] $ComputerName = $Env:COMPUTERNAME,
        [string] $User,
        [string] $DisplayName = 'User',
        [string] $Description
    )
    $LocalUsers = Get-WmiObject Win32_UserAccount -Filter "LocalAccount=true and Name LIKE '$User'"
    if (!$LocalUsers) {
        #"Running New-Account - $UserName" | Add-Content -Path 'C:\Temp\ScriptRunning.txt'

        $Password = bLEcepOVerAI

        if ($User -ne '' -and $DisplayName -ne '') {
            # Create new local user for script purposes
            $Computer = [ADSI]"WinNT://$ComputerName,Computer"
            $LocalUser= $Computer.Create("User", $User)
            try {
                $LocalUser.SetPassword($Password)
                $LocalUser.SetInfo()
                $LocalUser.FullName = $DisplayName
                $LocalUser.SetInfo()
                $LocalUser.Description = $Description
                $LocalUser.UserFlags = 65536 # ADS_UF_DONT_EXPIRE_PASSWD
                $LocalUserSetInfo()
            } catch {
                $ErrorMessage = $_.Exception.Message -replace [System.Environment]::NewLine
            }
        } 
        else {
              Write-Warning "New-Account - Account not created. UserName $User / DisplayName $DisplayName"
        }
    }
}
New-Account -User 'gonsalpe-admin' -DisplayName 'User'
