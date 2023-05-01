[CmdletBinding()]
param (
    [Parameter(ValueFromPipeline = $true)]
    [string]
    $TestsFilePath =  '.\endpoints.json'
)

# Convert JSON Config Files String value to a PowerShell Object
$TestsObj = Get-Content -Path $TestsFilePath | ConvertFrom-Json

# Import the Tester Function
. ./lib/Get-HttpResponseResult.ps1

# Loop through Test Objects and get the results as a collection
$TestResults = foreach ($Test in $TestsObj) { 
    Get-HttpResponseResult -TestArgs $Test 
}

$TestResults | Format-Table -AutoSize