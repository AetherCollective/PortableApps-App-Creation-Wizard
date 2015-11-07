#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_UseUpx=y
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
FileInstall("iconsext.exe", "iconsext.exe", "0")
#include <ButtonConstants.au3>
#include <ComboConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
Global $path = @ScriptDir & "\PortableApps\"
Global $PortableAppsLauncherCreatorPath = $path & "PortableApps.comLauncher\PortableApps.comLauncherGenerator.exe"
Global Const $wintitle = "PortableApps App Creation Wizard"
CheckGenerator()
Func CheckGenerator()
	If Not FileExists($PortableAppsLauncherCreatorPath) Then
		Local $warningReply = MsgBox(2, $wintitle, "Warning: PortableApps.comLauncherGenerator.exe not found. You will not be able to build the launcher until you install PortableApps Launcher.")
		If @error Then Exit
		Select
			Case $warningReply = 3
				Exit
			Case $warningReply = 4
				CheckGenerator()
			Case $warningReply = 5
		EndSelect

	EndIf
EndFunc   ;==>CheckGenerator
Do
	Global $appname = InputBox($wintitle, "What is the app name?")
	If @error Then Exit
Until $appname
CreateApp()
Func CreateApp()
	;Step 1. Create Directories.
	DirCreate($path)
	DirCreate($path & $appname)
	DirCreate($path & $appname & "\App")
	DirCreate($path & $appname & "\App\AppInfo")
	DirCreate($path & $appname & "\App\AppInfo\Launcher")
	DirCreate($path & $appname & "\App\" & $appname)
	DirCreate($path & $appname & "\App\DefaultData")
	DirCreate($path & $appname & "\Data")
	DirCreate($path & $appname & "\Other")
	DirCreate($path & $appname & "\Other\Help")
	DirCreate($path & $appname & "\Other\Help\Images")
	DirCreate($path & $appname & "\Other\Source\")
	MsgBox(0, $wintitle, "Project Folders Created. Please move the PortableApp into the Project Folder at " & @CRLF & $path & $appname & "\" & $appname & @CRLF & @CRLF & "An icon will be extracted automatically if the ProgramExecutable exists upon submission. Otherwise, you will also want to make/extract the icon at this time. ")
	;Step 2. Collect appinfo from user.
	#Region ### START Koda GUI section ### Form=D:\OneDrive\Documents\PortableApp_Creator.kxf
	$PortableApp_Creator = GUICreate($wintitle, 505, 675, -1, -1)
	$Group1 = GUICtrlCreateGroup("Details", 0, 0, 505, 161)
	$AppID = GUICtrlCreateLabel("AppID", 8, 16, 34, 17)
	If Not StringInStr($appname, "portable") Then
		$appnameportable = $appname & "Portable"
	Else
		$appnameportable = $appname
	EndIf
	$AppIDInput = GUICtrlCreateInput($appnameportable, 48, 16, 65, 21)
	$Publisher = GUICtrlCreateLabel("Publisher", 120, 16, 47, 17)
	$PublisherInput = GUICtrlCreateInput("", 168, 16, 161, 21)
	$Trademarks = GUICtrlCreateLabel("Trademarks", 336, 16, 60, 17)
	$TrademarksInput = GUICtrlCreateInput("", 400, 16, 97, 21)
	$Category = GUICtrlCreateLabel("Category", 8, 40, 46, 17)
	$CategoryCombo = GUICtrlCreateCombo("Choose Category...", 56, 40, 177, 25, BitOR($CBS_DROPDOWN, $CBS_AUTOHSCROLL))
	GUICtrlSetData(-1, "Accessibility|Development|Education|Games|Graphics & Pictures|Internet|Music & Video|Office|Security|Utilities")
	$Language = GUICtrlCreateLabel("Language", 240, 40, 52, 17)
	$LanguageCombo = GUICtrlCreateCombo("Multilingual", 296, 40, 201, 25, BitOR($CBS_DROPDOWN, $CBS_AUTOHSCROLL))
	GUICtrlSetData(-1, "Afrikaans|Albanian|Arabic|Armenian|Basque|Belarusian|Bosnian|Breton|Bulgarian|Catalan|Cibemba|Croatian|Czech|Danish|Dutch|Efik|English|EnglishGB|Esperanto|Estonian|Farsi|Finnish|French|Galician|Georgian|German|Greek|Hebrew|Hungarian|Icelandic|Igbo|Indonesian|Irish|Italian|Japanese|Khmer|Korean|Kurdish|Latvian|Lithuanian|Luxembourgish|Macedonian|Malagasy|Malay|Mongolian|Norwegian|NorwegianNynorsk|Pashto|Polish|Portuguese|PortugueseBR|Romanian|Russian|Serbian|SerbianLatin|SimpChinese|Slovak|Slovenian|Spanish|SpanishInternational|Swahili|Swedish|Thai|TradChinese|Turkish|Ukrainian|Uzbek|Valencian|Vietnamese|Welsh|Yoruba")
	$Description = GUICtrlCreateLabel("Description", 8, 64, 54, 17)
	$DescriptionInput = GUICtrlCreateInput("", 64, 64, 433, 21)
	GUICtrlSetLimit(-1, 512)
	GUICtrlSetTip(-1, "Max Length is 512 Characters")
	$Homepage = GUICtrlCreateLabel("Homepage", 8, 88, 56, 17)
	$HomepageInput = GUICtrlCreateInput("https://www.google.com/#newwindow=1&q=" & String($appname), 64, 88, 433, 21)
	GUICtrlSetTip(-1, "Default is Google Search")
	$Donate = GUICtrlCreateLabel("Donate", 8, 112, 39, 17)
	$DonateInput = GUICtrlCreateInput("", 48, 112, 449, 21)
	$InstallType = GUICtrlCreateLabel("InstallType", 8, 136, 55, 17)
	$InstallTypeInput = GUICtrlCreateInput("", 64, 136, 433, 21)
	GUICtrlSetTip(-1, "Leave blank if unknown")
	$Group2 = GUICtrlCreateGroup("License", 0, 160, 505, 41)
	$Sharable = GUICtrlCreateCheckbox("Sharable", 8, 176, 65, 17)
	GUICtrlSetState(-1, $GUI_CHECKED)
	$OpenSource = GUICtrlCreateCheckbox("OpenSource", 80, 176, 81, 17)
	$Freeware = GUICtrlCreateCheckbox("Freeware", 168, 176, 65, 17)
	GUICtrlSetState(-1, $GUI_CHECKED)
	$CommercialUse = GUICtrlCreateCheckbox("Commercial Use", 240, 176, 97, 17)
	$EulaVersion = GUICtrlCreateLabel("EULAVersion", 344, 176, 67, 17)
	$EulaVersionInput = GUICtrlCreateInput("1", 416, 174, 81, 21)
	$Group3 = GUICtrlCreateGroup("Version", 0, 200, 505, 41)
	$PackageVersionInput = GUICtrlCreateInput("1.0.0.0", 92, 214, 161, 21)
	$DisplayVersionInput = GUICtrlCreateInput("1.0", 336, 214, 161, 21)
	$PackageVersion = GUICtrlCreateLabel("PackageVersion", 8, 216, 82, 17)
	$DisplayVersion = GUICtrlCreateLabel("DisplayVersion", 256, 216, 73, 17)
	$Group4 = GUICtrlCreateGroup("Dependencies", 0, 240, 505, 41)
	$UsesJava = GUICtrlCreateCheckbox("UsesJava", 8, 256, 73, 17)
	$UsesGhostScript = GUICtrlCreateLabel("UsesGhostScript", 80, 256, 83, 17)
	$UsesGhostScriptCombo = GUICtrlCreateCombo("No", 168, 254, 81, 25, BitOR($CBS_DROPDOWN, $CBS_AUTOHSCROLL))
	GUICtrlSetData(-1, "Optional|Yes")
	$DotNetVersionInput = GUICtrlCreateInput("", 336, 254, 161, 21)
	$DotNetVersion = GUICtrlCreateLabel("UsesDotNetVersion", 256, 256, 73, 17)
	$Group5 = GUICtrlCreateGroup("Control", 0, 280, 505, 89)
	$ControlInput = GUICtrlCreateEdit("", 0, 296, 505, 73)
	GUICtrlSetData(-1, StringFormat("Icons=1\r\nStart=" & String($appname) & "Portable.exe\r\nExtractIcon=App\\" & String($appname) & "\\" & String($appname) & ".exe"))
	$Group6 = GUICtrlCreateGroup("Associations", 0, 368, 505, 177)
	$AssociationsInput = GUICtrlCreateEdit("", 0, 384, 505, 161)
	GUICtrlSetData(-1, StringFormat("FileTypes=\r\nFileTypeCommandLine=\r\nFileTypeCommandLine-extension=\r\nProtocols=\r\nProtocolCommandLine=\r\nProtocolCommandLine-protocol=\r\nSendTo=\r\nSendToCommandLine=\r\nShell=\r\nShellCommand="))
	$Group7 = GUICtrlCreateGroup("FileTypeIcons", 0, 544, 505, 105)
	$FileTypeIconsInput = GUICtrlCreateEdit("", 0, 560, 505, 89)
	$Submit = GUICtrlCreateButton("Submit", 0, 650, 505, 25)
	GUISetState(@SW_SHOW)
	#EndRegion ### END Koda GUI section ###
	While 1
		$nMsg = GUIGetMsg()
		Switch $nMsg
			Case $GUI_EVENT_CLOSE
				Local $iexit = MsgBox(4, $wintitle, "Are you sure?")
				If @error Then Exit
				If $iexit = 6 Then Exit
			Case $Submit
				GUISetState(@SW_HIDE)
				ExitLoop
		EndSwitch
	WEnd
	;Step 3. Create appinfo.ini.
	Local $appinfopath = $path & $appname & "\App\AppInfo\appinfo.ini"
	IniWrite($appinfopath, "Format", "Type", "PortableApps.comFormat")
	IniWrite($appinfopath, "Format", "Version", "3.0" & @CRLF)
	IniWrite($appinfopath, "Details", "Name", $appnameportable)
	IniWrite($appinfopath, "Details", "AppID", GUICtrlRead($AppIDInput))
	IniWrite($appinfopath, "Details", "Publisher", GUICtrlRead($PublisherInput))
	IniWrite($appinfopath, "Details", "Homepage", GUICtrlRead($HomepageInput))
	IniWrite($appinfopath, "Details", "Donate", GUICtrlRead($DonateInput))
	IniWrite($appinfopath, "Details", "Category", GUICtrlRead($CategoryCombo))
	IniWrite($appinfopath, "Details", "Description", GUICtrlRead($DescriptionInput))
	IniWrite($appinfopath, "Details", "Language", GUICtrlRead($LanguageCombo))
	IniWrite($appinfopath, "Details", "Trademarks", GUICtrlRead($TrademarksInput))
	IniWrite($appinfopath, "Details", "InstallType", GUICtrlRead($InstallTypeInput) & @CRLF)
	If GUICtrlRead($Sharable) = 1 Then
		$Sharable = "True"
	Else
		$Sharable = "False"
	EndIf
	IniWrite($appinfopath, "License", "Shareable", $Sharable)
	If GUICtrlRead($OpenSource) = 1 Then
		$OpenSource = "True"
	Else
		$OpenSource = "False"
	EndIf
	IniWrite($appinfopath, "License", "OpenSource", $OpenSource)
	If GUICtrlRead($Freeware) = 1 Then
		$Freeware = "True"
	Else
		$Freeware = "False"
	EndIf
	IniWrite($appinfopath, "License", "Freeware", $Freeware)
	If GUICtrlRead($CommercialUse) = 1 Then
		$CommercialUse = "True"
	Else
		$CommercialUse = "False"
	EndIf
	IniWrite($appinfopath, "License", "CommercialUse", $CommercialUse)
	IniWrite($appinfopath, "License", "EULAVersion", GUICtrlRead($EulaVersionInput) & @CRLF)
	IniWrite($appinfopath, "Dependencies", "UsesGhostscript", GUICtrlRead($UsesGhostScriptCombo))
	If GUICtrlRead($UsesJava) = 1 Then
		$UsesJava = "Yes"
		$ActivateJava = True
	Else
		$ActivateJava = False
		$UsesJava = "No"
	EndIf
	IniWrite($appinfopath, "Dependencies", "UsesJava", $UsesJava)
	IniWrite($appinfopath, "Dependencies", "UsesDotNetVersion", GUICtrlRead($DotNetVersionInput) & @CRLF)
	IniWriteSection($appinfopath, "Control", GUICtrlRead($ControlInput) & @CRLF & @CRLF)
	IniWriteSection($appinfopath, "Associations", GUICtrlRead($AssociationsInput) & @CRLF & @CRLF)
	IniWriteSection($appinfopath, "FileTypeIcons", GUICtrlRead($FileTypeIconsInput) & @CRLF)
	If Not FileExists($appinfopath) Then
		MsgBox(0, $wintitle, "Unable to create or modify appinfo.ini. Please rerun as admin.")
		Exit
	EndIf
	MsgBox(0, $wintitle, "Appinfo.ini created.")
	;Step 4. Collect launcher info from user.
	#Region ### START Koda GUI section ### Form=D:\OneDrive\Documents\PortableApp_Creator Launcher.kxf
	$_1 = GUICreate($wintitle, 505, 525, -1, -1)
	$Manditory = GUICtrlCreateGroup("Manditory", 0, 0, 505, 41)
	$ProgramExecutable = GUICtrlCreateLabel("ProgramExecutable", 8, 16, 96, 17)
	$ProgramExecutableInput = GUICtrlCreateInput($appname & "\" & $appname & ".exe", 104, 14, 393, 21)
	$LaunchOptions = GUICtrlCreateGroup("Launch Options", 0, 40, 505, 145)
	$ProgramExecutable64 = GUICtrlCreateLabel("ProgramExecutable64", 8, 56, 108, 17)
	$ProgramExecutable64Input = GUICtrlCreateInput("", 120, 56, 377, 21)
	GUICtrlSetTip(-1, "AppName\AppName64.exe")
	$ProgramExecutableWhenParameters = GUICtrlCreateLabel("ProgramExecutableWhenParameters", 8, 84, 178, 17)
	$ProgramExecutableWhenParametersInput = GUICtrlCreateInput("", 192, 84, 305, 21)
	$ProgramExecutableWhenParameters64 = GUICtrlCreateLabel("ProgramExecutableWhenParameters64", 8, 108, 190, 17)
	$ProgramExecutableWhenParameters64Input = GUICtrlCreateInput("", 200, 108, 297, 21)
	$CommandLineArguments = GUICtrlCreateLabel("CommandLineArguments", 8, 132, 121, 17)
	$CommandLineArgumentsInput = GUICtrlCreateInput("", 136, 132, 361, 21)
	$WorkingDirectory = GUICtrlCreateLabel("WorkingDirectory", 8, 160, 86, 17)
	$WorkingDirectoryInput = GUICtrlCreateInput("", 104, 160, 393, 21)
	$Group1 = GUICtrlCreateGroup("Group1", 0, 184, 481, 1)
	$RunAsAdmin = GUICtrlCreateGroup("RunAsAdmin", 0, 184, 505, 49)
	$RunAsAdminCombo = GUICtrlCreateCombo("None", 8, 200, 489, 25, BitOR($CBS_DROPDOWN, $CBS_AUTOHSCROLL))
	GUICtrlSetData(-1, "try|force|compile-force")
	$FileMove = GUICtrlCreateGroup("FileMove", 0, 232, 505, 89)
	$FileMoveInput = GUICtrlCreateEdit("", 0, 248, 505, 73)
	GUICtrlSetData(-1, "")
	$DirectoryMove = GUICtrlCreateGroup("DirectoryMove", 0, 322, 505, 81)
	$DirectoryMoveInput = GUICtrlCreateEdit("", 0, 338, 505, 73)
	GUICtrlSetData(-1, "")
	$RegistryMove = GUICtrlCreateGroup("RegistryMove", 0, 412, 505, 81)
	$RegistryMoveInput = GUICtrlCreateEdit("", 0, 428, 505, 73)
	GUICtrlSetData(-1, "")
	$Submit = GUICtrlCreateButton("Submit", 0,502, 505, 22)
	GUISetState(@SW_SHOW)
	#EndRegion ### END Koda GUI section ###
	While 1
		$nMsg = GUIGetMsg()
		Switch $nMsg
			Case $GUI_EVENT_CLOSE
				Exit
			Case $Submit
				GUISetState(@SW_HIDE)
				ExitLoop
		EndSwitch
	WEnd
	;Step 5. Create launcher.ini
	Local $ininametemp = StringSplit(GUICtrlRead($ProgramExecutableInput), "\")
	Local $ininame = $ininametemp[$ininametemp[0]]
	$ininame = StringReplace($ininame, ".exe", "")
	Local $launcherinfopath = $path & $appname & "\App\AppInfo\Launcher\" & $ininame & "Portable.ini"
	IniWrite($launcherinfopath, "Launch", "Name", $appnameportable)
	IniWrite($launcherinfopath, "Launch", "ProgramExecutable", GUICtrlRead($ProgramExecutableInput))
	IniWrite($launcherinfopath, "Launch", "ProgramExecutable64", GUICtrlRead($ProgramExecutable64Input))
	IniWrite($launcherinfopath, "Launch", "ProgramExecutableWhenParameters", GUICtrlRead($ProgramExecutableWhenParametersInput))
	IniWrite($launcherinfopath, "Launch", "ProgramExecutableWhenParameters64", GUICtrlRead($ProgramExecutableWhenParameters64Input))
	IniWrite($launcherinfopath, "Launch", "CommandLineArguments", GUICtrlRead($CommandLineArgumentsInput))
	IniWrite($launcherinfopath, "Launch", "WorkingDirectory", GUICtrlRead($WorkingDirectoryInput) & @CRLF)
	If GUICtrlRead($RegistryMoveInput) Then IniWrite($launcherinfopath, "Activate", "Registry", "True")
	If $ActivateJava = True Then IniWrite($launcherinfopath, "Activate", "Java", "Require")
	If GUICtrlRead($FileMoveInput) Then IniWrite($launcherinfopath, "Activate", "XML", "True" & @CRLF)
	IniWriteSection($launcherinfopath, "FilesMove", GUICtrlRead($FileMoveInput) & @CRLF & @CRLF)
	IniWriteSection($launcherinfopath, "DirectoriesMove", GUICtrlRead($DirectoryMoveInput) & @CRLF & @CRLF)
	IniWriteSection($launcherinfopath, "RegistryKeys", GUICtrlRead($RegistryMoveInput) & @CRLF & @CRLF)
	If Not FileExists($launcherinfopath) Then
		MsgBox(0, $wintitle, "Unable to create or modify launcher.ini. Please rerun as admin.")
		Exit
	EndIf
	MsgBox(0, $wintitle, "Launcher.ini created. Press Ok to Extract the Icons.")
	If @error Then Exit
	ShellExecuteWait("iconsext.exe", "/save " & $path & $appname & "\App\" & GUICtrlRead($ProgramExecutableInput) & " " & $path & $appname & "\App\AppInfo" & " -icons -asico")
	Do
		Sleep(500)
	Until FileExists($path & $appname & "\App\AppInfo\" & $appname & "_101.ico")
	FileMove($path & $appname & "\App\AppInfo\" & $appname & "_101.ico", $path & $appname & "\App\AppInfo\appicon.ico", 1)
	Do
		Sleep(500)
	Until FileExists($path & $appname & "\App\AppInfo\appicon.ico")
	ShellExecuteWait($PortableAppsLauncherCreatorPath, $path & $appname)
	Local $runpath = IniRead($appinfopath, "Control", "Start", "")
	If FileExists($path & $appname & "\" & $runpath) Then MsgBox(0, $wintitle, "Success.")
EndFunc   ;==>CreateApp



