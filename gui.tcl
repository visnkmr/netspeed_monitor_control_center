wm withdraw .
# Define a function to run a command and return a process id
proc run_command {cmd} {
  # Use exec with & to run the command in the background
  set pid [exec $cmd &]
  # Return the process id
  return $pid
}

# Create a window to hold the GUI elements
set window [toplevel .window]
wm title $window "Netspeed Monitor"
wm protocol $window WM_DELETE_WINDOW {stop_callback; exit 0} ;# add this line
# Create a label to show the status of the binaries
set label [label $window.label -text "Netspeed monitor: Not running"]

# Create a button to start the binaries
set start_button [button $window.start_button -text "Start"]

# Create a button to stop the binaries
set stop_button [button $window.stop_button -text "Stop"]

# Arrange the GUI elements using pack
pack $label -side top -fill x -padx 10 -pady 10
pack $start_button -side left -fill x -padx 10 -pady 10
pack $stop_button -side right -fill x -padx 10 -pady 10

# Define a variable to hold the Rust backend process id
set rust_pid ""

# Define a variable to hold the Python frontend process id
set python_pid ""

# Define a callback function for the start button click event
proc start_callback {} {
  # Run the Rust backend binary and store the process id
  global rust_pid
  set rust_pid [run_command "./netspeed_server"]

  # Run the Python frontend binary and store the process id
  global python_pid
  set python_pid [run_command "./ns_gui_sse"]

  # Update the label text
  global label
  $label configure -text "Netspeed monitor: Running"
}

# Define a callback function for the stop button click event
proc stop_callback {} {
  # Stop the Rust backend process if it exists
  global rust_pid
  if {$rust_pid ne ""} {
    exec kill $rust_pid
    set rust_pid ""
  }

  # Stop the Python frontend process if it exists
  global python_pid
  if {$python_pid ne ""} {
    exec kill $python_pid
    set python_pid ""
  }

  # Update the label text
  global label
  $label configure -text "Netspeed monitor: Not running"
}

# Connect the start button click event to the start callback function
$start_button configure -command start_callback

# Connect the stop button click event to the stop callback function
$stop_button configure -command stop_callback

# Start the main event loop
tkwait window $window