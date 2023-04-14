package require Tk

wm overrideredirect . 1
wm geometry . +0+0
wm attributes . -topmost 1
# wm attributes . -disabled 1
# wm attributes . -transparentcolor white

label .close_label -text " x |" -fg white -bg black
bind .close_label <Button-1> {exit}
grid .close_label -row 0 -column 1

label .time -text "" -bg black -fg white
grid .time -row 0 -column 2

proc update_time {} {
    set current_time [clock format [clock seconds] -format %H:%M:%S]
    .time configure -text $current_time
    after 1000 update_time
}

# bind . <Button-1> {
#     set ::startx %X
#     set ::starty %Y
# }

# bind . <B1-Motion> {
#     set dx [expr %X - $::startx]
#     set dy [expr %Y - $::starty]
#     set x [expr [winfo x .] + $dx]
#     set y [expr [winfo y .] + $dy]
#     # after 10 ; 
#     wm geometry . +$x+$y
# }

set lastClickX 0
set lastClickY 0

# proc SaveLastClickPos {event} 

# proc move_window {event} 

bind . <Button-1> {
    global lastClickX lastClickY
    set lastClickX [expr %x]
    set lastClickY [expr %y]
}
bind . <B1-Motion> {
    global lastClickX lastClickY
    set x [expr %x - $lastClickX + [winfo x .]]
    set y [expr %y - $lastClickY + [winfo y .]]
    wm geometry . "+$x+$y"
}
update_time