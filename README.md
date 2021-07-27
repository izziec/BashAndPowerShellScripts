# BashBatchScripts

## SpaceSaver.ps1
Parameters - “Directory” (default of “C:\Users\UserName”)

“Recurse” (default of $false, can be a switch), “Mode” (default of “Duplicate”)

“Months” (default of 12)

Mode “Duplicate” (or “dUplicatE” or any other case-variant representation) searches for duplicate files in $Directory (and its subdirectories if $Recurse is “True”) by creating a checksum (i.e., digital signature or hash value) of every file and comparing it to every other file. Uses Get-FileHash with the SHA256 algorithm and report information to user. The Months variable is ignored when in this mode. If there are duplicates, the associative array’s value for their common key should be a string with some unique character as the separator between all the files with their absolute paths.

Mode “Access” searches for files in $Directory (and its subdirectories if $Recurse is “True”) that have not been accessed in the last $Months.
