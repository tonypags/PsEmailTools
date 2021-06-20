function Get-LocalConfigPath {

    if ($IsWindows) {

        Join-Path $env:LocalAppData (
            'Microsoft'
        ) -AdditionalChildPath @(
            'WindowsPowerShell'
            'Modules'
            'PsEmailTools'
            'config'
            'properties.ini'
        )

    } elseif ($IsMacOS) {

        Join-Path '~' '.config' -AdditionalChildPath @(
            'PowerShell'
            'Modules'
            'PsEmailTools'
            'properties.ini'
        )
    
    } elseif ($IsLinux) {

        Join-Path '~' '.config' -AdditionalChildPath @(
            'PowerShell'
            'Modules'
            'PsEmailTools'
            'properties.ini'
        )

    }
}
