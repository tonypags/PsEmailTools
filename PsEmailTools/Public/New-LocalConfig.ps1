function New-LocalConfig {
    
    param(
        [Parameter()]
        [ValidateNotNull()]
        [string]
        $ConfigPath = (Get-LocalConfigPath)
    )

    if (Test-Path $ConfigPath) {} else {
        New-Item $ConfigPath -ItemType File -Force
    }

    $propNames = @(Get-MailMessagePropNames)

    foreach ($name in $propNames) {
        
        $msg = "Enter a new value for $($name)"

        switch ($name) {

            'SmtpServer' {
                $response = Read-Host $msg
                break
            }

            'Credential' {

                # $msg = "Enter $($name) for SMTP Server"
                # $response = Get-Credential -Message $msg
                Write-Verbose "$($name) parameter is not supported at this time."
                break
            }

            ('UseSsl' -or 'BodyAsHtml') {
                $msg = "Should we $($name) by default (y/n)?"
                $response = Read-Host $msg
                $response = if ($response -eq 'y') {$true} else {$false}
                break
            }

            ('To' -or 'Cc' -or 'Bcc') {

                $msg = "Enter one email address for $($name) (blank to stop loop)"
                $response = '1'
                while ($response) {
                    $response = Read-Host $msg
                    $colItems += $response
                }
                $response = $colItems -join ','
                break

            }

            Default {
                $response = Read-Host $msg

            }
            
        }#END: switch ($name) {}
                
        "$($name)=$($response)" |
        Out-File $ConfigPath -Append

    }#END: foreach ($name in $propNames) {}

    Get-Item $ConfigPath

}#END: function New-LocalConfig {}
