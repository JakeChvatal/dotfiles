#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.


; Disable Win key
LWin::Return
; Enable Win + * shortcuts
~LWin & *::Return

; CapsLock -> Esc when pressed
; TODO: simulate ctrl when held
capslock::Esc
; capslock & *::Ctrl & *
