package require Tk

wm overrideredirect . 1
wm geometry . +0+0
wm attributes . -topmost 1
# wm attributes . -disabled 1
# wm attributes . -transparentcolor white

label .time -text "" -bg black -fg white
pack .time

proc update_time {} {
    set current_time [clock format [clock seconds] -format %H:%M:%S]
    .time configure -text $current_time
    after 1000 update_time
}

update_time