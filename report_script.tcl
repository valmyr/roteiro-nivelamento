set fp [open "netlist.v" r]; # Diretório do arquivo 
set file_txt [read $fp]; # Leitura do Arquivo netlist

puts $file_txt

close $fp

set T1 5; # Teste para validar as os prints;

puts "=== RELATÓRIO DE CÉLULAS ===";
puts "AND2: ${T1} instâncias";
puts "XOR2: ${T1} instâncias";
puts "flipflop_D: ${T1} instâncias";
puts "TOTAL: ${T1} instâncias";
