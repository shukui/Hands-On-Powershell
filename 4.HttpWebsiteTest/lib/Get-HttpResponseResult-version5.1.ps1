function Get-HttpResponseResult {
    param (
        [Parameter(ValueFromPipeline=$true)]
        [PSCustomObject]
        $TestArgs
    )
    $ProgressPreference = 'SilentlyContinue'

    $Method = 'Get'

    $duration = Measure-Command {
        $Response = try { Invoke-WebRequest -Uri $TestArgs.url -Method $Method 
        } catch [System.Net.WebException] { 
            Write-Verbose "An exception was caught: $($_.Exception.Message)"
            $_.Exception.Response 
        } 
    }

    $result = [PSCustomObject]@{
        name = $TestArgs.name
        status_code = $Response.StatusCode.ToString()
        status_description = $Response.StatusDescription
        responsetime_ms = $duration.Milliseconds
        timestamp = (get-date).ToString('O')
    }

    return $result
}