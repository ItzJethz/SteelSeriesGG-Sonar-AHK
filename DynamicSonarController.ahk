#Requires AutoHotkey v2.0
#SingleInstance Force

; === CONFIGURATION ===
modes := ["Game", "Chat", "Media", "Aux"]
currentModeIndex := 1 ; Start in Game mode
InitTrayMenu()

trayMenu := A_TrayMenu
isMuted := false

modeKeys := Map(
    "Game",     { VolUp: "F13", VolDown: "F14", Mute: "F21" },
    "Chat",     { VolUp: "F15", VolDown: "F16", Mute: "F22" },
    "Media",    { VolUp: "F17", VolDown: "F18", Mute: "F23" },
    "Aux",      { VolUp: "F19", VolDown: "F20", Mute: "F24" }
)

PlaySwitchBeep() {
    global modes, currentModeIndex
    switch modes[currentModeIndex] {
        case "Game":   SoundBeep(1000, 80)
        case "Chat":   SoundBeep(1200, 80)
        case "Media":  SoundBeep(1400, 80)
        case "Aux":    SoundBeep(1600, 80)
    }
}

MuteCurrentMode() {
    global modeKeys, modes, currentModeIndex
    key := modeKeys[modes[currentModeIndex]].Mute
    SoundBeep(500, 50) ; Beep tone 500 Hz for 50 ms
    Sleep(50)
    Send("{" key "}")
}

DoubleMuteForSonarGUI() {
    global modeKeys, modes, currentModeIndex
    key := modeKeys[modes[currentModeIndex]].Mute
    Send("{" key "}")
    Sleep(100)
    Send("{" key "}")
}

; === HOTKEYS ===

Volume_Up:: {
    global modeKeys, modes, currentModeIndex
    SendInput("{" modeKeys[modes[currentModeIndex]].VolUp "}")
}

Volume_Down:: {
    global modeKeys, modes, currentModeIndex
    SendInput("{" modeKeys[modes[currentModeIndex]].VolDown "}")
}

; Mute Click (use * keydown only* so it doesn’t double-trigger)
*Volume_Mute::
{
    static lastPress := 0
    static pressCount := 0
    thisPress := A_TickCount
    global currentModeIndex, modes

    ; Detect multiple presses within 500ms (adjust as needed)
    if (thisPress - lastPress < 500) {
        pressCount++
    } else {
        pressCount := 1
    }

    lastPress := thisPress

    SetTimer(() => (
        pressCount = 1 ? MuteCurrentMode()
        : pressCount = 2 ? (
            currentModeIndex := (currentModeIndex = modes.Length ? 1 : currentModeIndex + 1),
            PlaySwitchBeep(),
            DoubleMuteForSonarGUI()
            UpdateTrayMenu()
        )
        : pressCount = 3 ? (
            currentModeIndex := (currentModeIndex = 1 ? modes.Length : currentModeIndex - 1),
            PlaySwitchBeep(),
            DoubleMuteForSonarGUI()
            UpdateTrayMenu()
        )
        : ""
    ), -400)
}

; === TRAY MENU FUNCTIONS ===

UpdateTrayMenu() {
    global trayMenu, modes, currentModeIndex
    trayMenu.Delete()  ; Clear existing menu

    ; Recreate mode list with checkmark on current mode
    for index, mode in modes {
        trayMenu.Add(mode, ModeSelectHandler)
        if (index = currentModeIndex)
            trayMenu.Check(mode)
        else
            trayMenu.Uncheck(mode)
    }

    trayMenu.Add() ; Separator
    trayMenu.Add("Toggle Mute for " modes[currentModeIndex], ToggleMuteHandler)
    trayMenu.Add() ; Separator
    trayMenu.Add("Reload", ReloadScriptHandler)
    trayMenu.Add("Exit", (*) => ExitApp())
    
    ; Update tray tooltip
    A_IconTip := "Current Mode: " modes[currentModeIndex]
}
ReloadScriptHandler(*) {
    Reload
}

ModeSelectHandler(itemName, *) {
    global modes, currentModeIndex
    for index, mode in modes {
        if (mode = itemName) {
            currentModeIndex := index
            break
        }
    }
    PlaySwitchBeep()
    DoubleMuteForSonarGUI()
    UpdateTrayMenu()
}

ToggleMuteHandler(*) {
    MuteCurrentMode()
}

; === INITIALIZE TRAY MENU ON STARTUP ===
InitTrayMenu() {
    global trayMenu
    trayMenu := A_TrayMenu
    trayMenu.Delete() ; clear default items
    UpdateTrayMenu()
}