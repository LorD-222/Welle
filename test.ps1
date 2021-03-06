# Сохранение в UTF8 и удаление последней строки
#Get-Content Ost_Sklad.csv | ForEach-Object { $prev = $null } {if ($null -ne $prev) { $prev } $prev = $_} | #Out-File Ost_Sklad1.csv -Encoding UTF8

# Добавление последнего столбца
#Import-Csv Ost_Sklad1.csv -Delimiter ";" -Encoding default | 
#Select-Object * ,Signal | Export-Csv Ost_Sklad2.csv -Delimiter ";" -NoTypeInformation -Encoding UTF8

# Добавление шапки
#Import-Csv Signal__Meble.csv -Delimiter ";" -Encoding default -Header "SKU", "Name" , "Kolvo" | 
#Select-Object "SKU", "Name" , "Kolvo" | Export-Csv Signal__Meble1.csv -Delimiter ";" -NoTypeInformation -Encoding UTF8

$obj2 = 'ALBIVCSZ'
$result1=Import-Csv -Delimiter ";" -Path Signal__Meble1.csv -Encoding default #| Select-Object SKU 
#$result2=Import-Csv -Delimiter ";" -Path Signal__Meble1.csv -Encoding default
foreach ($obj1 in $result1)
{
   #$obj1
   if ($obj1.SKU -eq $obj2)
   {
      Get-Content -Path Ost_Sklad2.csv | Where-Object { $_ -notmatch $obj2.SKU} | Set-Content Ost_Sklad3.csv
      $obj1.Kolvo
   }
   
}
<#
$result2=Import-Csv -Delimiter ";" -Path $PathTemp$List -Encoding default 
foreach ($obj2 in $result2)
{
    Get-Content -Path $PathTemp$File2 | Where-Object { $_ -notmatch $obj2.SKU} | Set-Content $PathTemp$ListWrite
    Get-Content -Path $PathTemp$ListWrite | Set-Content $PathTemp$File2
}
 
#>
#@{Name="Количество1";Expression={'setvalue'}} 