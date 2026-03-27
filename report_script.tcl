#!/usr/bin/tclsh
set fp [open "netlist.v" r]; # Diretório do arquivo, tclsh report_script.tcl 
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


set blocos [regexp -all -inline {(?s)\mmodule\M.*?\mendmodule\M} $file_txt]; #Obtendo modulos definido pelo desenvolvedor
puts "\n=== HIERARQUIA DO DESIGN ==="
foreach bloco $blocos {
    #Iterando sobre estes modules e printando usando a formatacao do trabalho
    set subblocos [regexp -all -inline {(?s)\mmodule\M.*?\mendmodule\M} $bloco]

    set and [regexp -all {AND2} $subblocos];
    set xor [regexp -all {XOR2} $subblocos];
    set flipflop_d [regexp -all {flipflop_D ff} $subblocos];

    set zblocos [regexp -all -inline {(module)\s([\w]+)\s\(} $subblocos]; #Verificando se ha' instancias nos submodulos

    puts [lindex $zblocos 2]; #Imprime o Modulo de hierarquia superior

    #Gerando a arvore hierarquica dos modulos basenado-se nas dados obtidos dos filtros regexp

    #Caso a soma das celulas base seja maior que zero e a quantidade de fliflops forem zero
    #print ("Apenas celulas primitivas)
    if {($and + $xor > 0) && ($flipflop_d == 0)} {
       puts "   |__(apenas celulas primitivas)\n"
    }
    #Caso a soma de celulas base e a quantidade de flipflos sejam zero 
    #print "Modulo primitivo - sem submodulos"
    if {($and+$xor) == 0 && ($flipflop_d == 0) } {
       puts "   |__(modulo primitivo - sem submodulos)\n"
    }
    #Caso a soma das celulas base e a quantidade de flipflops sejam maior que zero 
    #print "flipflop_d  (x instancias)
    #print "(celulas primitivas)"
    if {($and+$xor) > 0 && ($flipflop_d > 0) } {
       puts "   |__flipflop_d  ($flipflop_d instancias)"
       puts "   |__(celulas primitivas)\n"
    }
    incr i
}