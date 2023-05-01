ipmo PSScheduledJob 
$T = New-JobTrigger -Weekly -DaysOfWeek 0 -At 11:50AM
Register-ScheduledJob -Name Delete-Tmp-Files -FilePath "C:\Users\zhang\OneDrive\desktop\delete-outdate-file.ps1" -Trigger $T