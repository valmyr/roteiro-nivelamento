set fp [open "netlist.v" r]; # Diretório do arquivo 
set file_txt [read $fp]; # Leitura do Arquivo netlist

puts $file_txt

close $fp

set flipflop_d [regexp -all {flipflop_D ff} $file_txt]; # Teste para validar as os prints;
set total [expr {$flipflop_d}];

puts "=== RELATÓRIO DE CÉLULAS ===";
puts "AND2: ${flipflop_d} instâncias";
puts "XOR2: ${flipflop_d} instâncias";
puts "flipflop_D: ${flipflop_d} instâncias";
puts "TOTAL: ${total} instâncias";
