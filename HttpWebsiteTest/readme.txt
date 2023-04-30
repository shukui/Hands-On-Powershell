Scenario:
There is a project with multiple public web endpoints exposed to Internet. Your hosting provider is having an intermittent network outage on their load balancing infrastructure. You need to write a powershell script:
That accepts a list of urls to perform Http Ping Test (Http Get Request) from a configuration file
Performs a Http Get request test for given list of endpoints and return test results containing
1.Status Code Returned Http Response
2.Status Description For the Http Response
3.Response time of the request
4.Timestamp for the test result as a collection
5.Prints results to terminal in a human readable format

Solution:
1.\lib\Get-HttpResponseResult.ps1 define function to handle parameters and http response.
2.HttpEndpointsPingTest.ps1 for loop json objects and invoke Get-HttpResponseResult function.
3.endpoints.json stores url and website name.

Tips:
1. From Powershell Version 7, invoke-webrequest command has -SkipHttpErrorCheck parameter as an option.