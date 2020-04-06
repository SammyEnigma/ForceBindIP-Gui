Opt("TrayMenuMode",1)

#include <ButtonConstants.au3>
#include <ComboConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>

#include <Constants.au3>

#include <FileConstants.au3>
#include <MsgBoxConstants.au3>
#include <WinAPIFiles.au3>

#Region ### START Koda GUI section ### Form=C:\- App -\Autoit\ForceBindIP\0.0.0.0\GUI\ForceBindIP - Gui.kxf
$Form1_1 = GUICreate("ForceBindIP - By M.Hasan Jabbari", 626, 393, -1, -1)
$Group_appAddress = GUICtrlCreateGroup("Application Address", 16, 16, 593, 153)
$Button_runApp = GUICtrlCreateButton("Run Application", 240, 120, 123, 25)
$Input_appAddress = GUICtrlCreateInput("Application Address", 32, 72, 553, 21)
$Combo_internetSelect = GUICtrlCreateCombo("Select Internet Connection", 32, 40, 553, 25, BitOR($CBS_DROPDOWN,$CBS_AUTOHSCROLL))
$Radio_x86 = GUICtrlCreateRadio("x86", 440, 112, 113, 17)
$Radio_x64 = GUICtrlCreateRadio("x64", 440, 136, 113, 17)
GUICtrlCreateGroup("", -99, -99, 1, 1)
$Group_Quick = GUICtrlCreateGroup("Quick Access", 16, 176, 593, 169)
$Button_googleChrome = GUICtrlCreateButton("Google Chrome", 24, 200, 91, 25)
$Button_fireFox = GUICtrlCreateButton("Firefox", 192, 200, 91, 25)
$Button_internetExplorer = GUICtrlCreateButton("Internet Explorer", 352, 200, 91, 25)
$Button_spotify = GUICtrlCreateButton("Spotify", 488, 200, 91, 25)
$Button_idm = GUICtrlCreateButton("IDM", 24, 240, 91, 25)
$Button_steam = GUICtrlCreateButton("Steam", 192, 240, 91, 25)
$Button_dota = GUICtrlCreateButton("Dota 2", 352, 240, 91, 25)
$Button_downloadConfig = GUICtrlCreateButton("Download and Config ForceBindIP", 216, 304, 203, 25)
GUICtrlCreateGroup("", -99, -99, 1, 1)
$Label_copyRight = GUICtrlCreateLabel("M.Hasan Jabbari", 528, 360, 84, 17)
$Label_Internet = GUICtrlCreateLabel("Select Internet Connection", 16, 360, 130, 17)
GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###


; Get WMI
$wbemFlagReturnImmediately = 0x10
$wbemFlagForwardOnly = 0x20
$colItems = ""
$strComputer = "localhost"
$Output=""
$objWMIService = ObjGet("winmgmts:\\" & $strComputer & "\root\CIMV2")
$colItems = $objWMIService.ExecQuery("SELECT * FROM Win32_NetworkAdapter WHERE NetConnectionID != NULL", "WQL", $wbemFlagReturnImmediately + $wbemFlagForwardOnly)

; Vars
$googleChrome = "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe"
$firefox = "C:\Program Files\Mozilla Firefox\firefox.exe"
$iexplorer = "C:\Program Files\Internet Explorer\iexplore.exe"
$spotify = "C:\Users\" & @UserName & "\AppData\Roaming\Spotify\Spotify.exe"
$idm = "C:\Program Files (x86)\Internet Download Manager\IDMan.exe"
$steam = "C:\Program Files (x86)\Steam\steam.exe"
$dota2 = "C:\Program Files (x86)\Steam\steamapps\common\dota 2 beta\game\bin\win64\dota2.exe"
$system32 = "C:\windows\system32"
$sysWOW64 = "C:\windows\sysWOW64"

$sZipFile = @ScriptDir & "\ForceBindIP.zip"
$sDestFolder = @ScriptDir & "\ForceBindIP"

GetInternet()

While 1
   $nMsg = GUIGetMsg()

	Switch $nMsg

	  Case $GUI_EVENT_CLOSE
			Exit

	  Case $Button_runApp
		 If GUICtrlRead($Input_appAddress) <> "" Then
