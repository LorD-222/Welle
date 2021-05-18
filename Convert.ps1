$path = "F:\AD-IT\Project\Welle\"
$files = Get-ChildItem -Path $path -Filter Ost_Sklad.csv -Recurse

ForEach ($file in $files) {
    Write-Host "Remove file: " $path$file
    Remove-Item $path$file
}

$excel = new-object -ComObject "Excel.Application"
$excel.DisplayAlerts=$True
$excel.Visible =$false
Get-ChildItem $path -Filter *.xls |
Foreach-Object{
  'processing '+$_.FullName
  $wb = $excel.Workbooks.Open($_.FullName)
  $dst_file=$path + $_.BaseName + ".csv"
  $wb.SaveAs($dst_file, 6)# 6 -> csv
  'saved '+$dst_file
  $wb.Close($True)
  Start-Sleep -Seconds 2
 }
$excel.Quit()
[void][System.Runtime.Interopservices.Marshal]::ReleaseComObject($excel)