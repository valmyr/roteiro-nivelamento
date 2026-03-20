set fp [open "netlist.v" r]
set file_data [read $fp]

puts $file_data

close $fp

set T1 5; # Teste para validar as os prints;

puts "=== RELATÓRIO DE CÉLULAS ===";
puts "AND2: ${T1} instâncias";
puts "XOR2: ${T1} instâncias";
puts "flipflop_D: ${T1} instâncias";
puts "TOTAL: ${T1} instâncias";
