$Path = "C:\Projects\Welle\" # путь папки
$PathTemp = "C:\Projects\Welle\temp\" # путь папки с временными файлами
$File1 = "Ost_Sklad.csv" # файл выгрузки из 1С
$File2 = "Signal__Meble.csv" # файл выгрузки из FTP
$Merge = "merge.csv" # временный файл слияния
$MergeUnic = "MergeUnic.csv" # временный файл слияния без дубляжей
$Fileout = "res1.csv" # Итоговый файл

# Сохранение в UTF8 и удаление последней строки, добавление во временную директорию
Get-Content $Path$File1 | ForEach-Object { $prev = $null } {if ($null -ne $prev) { $prev } $prev = $_} | Out-File $PathTemp$File1 -Encoding UTF8

# Вытянуть шапку из 1 файла и добавить ее в другой, добавить во временную директорию
[array]$newRow = Get-Content $Path$File1  | Select-Object -Index 0
$csv = Get-Content $Path$File2 
$newCSV = $newRow + $csv | Add-Content $PathTemp$File2 -Encoding UTF8

<# Проверка на уникальность с занесением во временный файл
$result=Import-Csv -Delimiter ";" -Path $PathTemp$File1 -Encoding default|?{!$_.value}
$result1=Import-Csv -Delimiter ";" -Path $PathTemp$File2 -Encoding default|?{!$_.value}
foreach ($obj1 in $result1)
{
    foreach ($obj in $result)
    {
        if($obj.SKU -eq $obj1.SKU)
        {
         Import-Csv $PathTemp$File2 -Delimiter ";"| Remove-Item $obj | Export-Csv $PathTemp$Merge -Delimiter ";" -NoTypeInformation -Append -Encoding UTF8 
        } 
    }
}
#>

# убираем полученные дубляжи
#Import-Csv $PathTemp$Merge -Delimiter ";" | Sort-Object -Unique SKU| Export-Csv $PathTemp$MergeUnic  -Delimiter ";" -NoTypeInformation -Encoding UTF8


<# слияние
$Files1 = Get-Content $PathTemp$File1
$Files2 = Get-Content $PathTemp$Merge
$FileRes = $Files1 + $Files2 | Add-Content $Path$Fileout
#>
