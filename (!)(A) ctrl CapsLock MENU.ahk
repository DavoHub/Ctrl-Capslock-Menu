/* (!)(A) ctrl capslock MENU.ahk */


;\/\/\/\/\/\/
;CTRL+CAPSLOCK to activate the menu
;
;CTRL+SHIFT+CAPSLOCK to send Ctrl A before activating the menu, to select all text first.
;/\/\/\/\/\/\/\


/*

===SETTINGS===

Dark mode on by default:
  - Ctrl F this: MenuDark(Dark:=4)
  - Change the 4 to a 2
  - (The other numbers dont do anything different)

*/




/*
README:

This is my first time making a script like this. I dont want to admit how much time I put into this, but lets just say it was a lot.
Most of the code here is copy and pasted from other sources, I mainly just fit everyting together. 
I wasnt the one who made the lego bricks, but I was the one who jammed them all together, even when they didnt really feel like they would fit.
...which is why some things might seem a little scattered and unorginized - (I am not a coder)

=
I was inspired to make this after using u/S3rLoG's capslock menu. It was really good. 
But his first script had this AWESOME loading bar GUI but he ended up removing it in later versions. ██████████████]99% 
I understand why he removed it (it was useless), but the loading bar gui had so much personality, idk why but I really missed it when it was removed. 
So that is why Ive decided to keep it alive through an easter egg in the menu.........
=

BTW if youre into this kind of thing, definitely check out u/S3rLoG's current script. Its jampacked with a lot of cool features!   ->     (https://www.reddit.com/r/AutoHotkey/comments/m0ijbo/capslock_menu/)
However, my goal with this was to make a more precise menu, only including things that I think are necessary/close to the necessary side of the spectrum. 


Feel free to move around the options or add your own options, its actually extremely simple..........




=================================(Read below for instructions on how to add your own buttons to this script)=================================

__WARNING: (Adding your own options)__
IF YOU WANT TO ADD YOUR OWN, TempText is really hard to understand, but you DONT have to use TempText. (I wouldnt recommend using it either)
You can simply have it send ^c,   and then put the changed text in the clipboard,     and send ^v                                                (optional: save the clipboard before, then set the clipboard back to what it previously was after)
██ Just make sure to put 'Exit' at the end of any new options you add (if you dont use TempText) so it wont paste the TempText afterwards             (put Exit, not ExitApp, as that quits the whole script)





__EXAMPLE: (Adding your own options)__

THIS:

    Case "&UPPERCASE":
      StringUpper, TempText, TempText


CAN ALSO BE WRITTEN AS:


    Case "&UPPERCASE":
      ClipSaved := ClipboardAll                    ;save whats currently copied

      Send, ^c		
      stringUpper, clipboard, clipboard   ;makes clipboard uppercase somehow (use google for this part)
      sleep 100
      Send ^v				  ;paste output

      clipboard := ClipSaved  		  ;set clipboard back to what it was originally

      Exit				  ;Exit so it doesnt continue, and go to the function that pastes TempText
      return




Both of these options are interchangable


Ctrl F this: THE REAL STUFF
This is where all the cases are.
*/
















;;;;;;; DARK MODE ;;;;;;; Change the values below to change the color of the menu.


DarkMode := false ; set initial mode to light



MenuDark()

; 0=Default  1=AllowDark  2=ForceDark  3=ForceLight  4=Max

MenuDark(Dark:=4) {      ;<=--------------------------------------------------------------<=PERMINANTLY CHANGE TO DARK MODE (make it the default)
    ;https://stackoverflow.com/a/58547831/894589
    static uxtheme := DllCall("GetModuleHandle", "str", "uxtheme", "ptr")
    static SetPreferredAppMode := DllCall("GetProcAddress", "ptr", uxtheme, "ptr", 135, "ptr")
    static FlushMenuThemes := DllCall("GetProcAddress", "ptr", uxtheme, "ptr", 136, "ptr")

    DllCall(SetPreferredAppMode, "int", Dark) ; 0=Default  1=AllowDark  2=ForceDark  3=ForceLight  4=Max
    DllCall(FlushMenuThemes)
}






 
#NoEnv
SendMode Input 
SetWorkingDir %A_ScriptDir% 
#SingleInstance Force
SetTitleMatchMode 2
SetBatchLines -1  ; Run the script at maximum speed






 
GroupAdd All

