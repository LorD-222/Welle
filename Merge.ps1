$Path = "C:\Users\rii\Documents\csv\" # путь папки
$PathTemp = "C:\Users\rii\Documents\csv\temp\" # путь папки с временными файлами
$File1 = "Ost_Sklad.csv" # файл выгрузки из 1С
$File2 = "Signal__Meble.csv" # файл выгрузки из FTP
$FileType = "*.csv" # все файлы типа csv
$Merge = "merge.csv" # временный файл слияния
$Unic = "SKU" # по какому столбцу проверять на уникальность
$Fileout = "res1.csv" # Итоговый файл

Get-Content $path$file1 | ForEach-Object { $prev = $null } {if ($null -ne $prev) { $prev } $prev = $_} | Set-Content $PathTemp$file1 # удаление последней строки и занесение результата во временную директорию

Copy-Item -Path $Path$File2 -Destination $PathTemp$File2 # копирование во временную директорию


Get-Content $PathTemp$FileType | Add-Content $PathTemp$Merge # слияние

Get-Content $PathTemp$Merge | Sort-Object -Unique $Unic | Add-Content $Path$Fileout # 



Get-Content "C:\Users\rii\Documents\csv\temp\merge.csv" | Sort-Object | get-unique SKU | Add-Content "C:\Users\rii\Documents\csv\res1.csv" 


Get-Content "C:\Users\rii\Documents\csv\temp\merge.csv" | Sort-Object -Unique  | Add-Content "C:\Users\rii\Documents\csv\res1.csv"  # слияние
Get-Content "C:\Users\rii\Documents\csv\temp\merge.csv" -header SKU, Продукцияб Количество| Sort-Object -Unique SKU| Add-Content "C:\Users\rii\Documents\csv\res1.csv"
#Import-Csv $PathTemp$Merge -Delimiter ";" | sort-Object -Unique $Unic | Export-Csv $Path$Fileout -Delimiter ";" -NoTypeInformation -Encoding UTF8 # сортировака и удаление дубляжей

#Import-Csv "C:\Users\rii\Documents\csv\temp\merge.csv" -Delimiter ";" -header SKU, Name, count| Export-Csv "C:\Users\rii\Documents\csv\res1.csv" -Delimiter ";" -NoTypeInformation -Encoding ANSI
Import-Csv "C:\Users\rii\Documents\csv\temp\merge.csv" -Delimiter ";" | Sort-Object -Unique SKU| Export-Csv "C:\Users\rii\Documents\csv\res1.csv" -Delimiter ";" -NoTypeInformation

#Remove-Item -Path $PathTemp$FileType -Force # очищение временной папки

