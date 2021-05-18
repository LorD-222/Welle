$Path = "C:\Projects\Welle\" # путь папки
$PathTemp = "C:\Projects\Welle\temp\" # путь папки с временными файлами
$File1 = "Ost_Sklad.csv" # файл выгрузки из 1С
$File2 = "Signal__Meble.csv" # файл выгрузки из FTP
$Merge = "merge.csv" # временный файл слияния
$MergeUnic = "MergeUnic.csv" # временный файл слияния без дубляжей
$Fileout = "res1.csv" # Итоговый файл

#$User = "ZOOMCSZ"
#Import-Csv -Path $PathTemp$File2 -Delimiter ";"| Where-Object { $_ -notmatch $User } | Export-Csv test.csv -Delimiter ";" -NoTypeInformation -Encoding UTF8
#Get-Content -Path $PathTemp$File2 | Where-Object { $_ -notmatch $User } | Add-Content test1.csv

<#
$result=Import-Csv -Delimiter ";" -Path $PathTemp$File1 -Encoding default|?{!$_.value}
$result1=Import-Csv -Delimiter ";" -Path $PathTemp$File2 -Encoding default|?{!$_.value}
foreach ($obj1 in $result1)
{
    foreach ($obj in $result)
    {
        if($obj.SKU -eq $obj1.SKU)
        {
            Get-Content -Path $PathTemp$File2 | Where-Object { $_ -notmatch $obj.SKU } | Add-Content test1.csv 
        } 
    }
}
#>

$result1=Import-Csv -Delimiter ";" -Path C:\Projects\Welle\temp\Ost_Sklad.csv -Encoding default
foreach ($obj1 in $result1)
{
    if( -eq $obj1)
    {
        $obj1.SKU #| Add-Content testSKU.csv
    }

}


#Import-Csv 2.csv -Delimiter ";" | Sort-Object -Unique SKU| Export-Csv res1.csv -Delimiter ";" -NoTypeInformation -Encoding UTF8 
