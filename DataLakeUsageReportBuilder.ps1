  #Script takes five arguments
  # arg0 = Storage Account Name
  # arg1 =  Container Name
  # arg2 = verbose/silent verbose = print file names
  # arg3 = Input file path and file name
  # arg4 = Output file path and file name
  
  $Verbose = $args[1]
  $inputfile = $args[2]
  $outputfile = $args[3]
  
  #Get the Login context. You must run the Connect-AzAccount script before running this script
  $ctx = New-AzStorageContext -StorageAccountName $args[0] -UseConnectedAccount

  # Check if file already exists
  $fileExists = Test-Path -Path $outputfile -PathType Leaf
  if ( $fileExists )
  {
    #Clear the any existing content in the output file
    Clear-Content -Path $outputfile
  }

  # Add the output file headers
  Add-Content -Path $outputfile  -Value 'Container,Path,Size'

  Write-Host "Reading File... "
    
  # Read the Input file
  Import-Csv $inputfile |
    ForEach-Object {
      #for each record sum up the size of all the file in the path Recursively
      $totalSize = 0
      do
      {
        #Use Recurse and Continuation Token to read all the files
        $gen2ChildItems = Get-AzDataLakeGen2ChildItem  -Context $ctx -FileSystem $_.Container -Path $_.Path  -Recurse -FetchProperty -ContinuationToken $Token
        
        # loop through each child item and calculate the size by adding all the child file items
        
        foreach ($childItem in $gen2ChildItems) {
            #If File, add the size to total size
            if (!$childItem.IsDirectory) {   
                $totalSize += $childItem.Length

                if ($Verbose -eq 'verbose')
                {  
                    Write-Host $childItem.Path, " : ", $childItem.Length
                }                  
            }     
        }
       } 
       While ($Token -ne $Null)
    
            # Write the results to the output file
            $output = $.Container + "," + $_.Path + ',' + $totalSize
            Add-Content -Path $outputfile  -Value $output

            if ($Verbose -eq 'verbose')
            {
                Write-Host "---------------------------------------------------"
                Write-Host ""
                Write-Host "Total size of ", $_.Path , " : " $totalSize
            }
    }

Write-Host "Done."
