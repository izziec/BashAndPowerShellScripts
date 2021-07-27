param
(
    [string]$Directory = "C:\Users\$env:USERNAME",
    [switch]$Recurse = $false,
    [string]$Mode = "Duplicate",
    [int]$Months = 12
)

Set-StrictMode -Version latest

#Write-Host "$Directory $Recurse $Mode $Months"

# check for valid $Directory path
if (Test-Path -Path $Directory){}else {
    Write-Host "$Directory Directory Path Invalid. Please enter valid directory path."
    Exit 1
}

if($Mode -like "Duplicate")
{
    [string[]]$Allchilditems = $null
    $Checksum = $null
    if($Recurse -eq $false)
    {
        $Allchilditems = Get-ChildItem -Path $Directory -File | Group-Object Length | Where-Object {$_.Count -gt 1} | select -ExpandProperty group | foreach {Get-FileHash -Algorithm SHA256 -LiteralPath $_.FullName} | group -Property hash | where {$_.count -gt 1} | select -ExpandProperty group | Format-Table | Out-String | %{Write-Host $_}
    }else {
        $Allchilditems = Get-ChildItem -Path $Directory -Recurse -File | Group-Object Length | Where-Object {$_.Count -gt 1} | select -ExpandProperty group | foreach {Get-FileHash -Algorithm SHA256 -LiteralPath $_.FullName} | group -Property hash | where {$_.count -gt 1} | select -ExpandProperty group | Format-Table | Out-String | %{Write-Host $_}
    }
}
elseif($Mode -like "Access")
{
    # error checking for $Month
    if($Months -lt 0)
    {
        #error checking for $Month
        Write-Host "Month cannot be negative. Please enter valid month."
        Exit 4
    }

     $cutOffMonth = (Get-Date).AddMonths(-$Months)

    if($Recurse -eq $false)
    {
        $Allchilditems = Get-ChildItem -Path $Directory -File | Where-Object {$_.LastAccessTime -le $cutOffMonth} | Format-Table | Out-String | %{Write-Host $_}
    }else {
        $Allchilditems = Get-ChildItem -Path $Directory -Recurse -File | Where-Object {$_.LastAccessTime -le $cutOffMonth} | Format-Table | Out-String | %{Write-Host $_}
    }

}else {
    # error checking for $Mode
    Write-Host "$Mode Mode Invalid. Mode can only be Duplicate(Default) or Access."
}
