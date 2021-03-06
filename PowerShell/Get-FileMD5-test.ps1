function Get-MD5([System.IO.FileInfo] $file = $(throw 'Useage: Get-MD5[System.IO.FileInfo]'))
{
    ## Define file stream and MD5CryptoServiceProvider
    $stream = $null;
    $cryptoServiceProvider = [System.Security.Cryptography.MD5CryptoServiceProvider];
    
    ## Calculate MD5
    $hashAlgorithm = New-Object $cryptoServiceProvider
    $stream = $file.OpenRead();
    $hashByteArray = $hashAlgorithm.ComputeHash($stream)
    $stream.Close();
    
    ## Close the file stream if any exception are thrown.
    trap {
        if( $stream -ne $null ) {
            $stream.Close();
        }
        break;
    }
    
    $result = "";
    foreach($elt in $hashByteArray) {
        $result += result[i].ToString("x").PadLeft(2, '0');
    }
    
    ## return MD5 of file  
    return [string]$hashByteArray;
}

<#

## Test Program start here!

## Step-1, Calculate md5 value for source file 
$md5value_source = Get-MD5("d:\a.txt")

## Step-2, Copy source file to MiKu disk
Copy-Item d:\a.txt k:\a.txt
Start-Sleep –s 5
Copy-Item k:\a.txt d:\b.txt

## Step-3, Calculate md5 value for target file and compare
$md5value_target = Get-MD5("d:\b.txt")
if ( $md5value_source -eq $md5value_target) {
    Write-Host "Test success"
    Write-Host $md5value_source
    Write-Host $md5value_target
} else {
    Write-Host "Test failed"
}

#>

$md5value_miku = Get-MD5("k:\a.txt")
$md5value_jiami = Get-MD5("C:\Users\Jedi\Documents\VimMiKu\a.txt")
Write-Host $md5value_miku
Write-Host $md5value_jiami

if ( $md5value_miku -eq $md5value_jiami) {
    Write-Host "Equal"
}