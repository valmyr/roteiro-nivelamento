set fp [open "netlist.v" r]; # Diretório do arquivo 
set file_txt [read $fp]; # Leitura do Arquivo netlist
close $fp

set and [regexp -all {AND2} $file_txt]
set xor [regexp -all {XOR2} $file_txt]
set flipflop_d [regexp -all {flipflop_D ff} $file_txt];
set total [expr {$flipflop_d + $and + $xor}];

puts "=== RELATÓRIO DE CÉLULAS ===";
puts "AND2: ${and} instâncias";
puts "XOR2: ${xor} instâncias";
puts "flipflop_D: ${flipflop_d} instâncias";
puts "TOTAL: ${total} instâncias";


set modulos [regexp -all {module} $file_txt]

