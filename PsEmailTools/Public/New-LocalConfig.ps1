function New-LocalConfig {
    
    $FilePath = Get-LocalConfigPath
    if (Test-Path $FilePath) {} else {
        New-Item $FilePath -ItemType File -Force
    }

    $propNames = @(Get-MailMessagePropNames)

    foreach ($name in $propNames) {

        $msg = "Enter a new value for $($name)"
        $response = Read-Host $msg
        
        "$($name)=$($response)" |
            Out-File $FilePath -Append

    }

}#END: function New-LocalConfig {}
