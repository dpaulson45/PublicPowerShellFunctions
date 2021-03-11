Function Get-ExchangeBuildVersionInformation {
    [CmdletBinding()]
    param(
        [object]$AdminDisplayVersion
    )
    <#
    Required Functions:
        https://raw.githubusercontent.com/dpaulson45/PublicPowerShellFunctions/master/src/Write-VerboseWriters/Write-VerboseWriter.ps1
    #>

    Write-VerboseWriter("Calling: Get-ExchangeBuildVersionInformation")
    Write-VerboseWriter("Passed $($AdminDisplayVersion.ToString())")

    if ($AdminDisplayVersion.GetType().Name -eq "string") {
        Write-VerboseWriter("String type object detected being passed.")
        $split = $AdminDisplayVersion.Substring(($AdminDisplayVersion.IndexOf(" ")) + 1, 4).split('.')
        $major = [int]$split[0]
        $minor = [int]$split[1]
        $product = $major + ($minor / 10)

        $buildStart = $AdminDisplayVersion.LastIndexOf(" ") + 1
        $split = $AdminDisplayVersion.Substring($buildStart, ($AdminDisplayVersion.LastIndexOf(")") - $buildStart)).Split(".")
        $build = [int]$split[0]
        $revision = [int]$split[1]
        $revisionDecimal = if ($revision -lt 10) { $revision / 10 } else { $revision / 100 }
        $buildVersion = $build + $revisionDecimal
    } else {
        $major = $AdminDisplayVersion.Major
        $minor = $AdminDisplayVersion.Minor
        $product = $major + ($minor / 10)
        $build = $AdminDisplayVersion.Build
        $revision = $AdminDisplayVersion.Revision
        $revisionDecimal = if ($revision -lt 10) { $revision / 10 } else { $revision / 100 }
        $buildVersion = $build + $revisionDecimal
    }

    Write-VerboseWriter("Determining Major Version based off of $product")

    switch ([string]$product) {
        "14.3" { $exchangeMajorVersion = "Exchange2010" }
        "15" { $exchangeMajorVersion = "Exchange2013" }
        "15.1" { $exchangeMajorVersion = "Exchange2016" }
        "15.2" { $exchangeMajorVersion = "Exchange2019" }
        default { $exchangeMajorVersion = "Unknown" }
    }

    Write-VerboseWriter("Found Major Version '$exchangeMajorVersion'")
    return [PSCustomObject]@{
        MajorVersion = $exchangeMajorVersion
        Major        = $major
        Minor        = $minor
        Build        = $build
        Revision     = $revision
        Product      = $product
        BuildVersion = $buildVersion
    }
}