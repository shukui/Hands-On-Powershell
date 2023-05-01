#delete old tmp files,just save files in 15 days~
$TimeOutDays=20    
$filePath="C:\Users\OneDrive\FileStorage\Image"     
$allFiles=get-childitem -path $filePath     
foreach ($files in $allFiles)     
{       
   $daypan=((get-date)-$files.lastwritetime).days       
   if ($daypan -gt $TimeOutDays)       
   {         
     remove-item $files.fullname -Recurse -force       
    }     
}