Function Import-ScriptConfigFile {
    [CmdletBinding()]
    param(
        [Parameter(
            Mandatory = $true
        )]
        [string]$ScriptConfigFileLocation
    )
    <#
    Required Functions:
        https://raw.githubusercontent.com/dpaulson45/PublicPowerShellFunctions/master/src/Common/Write-VerboseWriters/Write-VerboseWriter.ps1
    #>

    Write-VerboseWriter("Calling: Import-ScriptConfigFile")
    Write-VerboseWriter("Passed: [string]ScriptConfigFileLocation: '$ScriptConfigFileLocation'")

    if (!(Test-Path $ScriptConfigFileLocation)) {
        throw [System.Management.Automation.ParameterBindingException] "Failed to provide valid ScriptConfigFileLocation"
    }

    try {
        $content = Get-Content $ScriptConfigFileLocation -ErrorAction Stop
        $jsonContent = $content | ConvertFrom-Json
    } catch {
        throw "Failed to convert ScriptConfigFileLocation from a json type object."
    }

    $jsonContent |
        Get-Member |
        Where-Object { $_.Name -ne "Method" } |
        ForEach-Object {
            Write-VerboseWriter("Adding variable $($_.Name)")
            Set-Variable -Name $_.Name -Value ($jsonContent.$($_.Name)) -Scope Script
        }
}