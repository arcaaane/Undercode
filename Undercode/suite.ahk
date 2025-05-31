#NoEnv
#SingleInstance Force
SetWorkingDir, %A_ScriptDir%
SetTitleMatchMode, 2
CoordMode, Pixel, Screen
CoordMode, ToolTip, Screen

espOn := false
attackOn := false
perfectOn := false

Gui, Add, Text,, Undertale Mod Menu
Gui, Add, Checkbox, vespToggle gToggleESP, Enable ESP (Combat + Player)
Gui, Add, Checkbox, vattackToggle gToggleAttack, Auto Attack
Gui, Add, Checkbox, vperfectToggle gTogglePerfect, Perfect Attack
Gui, Add, Button, gPacifist, Load Pacifist Save
Gui, Add, Button, gGenocide, Load Genocide Save
Gui, Add, Button, gSans, Load Sans Save
Gui, Show,, Undertale Cheat

SetTimer, Tick, 30
return

Tick:
if (espOn)
{
    PixelSearch, px, py, 0, 0, A_ScreenWidth, A_ScreenHeight, 0xFF0000, 10, Fast RGB
    if !ErrorLevel {
        DrawBox(px, py)
        return
    }
    PixelSearch, px, py, 0, 0, A_ScreenWidth, A_ScreenHeight, 0xD29B8E, 10, Fast RGB
    if !ErrorLevel {
        DrawBox(px, py)
        return
    }
    Gui, Hide
}

if (attackOn) {
    SendInput, z
    Sleep, 300
}

if (perfectOn) {
    SendInput, z
    Sleep, 100
}
return

ToggleESP:
Gui, Submit, NoHide
espOn := espToggle
return

ToggleAttack:
Gui, Submit, NoHide
attackOn := attackToggle
return

TogglePerfect:
Gui, Submit, NoHide
perfectOn := perfectToggle
return

DrawBox(x, y) {
    local size := 20
    x -= size//2
    y -= size//2
    Gui, 99:Destroy
    Gui, 99:+AlwaysOnTop -Caption +ToolWindow +LastFound
    Gui, 99:Color, Red
    WinSet, Transparent, 150
    Gui, 99:Show, x%x% y%y% w%size% h%size% NoActivate
}

Pacifist:
CopySave("pacifist")
return

Genocide:
CopySave("genocide")
return

Sans:
CopySave("sans")
return

CopySave(slotName) {
    saveDir := A_ScriptDir "\saves\" slotName
    target := A_AppData "\UNDERTALE"
    FileCopy, %saveDir%\file0, %target%\file0, 1
    FileCopy, %saveDir%\file9, %target%\file9, 1
    FileCopy, %saveDir%\undertale.ini, %target%\undertale.ini, 1
    MsgBox, Save loaded: %slotName%
}
