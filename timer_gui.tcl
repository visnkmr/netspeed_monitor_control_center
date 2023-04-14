set timer 0
set paused 0
set pause_time 0

proc start_timer {} {
    global timer paused pause_time
    if {$paused} {
        set paused 0
        set pause_time [clock seconds]
    } else {
        set timer 0
        set pause_time 0
    }
    after 1000 [list update_timer .timer]
}

proc stop_timer {} {
    global timer paused pause_time
    set paused 0
    set timer 0
    set pause_time 0
    update_timer .timer
}

proc pause_timer {} {
    global paused pause_time
    set paused 1
    set pause_time [clock seconds]
}

proc update_timer w {
    global timer paused pause_time
    if {!$paused} {
        if {$pause_time} {
            set elapsed [expr {[clock seconds] - $pause_time}]
            incr timer $elapsed
            set pause_time 0
        } else {
            incr timer
        }
        set seconds [expr {$timer % 60}]
        set minutes [expr {int($timer / 60) % 60}]
        set hours [expr {int($timer / 3600)}]
        set text [format "%02d:%02d:%02d" $hours $minutes $seconds]
        $w configure -text $text
        after 1000 [list update_timer $w]
    }
}

button .start -text "Start/Resume" -command start_timer
button .stop -text "Stop/Reset" -command stop_timer
button .pause -text "Pause" -command pause_timer

label .timer -text "00:00:00" -font {Helvetica 36 bold} -width 8 -height 2

grid .start .pause .stop .timer -sticky ew -padx {10 10} -pady {10 10}