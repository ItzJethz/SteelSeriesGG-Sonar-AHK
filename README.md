# SteelSeries GG Sonar Controller – AutoHotkey Script

This **AutoHotkey v2 script** allows you to control SteelSeries GG Sonar modes and volume directly from your keyboard media keys, providing a faster and more intuitive way to manage **Game**, **Chat**, **Media**, and **Aux** channels.

---

## **Features**

- **Mode Switching:** Cycle through Sonar modes using multiple presses of the Mute key.  
- **Mute:** Mute the current mode with a single press.  
- **Volume Control:** Adjust the volume for the current mode using the keyboard’s media scroll wheel.  
- **Quick Mode Navigation:**  
  - Double-press Mute → switch to the next mode  
  - Triple-press Mute → switch to the previous mode  
- **Tray Icon Controls:** Access and toggle modes, mute, reload, or exit the script from the system tray.  
- **Audible Feedback:** Distinct beep tones indicate mode changes.  

---

## **Sonar Keybind Configuration**

Before using the script, configure **SteelSeries Sonar** with the following **custom keybinds**:

| Sonar Mode | Volume Up | Volume Down | Mute |
| ---------- | --------- | ----------- | ---- |
| Game       | F13       | F14         | F21  |
| Chat       | F15       | F16         | F22  |
| Media      | F17       | F18         | F23  |
| Aux        | F19       | F20         | F24  |

> These are virtual key hooks. They allow AutoHotkey to send key presses to Sonar without affecting normal keyboard input.

> Tip: It’s recommended to run the script first and cycle through all modes while applying the keybinds. This helps you place and identify where each Function key should be assigned inside Sonar.

---

## **Setup Instructions**

1. **Install AutoHotkey v2**  
   - Download and install AutoHotkey v2 from [AutoHotkey](https://www.autohotkey.com/).

2. **Configure Sonar Keybinds**  
   - Set Sonar’s **Volume Up**, **Volume Down**, and **Mute** keys according to the table above in Steelseries GG's settings.

3. **Configure Sonar Overlay**  
   - Enable sonar overlay in Steelseries GG's settings.

4. **Save and Run the Script**  
   - Save the `.ahk` file anywhere convenient.  
   - Run it with AutoHotkey v2. Optionally, place it in `shell:startup` to start automatically on login.

---

## **Hotkeys Overview**

| Action            | Hotkey / Input                 |
| ----------------- | ------------------------------ |
| Volume Up         | Media scroll wheel **up**      |
| Volume Down       | Media scroll wheel **down**    |
| Mute current mode | Mute key (**1 press**)         |
| Next mode         | Mute key (**2 quick presses**) |
| Previous mode     | Mute key (**3 quick presses**) |

---

## **Tray Menu Options**

- **Current Mode:** Shows the active mode.  
- **Toggle Mute:** Mutes/unmutes the selected mode.  
- **Mode Selection:** Select any mode directly.  
- **Reload:** Reloads the script.  
- **Exit:** Closes the script.  

---

## **Notes**

- The time window for detecting multiple presses is **500 ms** by default. Adjust if needed.  
- Beeptones indicate mode changes: higher pitch corresponds to later modes in the list.  
- The script lets you manage audio without opening the Sonar interface, making it ideal for gaming or streaming.  
