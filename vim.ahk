#HotIf WinActive("ahk_exe navicat.exe")

global mode := "NORMAL"

q::keyBinding(, "++q")
w::keyBinding(,"^{right}")
^w::keyBinding(, , , "^{backspace}")
e::keyBinding()
r::keyBinding()
t::keyBinding()
y::keyBinding(, "^c")
u::keyBinding(,"^z")
^u::keyBinding(,"{PageUp}")
i::keyBinding("startInsertMode")
+i::keyBinding("normalModeShiftI")
o::keyBinding("normalModeO")
+o::keyBinding("normalModeShiftO")
^o::keyBinding(, , "startNormalMode")
p::keyBinding(, "^v")
^p::keyBinding(, , , "{up}")
a::keyBinding("startInsertMode")
+a::keyBinding("normalModeShiftA")
s::keyBinding()
+s::keyBinding("normalModeShiftS", , , "+s")
d::keyBinding()
+d::keyBinding(, "{Home}+{End}{backspace}")
^d::keyBinding(, "{PageDown}")
f::keyBinding()
g::keyBinding("normalModeGG")
+g::keyBinding(, "^{End}{Home}")
h::keyBinding(, "{left}")
^h::keyBinding(, "{left}", , "{backspace}")
j::keyBinding(, "{down}")
^j::keyBinding(, , , "{enter}")
k::keyBinding(, "{up}")
l::keyBinding(, "{right}")
z::keyBinding()
x::keyBinding(, "{Del}")
+x::keyBinding(, "{backspace}")
c::keyBinding()
+c::keyBinding("normalModeShiftC")
^c::keyBinding(, "^c", "startNormalMode")
v::keyBinding()
b::keyBinding(, "^{left}")
+b::keyBinding(, "^{left}")
n::keyBinding()
^n::keyBinding(, , , "{down}")
m::keyBinding()

startNormalMode()
{
    global mode := "NORMAL"
}

startInsertMode()
{
    ;TraySetIcon("normal-mode.ico")
    global mode := "INSERT"
}

isInNormalMode() {
    return mode = "NORMAL"
}

isInInsertMode() {
    return mode = "INSERT"
}

keyBinding(normalModeAction?, normalModeArg?, insertModeAction:="send", insertModeArg?) {
    if isInInsertMode() {
        if insertModeAction != "send" && isSet(insertModeArg)
            %insertModeAction%(insertModeArg)
        else if insertModeAction != "send" && !isSet(insertModeArg)
            %insertModeAction%()
        else if insertModeAction == "send" && isSet(insertModeArg)
            send(insertModeArg)
        else if insertModeAction == "send" && !isSet(insertModeArg)
            send(getCurrentKey())
    } else if isInNormalMode() {
        if isSet(normalModeAction) && isSet(normalModeArg)
            %normalModeAction%(normalModeArg)
        else if isSet(normalModeAction)
            %normalModeAction%()
        else if isSet(normalModeArg)
            send(normalModeArg)
    }
}

normalModeShiftI() {
    send "{Home}"
    startInsertMode()
}

normalModeShiftA() {
    send "{End}" 
    startInsertMode()
}

normalModeGG() {
    if (A_PriorHotkey == "g" and A_TimeSincePriorHotkey < 200)
    {
        KeyWait "g"
        send "^{Home}"
    }
    return
}

normalModeShiftC() {
    send "+{End}{backspace}"
    startInsertMode()
}
 
normalModeO() {
    send "{End}{enter}"
    startInsertMode()
}

normalModeShiftO() {
    send "{Home}{enter}{up}"
    startInsertMode()
}

normalModeShiftS() {
    send "{Home}{Shift}{End}{Del}"
    startInsertMode()
}

getCurrentKey() {
    currentKey := A_ThisHotKey
    currentKeyWithShift := inStr(currentKey, "+")
    if GetKeyState("CapsLock","T") {
        if currentKeyWithShift
            return strReplace(currentKey, "+")
        else
            return "+" . currentKey
    } else {
        return currentKey
    }
}
