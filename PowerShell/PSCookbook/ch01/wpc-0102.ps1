<#
    File name: wpc-0102.ps1
    Reference:
        Windows Powershell Cookbook 2nd - 1.2
    Problem:
        You have a command line that works from cmd.exe, and want to resolve
        errors that occur from running that command in PowerShell.
    Solution:
        PS > cmd /c echo '!"#$%''()*=,-./09:;<=>?@AZ[\]^`az{|}~'
#>
cmd /c echo '!"#$%''()*=,-./09:;<=>?@AZ[\]^`az{|}~'
