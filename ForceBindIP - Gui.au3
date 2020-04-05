#include <ButtonConstants.au3>
#include <ComboConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
#Region ### START Koda GUI section ### Form=C:\- App -\Autoit\ForceBindIP\LAN\LAN.kxf
$Form1_1 = GUICreate("ForceBindIP - By M.Hasan Jabbari", 626, 309, 188, 122)
$Group_appAddress = GUICtrlCreateGroup("Application Address", 16, 16, 593, 137)
$Button_runApp = GUICtrlCreateButton("Run Application", 240, 112, 123, 25)
$Input_appAddress = GUICtrlCreateInput("Application Address", 32, 72, 553, 21)
$Combo_internetSelect = GUICtrlCreateCombo("Select Internet Connection", 32, 40, 553, 25, BitOR($CBS_DROPDOWN,$CBS_AUTOHSCROLL))
GUICtrlCreateGroup("", -99, -99, 1, 1)
$Group_Quick = GUICtrlCreateGroup("Quick Access", 16, 176, 593, 105)
$Button_googleChrome = GUICtrlCreateButton("Google Chrome", 24, 200, 91, 25)
$Button_fireFox = GUICtrlCreateButton("Firefox", 192, 200, 91, 25)
$Button_internetExplorer = GUICtrlCreateButton("Internet Explorer", 352, 200, 91, 25)
$Button_spotify = GUICtrlCreateButton("Spotify", 488, 200, 91, 25)
$Button_idm = GUICtrlCreateButton("IDM", 24, 240, 91, 25)
$Button_steam = GUICtrlCreateButton("Steam", 192, 240, 91, 25)
$Button_dota = GUICtrlCreateButton("Dota 2", 352, 240, 91, 25)
GUICtrlCreateGroup("", -99, -99, 1, 1)
$Label_copyRight = GUICtrlCreateLabel("M.Hasan Jabbari", 512, 288, 84, 17)
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

GetInternet()


While 1
   $nMsg = GUIGetMsg()

	Switch $nMsg

	  Case $GUI_EVENT_CLOSE
			Exit

	  Case $Button_runApp
		 If GUICtrlRead(GUICtrlRead($Input_appAddress) <> "" Then
			Run("cmd /c ForceBindIP64 -i " & GUICtrlRead($Combo_internetSelect) & " " & GUICtrlRead($Input_appAddress) ,"",@SW_HIDE)
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

	EndSwitch
 WEnd


Func GetInternet ()

   If IsObj($colItems) then
	  For $objItem In $colItems
		 If $objItem.NetEnabled = True Then
			GUICtrlSetData($Combo_internetSelect , $objItem.GUID)
			MsgBox(0,"Founded", $objItem.NetConnectionID & " ( " & $objItem.ProductName & " )")
		 EndIf
	  Next
   Else
	  Msgbox(0,"WMI Output","No WMI Objects Found for class: " & "Win32_NetworkAdapter" )
   Endif

EndFunc


Func runCMD($address)
   Run("cmd /c ForceBindIP64 -i " & GUICtrlRead($Combo_internetSelect) & ' ' & $address,"" , @SW_HIDE)
EndFunc