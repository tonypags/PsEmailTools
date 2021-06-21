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
    
    if (Test-Path $ConfigPath) {
        
        $rawHash = ConvertFrom-StringData (
            (Get-Content $ConfigPath) -join "`n"
        )

        ForEach ($Key in $rawHash.Keys) {

            $rawValue = $rawHash[$Key].trim()

            $Value = if ($rawValue -like '*,*') {

                $rawValue -split ','

            } elseif ($rawValue -match '^\d+$') {

                $rawValue[$Key] -as [int]
                
            } else {

                $rawValue[$Key]
                
            }

            $props = @{
                Name  = $Key
                Value = $Value
            }
            New-Variable @props -Force
        }
        
    } else {
            
        # Help new users if the file is missing
        Write-Warning "File not found!"
        Write-Warning "Please run New-LocalConfig"

    }

}#END: function Import-LocalConfig {}
