$Path = "F:\AD-IT\Project\Welle\" # путь папки
$PathTemp = "F:\AD-IT\Project\Welle\temp\" # путь папки с временными файлами
$File1 = "Ost_Sklad.csv" # файл выгрузки из 1С
$File2 = "Signal__Meble.csv" # файл выгрузки из FTP
$FileType = "*.csv" # все файлы типа csv
$Merge = "merge.csv" # временный файл слияния
$Unic = "SKU" # по какому столбцу проверять на уникальность
$Fileout = "res1.csv" # Итоговый файл

$result=Import-Csv -Delimiter ";" -Path $PathTemp$File1 -Encoding default|?{!$_.value}
$result1=Import-Csv -Delimiter ";" -Path $PathTemp$File2 -Encoding default|?{!$_.value}
foreach ($obj1 in $result1)
{
    foreach ($obj in $result)
    {
        if($obj.SKU -ne $obj1.SKU)
        {
            $obj1   | Export-Csv 2.csv -Delimiter ";" -NoTypeInformation -Append -Encoding UTF8 
        } 
        
    }
}
Import-Csv 2.csv -Delimiter ";" | Sort-Object -Unique SKU| Export-Csv res1.csv -Delimiter ";" -NoTypeInformation -Encoding UTF8 
#$res | Sort-Object -Unique SKU | Export-Csv 2.csv -Delimiter ";" -NoTypeInformation -Encoding UTF8 
#Import-Csv res1.csv -Delimiter ";" -header SKU, "Наименование", "Количество"| Export-Csv res2.csv -Delimiter ";" -NoTypeInformation -Encoding UTF8
#Import-Csv res1.csv -Delimiter ";" | Export-Csv res3.csv -Delimiter ";" -NoTypeInformation -Encoding UTF8