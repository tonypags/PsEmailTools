function Import-LocalConfig {
    <#
    .SYNOPSIS
    Loads any values into variables defined under the given path.
    #>
    [CmdletBinding()]
    param (
        [Parameter()]
        [ValidateNotNull()]
        [string]
        $ConfigPath = (Get-LocalConfigPath)
    )
    
    # Help new users if the file is missing
    if (Test-Path $ConfigPath) {} else {
        Write-Warning "File not found!"
        Write-Warning "Please run New-LocalConfig"
        break
    }

    $rawHash = ConvertFrom-StringData(
        (Get-Content $ConfigPath) -join "`n"
    )
    ForEach ($Key in $rawHash.Keys) {
        $props = @{
            Name  = $Key
            Value = $rawHash[$Key]
        }
        New-Variable @props -Force
    }

}#END: function Import-LocalConfig {}
