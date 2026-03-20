set fp [open "netlist.v" r]
set file_data [read $fp]

puts $file_data

close $fp
