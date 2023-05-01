function Get-HttpResponseResult {
    param (
        [Parameter(ValueFromPipeline=$true)]
        [PSCustomObject]
        $TestArgs,
        # Maximum Retry Number
        [Parameter()][int]$MaxRetryNo = 10,
        # Time to wait until next retry
        [Parameter()][int]$WaitTimeInSecondes = 1
    )
    $ProgressPreference = 'SilentlyContinue'

    $Method = 'Get'

    $TestCounter = 0

    while($TestCounter -lt $MaxRetryNo) {

        #Increment our counter by 1 before we make our first attempt
        $TestCounter++

        $duration = Measure-Command {
            $Response = Invoke-WebRequest -Uri $TestArgs.url -Method $Method -SkipHttpErrorCheck
        }

        if($Response.StatusCode.ToString() -eq "200"){
            break;
        }
        else {
            Start-Sleep -Seconds $WaitTimeInSecondes
        }
    }
    

    $result = [PSCustomObject]@{
        name = $TestArgs.name
        status_code = $Response.StatusCode.ToString()
        status_description = $Response.StatusDescription
        attempt_no = "$($TestCounter)/$($MaxRetryNo)"
        responsetime_ms = $duration.Milliseconds
        timestamp = (get-date).ToString('O')
    }

    return $result
}