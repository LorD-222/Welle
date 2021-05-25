command = "powershell.exe -executionpolicy RemoteSigned -WindowStyle Hidden -file F:\AD-IT\Project\Welle\Convert.ps1"
Set objShell = CreateObject("Wscript.Shell")
objShell.Run command,0,false