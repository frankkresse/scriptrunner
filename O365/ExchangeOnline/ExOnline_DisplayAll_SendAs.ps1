﻿<#
    .SYNOPSIS 
    Connect to Exchange Online.

    .PARAMETER cred
    Exchange Online credential



#>

param(
   [PSCredential]$cred
   

)

###################################################################
# Exchange Online Remote PowerShell
# Requires .Net Framework 4.5
# no addional install!
# Create Session to Exchange Online
$session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://outlook.office365.com/powershell-liveid/ -Credential $cred -Authentication Basic -AllowRedirection -ErrorAction Stop -Verbose

try 
{
    'Session created!'
    Import-PSSession $session -DisableNameChecking

    Get-RecipientPermission | where {($_.Trustee -ne 'nt authority\self') -and ($_.Trustee -ne 'Null sid')} | select Identity,Trustee,AccessRights

    $a = Get-RecipientPermission | where {($_.Trustee -ne 'nt authority\self') -and ($_.Trustee -ne 'Null sid')} | select Identity,Trustee,AccessRights
	$SRXEnv.ResultMessage = $a
	$a
   
}
finally 
{
    'finally:'
    Get-PSSession
    if ($session) 
    {
        'Removing Session...'
        Remove-PSSession -Session $session 
    }
}