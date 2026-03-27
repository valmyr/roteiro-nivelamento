# Leitura do arquivo da netlist
set netlist_file [open "netlist.v" r]
set data [read $netlist_file]
close $netlist_file

# REGEX para obter as nets declaradas em inputs, outputs e wires
set match_ports_declaration [regexp -all -inline {(wire|input|output(?!\sreg))\s(\[[0-9\:]*\]\s)?(\w+)} $data];

# REGEX para obter as nets conectadas em entradas e saídas de instâncias
set match_ports_instance [regexp -all -inline {\.([A-Za-z]\w*)\(([A-Za-z]\w*\[[\d]+\]|[A-Za-z]\w*)} $data];

set net_dict {}
set net_list {}
set top10_fanouts {}
set zero_fanouts {}

# Adiciona todas as nets declaradas em inputs, outputs e wires em um dicionário com fanout igual a 0
foreach {full_match type range name} $match_ports_declaration {
  if {$range ne ""} {
    # Nets com mais de um bit são salvas com o nome incluindo a posição
    if ([regexp {\[([0-9]+):([0-9]+)\]} $range -> msb lsb]) {
      for {set i $lsb} {$i <= $msb} {incr i} {
        dict set net_dict "${name}\[$i\]" 0
      }
    }
  } else {
    lappend net_dict $name 0
  }
}

# Adicionas as nets que só aparecem nas instâncias e incrementa o fanout
foreach {full_match port name} $match_ports_instance {
  if {[dict exists $net_dict $name]} {
    # Incrementa o fanout se porta em que a net está conectada não é uma saída
    if {$port ni {y Q}} {
      dict incr net_dict $name
    }
 
 } else { 
    dict set net_dict "${name}" 0
  }
}

# Crie uma lista a partir do dicionário para simplificar a ordenação
dict for {name fanout} $net_dict {
  lappend net_list [list $name $fanout]
}

# Ordena a lista de nets em ordem decrescente de fanouts
set sorted_net_list [lsort -integer -decreasing -index 1 $net_list]

# Separa as 10 nets com mais fanouts e as com 0 fanouts em listas
foreach net $sorted_net_list {
  lassign $net name fanout
  
  if {$fanout > 0 && [llength $top10_fanouts] < 10} {
      lappend top10_fanouts $net
  } 
  
  if {$fanout == 0} {
    lappend zero_fanouts $name
  }
}

# Exibe os resultados
puts "\n=== TOP 10 NETS POR FANOUT ==="

foreach net $top10_fanouts {
  lassign $net name fanout
  puts "$name: fanout = $fanout"  
}

puts "\n=== NETS COM FANOUT ZERO (POSSÍVEIS ERROS) ==="

foreach name $zero_fanouts {
  puts "$name"  
}
