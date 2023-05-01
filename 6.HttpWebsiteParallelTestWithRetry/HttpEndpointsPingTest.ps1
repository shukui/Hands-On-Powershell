[CmdletBinding()]
param (
    [Parameter(ValueFromPipeline = $true)]
    [string]
    $TestsFilePath =  '.\endpoints.json'
)

# StopWatch Object calculate time.
$Stopwatch = [System.Diagnostics.Stopwatch]::new()

# Start the timer.
$Stopwatch.Start()

# Convert JSON Config Files String value to a PowerShell Object
$TestsObj = Get-Content -Path $TestsFilePath | ConvertFrom-Json

# Import the Tester Function
. ./lib/Get-HttpResponseResult.ps1

$funcDef = ${function:Get-HttpResponseResult}.ToString()

$jobs = $TestsObj | ForEach-Object -Parallel {

    ${function:Get-HttpResponseResult} = $using:funcDef

    Get-HttpResponseResult -TestArgs $_
} -AsJob -ThrottleLimit 50

$jobs | Receive-Job -Wait | Format-Table

# Now Stop the timer.
$Stopwatch.Stop()

$TestDuration  =  $Stopwatch.Elapsed.TotalSeconds

Write-Host "Total Script Execution Time: $($TestDuration) Seconds"