Menu Case, Add, CAPSLOCK MENU, CCase
Menu, Case, Default, CAPSLOCK MENU        ;makes bold
Menu Case, Add	 
Menu Case, Add, UPPERCASE        &1, CCase         ; '&' symbol makes pressing 1 activate this option
Menu Case, Add, lowercase            &2, CCase 
Menu Case, Add, Title Case             &3, CCase 
Menu Case, Add, Sentence case     &4, CCase 
Menu Case, Add				
Menu Case, Add, ″...″   &Q, CCase 
Menu Case, Add, '...'    &W, CCase 
Menu Case, Add, (...)    &E, CCase 
Menu Case, Add

;
	
Menu More, Add, `{...}    &A, CCase
Menu More, Add, `*...*    &S, CCase
Menu More, Add	
Menu More, Add, &Date - 06/07/04, CCase
Menu More, Add
Menu More, Add, iNVERT cASE, CCase 
Menu More, Add, SpOnGeBoB cAsE, CCase 
Menu More, Add, S p r e a d T e x t, CCase
Menu More, Add, raNDoM cASE, CCase 
Menu More, Add, Reverse, CCase 
Menu More, Add
Menu More, Add
Menu, More, Add, Dark Mode | Light Mode, CCase


Menu Case, Add, &A - More Options, :More


;








^CapsLock::    ;<=---------------------------------------MAIN SHORTCUT HERE (ctrl capslock)
   GetText(TempText)
   Menu Case, Show  ;<=----------------------------------Show capslock menu
Return


 

^+capslock::
	sleep 100
	send ^a          ;<=-------send ^a,
	sleep 200
	GetText(TempText)
	Menu Case, Show  ;<=-------Then show capslock menu
return







/*
If (fCtrl2) {
	sleep 100
	send ^a
	sleep 300
	}
*/


