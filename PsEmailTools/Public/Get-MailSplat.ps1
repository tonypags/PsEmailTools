function Get-MailSplat {
        
    param(
        [Parameter()]
        [ValidateNotNull()]
        [string]
        $ConfigPath = (Get-LocalConfigPath)
    )

    $hash = @{}
    
    Import-LocalConfig -ConfigPath $ConfigPath

    Get-MailMessagePropNames | ForEach-Object {
        $name = "mailDefault$($_)"
        $value = Get-Variable $name -ValueOnly
        $hash.Add($_,$value)
    }

    Write-Output $hash

}#END: function Get-MailSplat {}
