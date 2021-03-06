<#
 .SYNOPSIS
   List for serverl machines the drivers with size, free size and the percentage
   of free space.
 .DESCRITPION
   An important duty of a DBA is to check frequently the free space of the drives
   the SQL Server is using to avoid a database crash if a drive is full.
   With this Powershell script you can easily check all drivers for all servers
   in the given list. You can configure threshould value for Warning & Alarm level.
   Requires permission to connect to and fetch WMI data from the machine(s).
 .NOTES
   Author   : Olaf Helper
   Requires : Powershell Version 1.0
 .Jedi Speak
   This script from Microsoft script center.
#>

# Configuration data.
# Add your machine names to check for to the list:
[Array] $servers =  "szpubts001", `
                    "szpubts002", `
                    "szpubts003", `
                    "szpubts004", `
                    "szpubts005", `
                    "szpubts006", `
                    "szpubts007"; 
[float] $levelWarn  = 20.0;  # Warn-level in percent. 
[float] $levelAlarm = 10.0;  # Alarm-level in percent. 

# calculate secure string
# from "Baidu Search - key word "Get-WmiObject Credential 直接带入密码" "
$username = "f3219785";
$password = ConvertTo-SecureString "!qqyfk520" -AsPlainText -Force;
$ConnStr  = New-Object System.Management.Automation.PSCredential($username, $password);
 
# Defining output format for each column. 
$fmtDrive =@{label="Drv"      ;alignment="left"  ;width=3  ;Expression={$_.DeviceID};}; 
$fmtName  =@{label="Vol Name" ;alignment="left"  ;width=15 ;Expression={$_.VolumeName};}; 
$fmtSize  =@{label="Size MB"  ;alignment="right" ;width=12 ;Expression={$_.Size / 1048576};; FormatString="N0";}; 
$fmtFree  =@{label="Free MB"  ;alignment="right" ;width=12 ;Expression={$_.FreeSpace / 1048576}    ; FormatString="N0";}; 
$fmtPerc  =@{label="Free %"   ;alignment="right" ;width=10 ;Expression={100.0 * $_.FreeSpace / $_.Size}; FormatString="N1";}; 
$fmtMsg   =@{label="Message"  ;alignment="left"  ;width=12 ; `
              Expression={     if (100.0 * $_.FreeSpace / $_.Size -le $levelAlarm) {"Alarm !!!"} ` 
                           elseif (100.0 * $_.FreeSpace / $_.Size -le $levelWarn)  {"Warning !"} };}; 
 
foreach($server in $servers) 
{ 
    # Olaf src
    # $disks = Get-WmiObject -ComputerName $server -Class Win32_LogicalDisk -Filter "DriveType = 3"; 
    # Jedi add a permession check.
    $disks = Get-WmiObject -ComputerName $server -Credential $ConnStr -Class Win32_LogicalDisk -Filter "DriveType = 3"; 
         
    Write-Output ("Server: {0}`tDrives #: {1}" -f $server, $disks.Count); 
    Write-Output $disks | Format-Table $fmtDrive, $fmtName, $fmtSize, $fmtFree, $fmtPerc, $fmtMsg; 
}
