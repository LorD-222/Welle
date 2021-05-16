$Path = "F:\AD-IT\Project\Welle\" # путь папки
$PathTemp = "F:\AD-IT\Project\Welle\temp\" # путь папки с временными файлами
$File1 = "Ost_Sklad.csv" # файл выгрузки из 1С
$File2 = "Signal__Meble.csv" # файл выгрузки из FTP
$FileType = "*.csv" # все файлы типа csv
$Merge = "merge.csv" # временный файл слияния
$Unic = "SKU" # по какому столбцу проверять на уникальность
$Fileout = "res1.csv" # Итоговый файл


# Сохранение в UTF8 и удаление последней строки, добавление во временную папку
Get-Content $Path$File1 | ForEach-Object { $prev = $null } {if ($null -ne $prev) { $prev } $prev = $_} | Out-File $PathTemp$File1 -Encoding UTF8 

# файл выгрузки из FTP в кодировку UTF8 и добавление во временную папку
Get-Content $Path$File2 | Out-File $PathTemp$File2 -Encoding UTF8
Get-Content "F:\AD-IT\Project\Welle\temp\Ost_Sklad.csv" | Select-Object -Index 0  | Out-File $PathTemp$File2 -Append -Encoding UTF8
Import-Csv $PathTemp$File2 -Delimiter ";" | Export-Csv res1.csv -Delimiter ";" -NoTypeInformation -Encoding UTF8
Import-Csv res1.csv -Delimiter ";" | Sort-Object -Unique "SKU","Наименование","Количество" #| Export-Csv "F:\AD-IT\Project\Welle\temp\1.csv" -Delimiter ";" -NoTypeInformation -Encoding UTF8
# слияние
#Get-Content $PathTemp$FileType |Get-item $SKU | Add-Content $PathTemp$Merge 

