set fp [open "netlist.v" r]; # Diretório do arquivo 
set file_txt [read $fp]; # Leitura do Arquivo netlist

#puts $file_txt

close $fp

set and [regexp -all {AND2} $file_txt]
set xor [regexp -all {XOR2} $file_txt]

puts "=== RELATÓRIO DE CÉLULAS ===";
puts "AND2: ${and} instâncias";
puts "XOR2: ${xor} instâncias";
puts "flipflop_D: ${T1} instâncias";
puts "TOTAL: ${T1} instâncias";
