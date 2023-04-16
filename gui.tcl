wm withdraw .

proc run_command {cmd arg} {
  
  set pid [exec $cmd $arg &]
  
  return $pid
}


set window [toplevel .window]
wm title $window "Netspeed Monitor"
wm protocol $window WM_DELETE_WINDOW {stop_callback; exit 0} ;

set label [label $window.label -text "Netspeed monitor: Not running"]


set start_button [button $window.start_button -text "Start"]


set stop_button [button $window.stop_button -text "Stop"]


pack $label -side top -fill x -padx 10 -pady 10
pack $start_button -side left -fill x -padx 10 -pady 10
pack $stop_button -side right -fill x -padx 10 -pady 10


set rust_pid ""


set python_pid ""


proc start_callback {} {
  
  set current_dir [pwd]

  global rust_pid
  set rust_pid [run_command "$current_dir/netspeed_server" "enp5s0"]

  
  global python_pid
  set python_pid [run_command "$current_dir/ns_gui_sse" ""]

  
  global label
  $label configure -text "Netspeed monitor: Running"
}


proc stop_callback {} {
  
  global rust_pid
  if {$rust_pid ne ""} {
    exec kill $rust_pid
    set rust_pid ""
  }

  
  global python_pid
  if {$python_pid ne ""} {
    exec kill $python_pid
    set python_pid ""
  }

  
  global label
  $label configure -text "Netspeed monitor: Not running"
}


$start_button configure -command start_callback


$stop_button configure -command stop_callback


start_callback


tkwait window $window