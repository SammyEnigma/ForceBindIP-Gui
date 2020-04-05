#RequireAdmin

#include <WindowsConstants.au3>
#include <Constants.au3>
#include <FileConstants.au3>
#include <MsgBoxConstants.au3>
#include <WinAPIFiles.au3>

$system32 = "C:\Windows\System32"
$sysWOW64 = "C:\windows\sysWOW64"

DownloadConfig()


Func DownloadConfig()
   If FileExists ("C:\windows\system32\BindIP.dll") Or FileExists("C:\windows\sysWOW64\BindIP64.dll") Then
	  MsgBox(0,"File Exist","You Do Not Need To Use This Bottom " & @CRLF & @CRLF & "Everything Looks Great")

   ElseIf FileExists("C:\Windows\sysWOW64") Then; System64
	  ; Download
	  InetGet ( "https://r1ch.net/assets/forcebindip/ForceBindIP-1.32.zip", "ForceBindIP.zip" )

	  ; Unzip
	  Const $sZipFile = @ScriptDir & "\ForceBindIP.zip"
	  Const $sDestFolder = @ScriptDir & "\ForceBindIP"
	  UnZip($sZipFile, $sDestFolder)
	  If @error Then Exit MsgBox ($MB_SYSTEMMODAL,"","Error unzipping file : " & @error)

	  ; Copy
	  FileCopy ( @ScriptDir & "\ForceBindIP\BindIP.dll", $sysWOW64)
	  FileCopy ( @ScriptDir & "\ForceBindIP\BindIP64.dll", $sysWOW64)
	  FileCopy ( @ScriptDir & "\ForceBindIP\ForceBindIP.exe", $sysWOW64)
	  FileCopy ( @ScriptDir & "\ForceBindIP\ForceBindIP64.exe", $sysWOW64)
	  FileCopy ( @ScriptDir & "\ForceBindIP\BindIP.dll", $system32)
	  FileCopy ( @ScriptDir & "\ForceBindIP\BindIP64.dll", $system32)
	  FileCopy ( @ScriptDir & "\ForceBindIP\ForceBindIP.exe", $system32)
	  FileCopy ( @ScriptDir & "\ForceBindIP\ForceBindIP64.exe", $system32)

   Else ; System32
	  ; Download
	  InetGet ( "https://r1ch.net/assets/forcebindip/ForceBindIP-1.32.zip", "ForceBindIP.zip" )

	  ; Unzip
	  Const $sZipFile = @ScriptDir & "\ForceBindIP.zip"
	  Const $sDestFolder = @ScriptDir & "\ForceBindIP"
	  UnZip($sZipFile, $sDestFolder)
	  If @error Then Exit MsgBox ($MB_SYSTEMMODAL,"","Error unzipping file : " & @error)

	  ; Copy
	  FileCopy ( @ScriptDir & "\ForceBindIP\BindIP.dll", $system32)
	  FileCopy ( @ScriptDir & "\ForceBindIP\BindIP64.dll", $system32)
	  FileCopy ( @ScriptDir & "\ForceBindIP\ForceBindIP.exe", $system32)
	  FileCopy ( @ScriptDir & "\ForceBindIP\ForceBindIP64.exe", $system32)

   EndIf
EndFunc

Func UnZip($sZipFile, $sDestFolder)
  If Not FileExists($sZipFile) Then Return SetError (1) ; source file does not exists
  If Not FileExists($sDestFolder) Then
    If Not DirCreate($sDestFolder) Then Return SetError (2) ; unable to create destination
  Else
    If Not StringInStr(FileGetAttrib($sDestFolder), "D") Then Return SetError (3) ; destination not folder
  EndIf
  Local $oShell = ObjCreate("shell.application")
  Local $oZip = $oShell.NameSpace($sZipFile)
  Local $iZipFileCount = $oZip.items.Count
  If Not $iZipFileCount Then Return SetError (4) ; zip file empty
  For $oFile In $oZip.items
    $oShell.NameSpace($sDestFolder).copyhere($ofile)
  Next
EndFunc   ;==>UnZip