;~ 			Run("cmd /c ForceBindIP64 -i " & GUICtrlRead($Combo_internetSelect) & " " & GUICtrlRead($Input_appAddress) ,"",@SW_HIDE)
			runCMD(GUICtrlRead($Input_appAddress))
		 Else
			MsgBox(0,"Input Can Not Be Empty","Please Enter Valid Data...")
		 EndIf

	  Case $Button_googleChrome
		 runCMD($googleChrome)

	  Case $Button_fireFox
		 runCMD($firefox)

	  Case $Button_internetExplorer
		 runCMD($iexplorer)

	  Case $Button_spotify
		 runCMD($spotify)

	  Case $Button_idm
		 runCMD($idm)

	  Case $Button_steam
		 runCMD($steam)

	  Case $Button_dota
		 runCMD($dota2)

	  Case $Button_downloadConfig
		 DownloadConfig()

	  Case $Combo_internetSelect
		 $ComboString = GUICtrlRead($Combo_internetSelect)
		 $iPosition = StringInStr($ComboString, "{")
		 $iPosition = $iPosition - 1
		 $sString = StringTrimLeft($ComboString,$iPosition)
		 GUICtrlSetData($Label_Internet,$sString)

	EndSwitch
 WEnd





Func GetInternet ()

   If IsObj($colItems) then
	  For $objItem In $colItems
		 If $objItem.NetEnabled = True Then
			GUICtrlSetData($Combo_internetSelect , "(" & $objItem.NetConnectionID & ") " & $objItem.Name & " --- " & $objItem.GUID)
		 EndIf
	  Next
   Else
	  Msgbox(0,"WMI Output","No WMI Objects Found for class: " & "Win32_NetworkAdapter" )
   Endif

EndFunc


Func runCMD($address)
   If (GUICtrlRead($Radio_x86) = 1) Then
	  Run("cmd /c ForceBindIP -i " & GUICtrlRead($Label_Internet) & ' ' & $address,"" , @SW_HIDE)
   ElseIf (GUICtrlRead($Radio_x64) = 1) Then
	  Run("cmd /c ForceBindIP64 -i " & GUICtrlRead($Label_Internet) & ' ' & $address,"" , @SW_HIDE)
   Else
	  MsgBox(1,"Select One Option", "Please Select One Option")
   EndIf
EndFunc


Func DownloadConfig()
   If FileExists ( "C:\Windows\System32\BindIP.dll" ) Or FileExists("C:\Windows\sysWOW64\BindIP64.dll") Then
	  MsgBox(0,"File Exist","You Do Not Need To Use This Bottom " & @CRLF & @CRLF & "Everything Looks Great")

   ElseIf FileExists("C:\Windows\sysWOW64") Then; System64
	  ; Download
	  InetGet ( "https://r1ch.net/assets/forcebindip/ForceBindIP-1.32.zip", "ForceBindIP.zip" )

	  ; Unzip
	  UnZip($sZipFile, $sDestFolder)
	  If @error Then Exit MsgBox ($MB_SYSTEMMODAL,"","Error unzipping file : " & @error)

	  ; Copy
	  FileCopy ( @ScriptDir & "\ForceBindIP\BindIP.dll", $system32)
	  FileCopy ( @ScriptDir & "\ForceBindIP\BindIP64.dll", $system32)
	  FileCopy ( @ScriptDir & "\ForceBindIP\ForceBindIP.exe", $system32)
	  FileCopy ( @ScriptDir & "\ForceBindIP\ForceBindIP64.exe", $system32)
	  FileCopy ( @ScriptDir & "\ForceBindIP\BindIP.dll", $sysWOW64)
	  FileCopy ( @ScriptDir & "\ForceBindIP\BindIP64.dll", $sysWOW64)
	  FileCopy ( @ScriptDir & "\ForceBindIP\ForceBindIP.exe", $sysWOW64)
	  FileCopy ( @ScriptDir & "\ForceBindIP\ForceBindIP64.exe", $sysWOW64)

   Else ; System32
	  ; Download
	  InetGet ( "https://r1ch.net/assets/forcebindip/ForceBindIP-1.32.zip", "ForceBindIP.zip" )

	  ; Unzip
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