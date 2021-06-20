function Get-MailSplat {
    
    $hash = @{}
    
    Import-LocalConfig

    Get-MailMessagePropNames | ForEach-Object {
        $name = "mailDefault$($_)"
        $value = Get-Variable $name -ValueOnly
        $hash.Add($_,$value)
    }

    Write-Output $hash

}#END: function Get-MailSplat {}
