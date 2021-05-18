$Path = "F:\AD-IT\Project\Welle\" # путь папки
$PathTemp = "F:\AD-IT\Project\Welle\temp\" # путь папки с временными файлами
$File1 = "Ost_Sklad.csv" # файл выгрузки из 1С
$File2 = "Signal_Meble.csv" # файл выгрузки из FTP
$List = "list.csv" # файл списка по которому будут удаляться дубляжи
$ListWrite = "ListWrite.csv" # Промежуточный файл перезаписи
$Merge = "merge.csv" # временный файл слияния
$Fileout = "Result.csv" # Итоговый файл

# Сохранение в UTF8 и удаление последней строки, добавление во временную директорию +
Get-Content $Path$File1 | ForEach-Object { $prev = $null } {if ($null -ne $prev) { $prev } $prev = $_} | Out-File $PathTemp$File1 -Encoding UTF8

# Вытянуть шапку из 1 файла и добавить ее в другой, добавить во временную директорию
[array]$newRow = Get-Content $Path$File1  | Select-Object -Index 0
$csv = Get-Content $Path$File2 
$newCSV = $newRow + $csv | Set-Content $PathTemp$File2 -Encoding UTF8

# Создание списка кодов по которому будут удаляться строки во 2 файле
Import-Csv $PathTemp$File1 -Delimiter ";" -Encoding default | Select-Object SKU | Export-Csv $PathTemp$List -Delimiter ";" -NoTypeInformation -Encoding UTF8

# Цикл удаления строк с последующей перезаписью из 2 файла
$result2=Import-Csv -Delimiter ";" -Path $PathTemp$List -Encoding default 
foreach ($obj2 in $result2)
{
    Get-Content -Path $PathTemp$File2 | Where-Object { $_ -notmatch $obj2.SKU} | Set-Content $PathTemp$ListWrite
    Get-Content -Path $PathTemp$ListWrite | Set-Content $PathTemp$File2
}

# Удаление шапки из 2 файла 
Get-Content -Path $PathTemp$File2 | Where-Object { $_ -notmatch "SKU" } | Set-Content $PathTemp$Merge

# Слияние
$Files1 = Get-Content $PathTemp$File1
$Files2 = Get-Content $PathTemp$Merge
$FileRes = $Files1 + $Files2 | Set-Content $Path$Fileout