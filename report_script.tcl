set fp [open "netlist.v" r]; # Diretório do arquivo 
set file_txt [read $fp]; # Leitura do Arquivo netlist

puts $file_txt

close $fp