;;;If ERRORLEVEL {   ;<=---IF NO TEXT IS SELECTED, 
;;;If NOT ERRORLEVEL  ;IF TEXT IS SELECTED, 








;btw TempText is just whats been selected/copied
;Exit 
;Exit to exit 




CopyClipboard()
{
    global ClipSaved := ""
    ClipSaved := ClipboardAll  ; save original clipboard contents
    Clipboard := ""  ; start off empty to allow ClipWait to detect when the text has arrived
    Send {Ctrl down}c{Ctrl up}
    Sleep 150
    ClipWait, 1.5, 1
    if ErrorLevel
    {
        MsgBox, 262208, AutoHotkey, Copy to clipboard failed.
        Clipboard := ClipSaved  ; restore the original clipboard contents
        ClipSaved := ""  ; clear the variable
        return
    }
}



CopyClipboardCLM()
{
    global ClipSaved
    WinGet, id, ID, A
    WinGetClass, class, ahk_id %id%
    if (class ~= "(Cabinet|Explore)WClass|Progman")
        Send {F2}
    Sleep 100
    CopyClipboard()
    if (ClipSaved != "")
        Clipboard := Clipboard
    else
        Exit
}

PasteClipboardCLM()
{
    global ClipSaved
    WinGet, id, ID, A
    WinGetClass, class, ahk_id %id%
    if (class ~= "(Cabinet|Explore)WClass|Progman")
        Send {F2}
    Send ^v
    Sleep 100
    Clipboard := ClipSaved
    ClipSaved := ""
    Exit
}






;;;;;;;;;;;;;;;;;; THE STUFF ;;;;;;;;;;;;;;;;;;;
 
CCase:
  Switch A_ThisMenuItem {



    Case "CAPSLOCK MENU":

	sleep 650

;!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
;!! \/ WHOLE OTHER SCRIPT here \/ !!
;!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!


; Declare variables
SetTimer,TOOLTIP,1500
SetTimer,TOOLTIP,Off
TimeCapsToggle = 5
TimeOut = 30
global stringGlobal := ""


; Define hotstring, trigger via hold CapsLock for 1.5s or hold Right Click + Middle click


;====== RED LOADING BAR ===;
	counter = 0
	Progress, ZH16 ZX0 ZY0 B R0-%TimeOut%
	Loop, %TimeOut%
	{
		Sleep, 20    	 ;10
		counter += 1
		Progress, %counter%
		If (counter = TimeCapsToggle)
			Progress, ZH16 ZX0 ZY0 B R0-%TimeOut% CBFF0000  ;CB is seperate, hex/html colorcode
		
	}
	Progress, Off


;====== ORANGE LOADING BAR ===;
	counter = 0
	Progress, ZH16 ZX0 ZY0 B R0-%TimeOut%
	Loop, %TimeOut%
	{
		Sleep, 20
		counter += 1
		Progress, %counter%
		If (counter = TimeCapsToggle)
			Progress, ZH16 ZX0 ZY0 B R0-%TimeOut% CBff9900  ;CB is seperate, hex/html colorcode
		
	}
	Progress, Off


;====== YELLOW LOADING BAR ======;
	counter = 0
	Progress, ZH16 ZX0 ZY0 B R0-%TimeOut%
	Loop, %TimeOut%
	{
		Sleep, 20
		counter += 1
		Progress, %counter%
		If (counter = TimeCapsToggle)
			Progress, ZH16 ZX0 ZY0 B R0-%TimeOut% CBFFD700  ;CB is seperate, hex/html colorcode
		
	}
	Progress, Off
	

;====== GREEN LOADING BAR ======;
	counter = 0
	Progress, ZH16 ZX0 ZY0 B R0-%TimeOut%
	Loop, %TimeOut%
	{
		Sleep, 20
		counter += 1
		Progress, %counter%
		If (counter = TimeCapsToggle)
			Progress, ZH16 ZX0 ZY0 B R0-%TimeOut% CB1DB954  ;CB is seperate, hex/html colorcode
		
	}
	Progress, Off


;====== LIGHT BLUE (aka indigo) LOADING BAR ======;
	counter = 0
	Progress, ZH16 ZX0 ZY0 B R0-%TimeOut%
	Loop, %TimeOut%
	{
		Sleep, 20
		counter += 1
		Progress, %counter%
		If (counter = TimeCapsToggle)
			Progress, ZH16 ZX0 ZY0 B R0-%TimeOut% CB3CDFFF  ;CB is seperate, hex/html colorcode
		
	}
	Progress, Off


;====== DARK BLUE (aka indigo) LOADING BAR ======;
	counter = 0
	Progress, ZH16 ZX0 ZY0 B R0-%TimeOut%
	Loop, %TimeOut%
	{
		Sleep, 20
		counter += 1
		Progress, %counter%
		If (counter = TimeCapsToggle)
			Progress, ZH16 ZX0 ZY0 B R0-%TimeOut% CB0000FF  ;CB is seperate, hex/html colorcode
		
	}
	Progress, Off


;====== PURPLE LOADING BAR ======;
	counter = 0
	Progress, ZH16 ZX0 ZY0 B R0-%TimeOut%
	Loop, %TimeOut%
	{
		Sleep, 20
		counter += 1
		Progress, %counter%
		If (counter = TimeCapsToggle)
			Progress, ZH16 ZX0 ZY0 B R0-%TimeOut% CB7F00FF   ;CBCF9FFF ;CB is seperate, hex/html colorcode
		
	}
	Progress, Off










; Close ToolTip
TOOLTIP:
	ToolTip,
	SetTimer,TOOLTIP,Off


;!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
;!! /\ WHOLE OTHER SCRIPT here /\ !!
;!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!



sleep 90

boom =
(
            
 ░          ░ ░      ░ ░         ░   
 ░    ░ ░ ░ ░ ▒  ░ ░ ░ ▒  ░      ░   
▒░▒   ░   ░ ▒ ▒░   ░ ▒ ▒░ ░  ░      ░
░▒ ▒░▒░ ▒░ ▒░▒░▒░ ░ ▒░▓░▒
⣿⡟⠛⠛⢿⣿⣿⣿⣿⣿⣿⣟⠛⢻⣿⣿⣿⣿⣿⣿⡿⠛⣿⣿⣿⣿⡿⠛⠛⣿░▒
⣿⣧⣄⠀⠈⠻⣿⣿⣿⣿⣿⣿⡄⠸⣿⣿⣿⣿⣿⣿⢃⣾⣿⣿⣿⡿⠁⠀⠀⣿▒░
⣿⣿⣿⣿⣶⣄⠙⢿⣿⣿⣿⣿⣿⡄⣿⣿⣿⣿⢹⣿⣿⣿⣿⣿⠟⠀⣀⣴⣾⣿░░  
⣿⣿⣿⣿⣿⣿⣿⣮⡻⣿⣿⣿⣿⣷⣿⣿⣿⠃⢸⡿⢱⣿⡿⢃⣴⣾⣿⣿⣿⣿░    
⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⠙⢿⣿⣿⡿⠋⠀⠘⢠⣿⣿⣶⣿⣿⣿⣿⣿⣿⣿▓ ░
⣿⣿⣿⣿⣿⣿⣮⣍⡛⠛⠋⠀⠀⠈⠉⠀⠀⠀⠀⢸⣿⡿⢿⣿⣿⣿⠿⠟⠛⣿█▓   ▒
⣿⣿⣿⣷⣮⣍⡉⠉⠉⠀⠀⠀⢀⣤⣄⣤⣤⣄⠀⠀⠀⣰⣿⣯⣭⣴⣶⣶⣶⣿███  
⣿⡇⠈⠙⠛⠿⢿⣷⣄⠀⠀⢿ BOOM ⡋⠀⠀⢿⣿⣿⣿⣿⣿⣿⣿⣿▀▒░▒░▒
⣿⣿⣿⣿⣿⣿⡿⣿⣿⠇⠀⠀⠰⣿⣿⠀⠿⠋⠀⠀⠀⠈⠙⠿⣿⣿⣿⣿⣿⣿░ ▒░▒░▒
⣿⡟⠉⢉⣡⣴⣿⠟⠁⠀⠀⠀⠀⠈⠁⠀⠀⠀⠀⠀⠀⠀⠀⣤⣤⣬⣭⣿⣟⣿░ ░ ▒ ▒
⣿⣧⣴⣿⣿⣿⣥⣶⣶⣄⠀⠀⠀⠀⠀⢀⣤⣶⣦⣄⡐⢶⣦⣤⣙⡿⣿⣿⣿⣿░   ▒
⣿⣿⣿⣿⣿⣿⡿⣿⣿⣿⠀⢀⣤⡆⢠⣿⣿⣿⣿⣿⣿⣦⣿⣿⣿⣿⣿⣿⣿⣿▒░
⣿⣿⣿⡿⠟⣡⣾⣿⣿⠇⣠⣿⣿⢣⣿⣿⡇⣿⣿⣿⣿⡝⢿⣿⣿⣿⣿⣿⣿⣿░▒░
⣿⡟⠋⠀⣴⣿⣿⣿⣏⣴⣿⣿⣿⣿⣿⣿⠇⣿⣿⡌⢿⣿⣧⡈⠛⢿⣿⣿⣿⣿▒░   
⣿⣧⣤⣾⣿⣿⣿⣿⣾⣿⣿⣿⣿⣿⣿⣿⣤⣽⣿⣷⣤⣽⣿⣿⣤⣤⣬⣽⣿⣿░
░▒▓███▀▒░ ▒░▒░▒░ ░ ▒░▒░▒
▒░▒   ░   ░ ▒ ▒░   ░ ▒ ▒░ ░  ░      ░
 ░    ░ ░ ░ ░ ▒  ░ ░ ░ ▒  ░      ░   
            ░ ░      ░ ░         ░   
      ░     

)

msgbox %boom%

MyTitle := "Thank You"

msgbox, 0, %MyTitle% (1/5), Thank you for using this script. I spent a lot of time making it. 

msgbox, 0, %MyTitle% (2/5), My goal was to make THE capslock menu. `n`nAnything that is not used on a daily basis is placed in the 'More Options' section. 

msgbox, 0, %MyTitle% (3/5), This script was HEAVILY inspired/reused code from u/S3rLoG and his capslock menu, so huge credit to him! `n`n(That loading bar also used to be in his script but he removed it in a later release)

msgbox, 0, %MyTitle% (4/5), Thank you everyone, especially the ahk reddit community, for all of your help. `n`n(I could NOT have made this without help) `n`n(Special shoutout to u/anonymous1184 for being a legend whose comments always offer the solutions I need) `n`nAlso, feel free to copy code from this script, or change it in any way you want!

msgbox, 0, %MyTitle% (5/5), IMPORTANT NOTES: `n`n• Pressing A opens More Options  `n`n• To set dark mode as the default, follow the instructions under ===Settings=== in the script `n`n• Ctrl-SHIFT-Capslock will send {Ctrl A} to select ALL text before showing the menu. Try it out!

SetCapsLockState, Off

	Exit








;;;;;; THE REAL STUFF ;;;;;; ===============================================================================================================================================================================================================================================


    Case "UPPERCASE        &1":
      StringUpper, TempText, TempText

    Case "lowercase            &2":
      StringLower, TempText, TempText

    Case "Title Case             &3":
      StringLower, TempText, TempText, T

    Case "Sentence case     &4":
      StringLower, TempText, TempText
      TempText := RegExReplace(TempText, "((?:^|[.!?]\s+)[a-z])", "$u1")


;__________________________________________________________________________________________________

    Case "″...″   &Q":
      TempText := RegExReplace(TempText, "\s+$")   ;gets rid of whitespace at end (ChatGPT)
      TempText := """" TempText """"

    Case "'...'    &W":
        TempText := RegExReplace(TempText, "\s+$")
	TempText := "'" TempText "'"

    Case "(...)    &E":
      TempText := RegExReplace(TempText, "\s+$")
      TempText := "(" TempText ")"

;-----More Options--------------------------

    Case "`{...}    &A":
      TempText := RegExReplace(TempText, "\s+$")
      TempText := "{" TempText "}"

    Case "`*...*    &S":
      TempText := RegExReplace(TempText, "\s+$")
      TempText := "*" TempText "*"

;-------------

Case "&Date - 06/07/04":
      FormatTime, CurrentDateTime,,MM/dd/yy ; - hh:mmtt
      SendInput %CurrentDateTime%
      exit


;MORE__________________________________________________________________________________________________



    Case "iNVERT cASE":
      {
         CopyClipboardCLM()
         Inv_Char_Out := ""
         Loop % StrLen(Clipboard)
         {
             Inv_Char := SubStr(Clipboard, A_Index, 1)
             if Inv_Char is Upper
                 Inv_Char_Out := Inv_Char_Out Chr(Asc(Inv_Char) + 32)
             else if Inv_Char is Lower
                 Inv_Char_Out := Inv_Char_Out Chr(Asc(Inv_Char) - 32)
             else
                 Inv_Char_Out := Inv_Char_Out Inv_Char
         }
         Clipboard := Inv_Char_Out
         PasteClipboardCLM()
      }

    Case "SpOnGeBoB cAsE":
      {
          CopyClipboardCLM()
          Inv_Char_Out := ""
          StringLower, Clipboard, Clipboard
          Loop, Parse, Clipboard
          {
              if (Mod(A_Index, 2) = 0)
		  Inv_Char_Out .= Format("{1:L}", A_LoopField)
              else
                  Inv_Char_Out .= Format("{1:U}", A_LoopField)                  
          }
          Clipboard := Inv_Char_Out
          PasteClipboardCLM()
      }


    Case "S p r e a d T e x t":
	{
	vText := "exemple"
	TempText := % RegExReplace(TempText, "(?<=.)(?=.)", " ")
	}	


    Case "raNDoM cASE":
	{
 	   CopyClipboardCLM()
 	   RandomCase := ""
  	  for _, v in StrSplit(Clipboard)
   	 {
   	     Random, r, 0, 1
   	     RandomCase .= Format("{:" (r?"L":"U") "}", v)
  	  }
  	  Clipboard := RandomCase
  	  PasteClipboardCLM()
	}


    Case "Reverse":
      Temp2 =
      StringReplace, TempText, TempText, `r`n, % Chr(29), All
      Loop Parse, TempText
        Temp2 := A_LoopField . Temp2
      StringReplace, TempText, Temp2, % Chr(29), `r`n, All








Case "Dark Mode | Light Mode":

    If (DarkMode)
    {
        DarkMode := false
        ;Menu, Case, Toggle Mode, Dark Mode
        MenuDark(3) ; Set to ForceLight
	WelcomeTrayTipLight()
    }
    else
    {
        DarkMode := true
        ;Menu, Case, Toggle Mode, Light Mode
        MenuDark(2) ; Set to ForceDark
	WelcomeTrayTipDark()
    }
Return






  }

SetCapsLockState, Off





;__________________________________________________________________________________________________

 




;;;;;;;;;;;\/ THIS HAS TO BE AT THE BOTTOM OF ALL THE CASE THINGS ;;;;;;;;;;;;;

PutText(TempText)
SetCapsLockState, Off
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;







 
;;;;;;;;;;;;;;;;;;; Handy function. ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Copies the selected text to a variable while preserving the clipboard.
GetText(ByRef MyText = "")
{
   SavedClip := ClipboardAll
   Clipboard =
   Send ^c
   ClipWait 0.5
   If ERRORLEVEL
   {
      Clipboard := SavedClip
      MyText =
      Return
   }
   MyText := Clipboard
   Clipboard := SavedClip
   Return MyText
SetCapsLockState, Off
}
 
; Pastes text from a variable while preserving the clipboard.
PutText(MyText)
{
   SavedClip := ClipboardAll 
   Clipboard =              ; For better compatability
   Sleep 20                 ; with Clipboard History
   Clipboard := MyText
   Send ^v
   Sleep 100
   Clipboard := SavedClip
SetCapsLockState, Off
   Return
}






SetCapsLockState, Off
Send, {capslock up}
























;;;;;;;;;;;;;;;;;;;; Dark Mode Activated GUI Script ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




WelcomeTrayTipDark() {
    static GuiCreated := 0
    static HwndWelcomeScreen1
    static MonRight, MonBottom
    if !GuiCreated  {
        GuiCreated := 1
        Gui, WelcomeScreen1:New, +AlwaysOnTop -Caption +ToolWindow +HwndHwndWelcomeScreen1 +LastFound -DPIScale +E0x20 ; Clickthrough=E0x20
        Gui, WelcomeScreen1:Margin, 30, 25
        Gui, WelcomeScreen1:Font, s30, Segoe UI
        Gui, WelcomeScreen1:Color, 1A1A1A
        Gui, WelcomeScreen1:Add, Text, y20 cWhite, Dark Mode Activated   ;, %A_UserName% ; make a text control showing welcome back, (username)
        WinSet, Transparent, 0                              ; set gui transparent
        SysGet, P, MonitorPrimary                           ; get primary monitor number
        SysGet, Mon, MonitorWorkArea, % P                   ; get size of primary monitor
        Gui, WelcomeScreen1:Show, Hide                       ; Show gui
        WinGetPos, X, Y, W, H                               ; get pos of gui
        WinMove, % MonRight - W - 10, % MonBottom - H - 10  ; move gui to bottom right
        WinSet, Region, 0-0 W%W% H%H% R20-20                ; round corners
    }
    Gui, WelcomeScreen1:Show, NA
    bf := Func("AnimateFadeIn").Bind(HwndWelcomeScreen1)
    SetTimer, %bf%, -200
}


WelcomeTrayTipLight() {
    static GuiCreated := 0
    static HwndWelcomeScreen
    static MonRight, MonBottom
    if !GuiCreated  {
        GuiCreated := 1
        Gui, WelcomeScreen:New, +AlwaysOnTop -Caption +ToolWindow +HwndHwndWelcomeScreen +LastFound -DPIScale +E0x20 ; Clickthrough=E0x20
        Gui, WelcomeScreen:Margin, 30, 25
        Gui, WelcomeScreen:Font, s30, Segoe UI
        Gui, WelcomeScreen:Color, white  ;<=--\/---------------COLOR OF BOX / TEXT
        Gui, WelcomeScreen:Add, Text, y20 cBlack, Light Mode Activated   ;, %A_UserName% ; make a text control showing welcome back, (username)
        WinSet, Transparent, 0                              ; set gui transparent
        SysGet, P, MonitorPrimary                           ; get primary monitor number
        SysGet, Mon, MonitorWorkArea, % P                   ; get size of primary monitor
        Gui, WelcomeScreen:Show, Hide                       ; Show gui
        WinGetPos, X, Y, W, H                               ; get pos of gui
        WinMove, % MonRight - W - 10, % MonBottom - H - 10  ; move gui to bottom right
        WinSet, Region, 0-0 W%W% H%H% R20-20                ; round corners
    }
    Gui, WelcomeScreen:Show, NA
    bf := Func("AnimateFadeIn").Bind(HwndWelcomeScreen)
    SetTimer, %bf%, -200
}



AnimateFadeIn(hwnd) {
    static Value := 0
    WinSet, Transparent, % Value+=15, % "ahk_id" hwnd
    if (Value >= 255) {                         ; if gui is fully opaque
        Value := 0                              ; reset transparency value
        bf := Func("AnimateFadeOut").Bind(hwnd) ; make bound function to fade out
        SetTimer, %bf%, -1000     ;<=--------------------------------------------------------CHANGE HOW LONG
    } else {
        bf := Func("AnimateFadeIn").Bind(hwnd)  ; create bound functiion to fade in
        SetTimer, %bf%, -15                     ; rerun bound function until gui is fully opaque
    }
}

AnimateFadeOut(hwnd) {
    static Value := 255
    WinSet, Transparent, % Value-=15, % "ahk_id" hwnd
    if (Value <= 0) {                           ; if gui invisible
        Value := 255                            ; reset transparency value
        Gui, %hwnd%:Hide                        ; hide gui when finished
    } else {
        bf := Func("AnimateFadeOut").Bind(hwnd) ; create bound functiion to fade out
        SetTimer, %bf%, -15                     ; rerun bound function until gui is transparent
    }
}




