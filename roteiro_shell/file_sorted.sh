#!/usr/bin/bash
verilog=$(cd projeto; ls )
src=$(cd projeto; ls *.v)
docs=$(cd projeto; ls *.txt *.md)
scripts=$(cd projeto; ls *.sh *.do *.tcl)
tb=$(cd projeto; ls *_tb.v)
include=$(cd projeto; ls *.vh)


pastas=("src/" "tb/" "include/" "scripts/" "docs/")

for pasta in "${pastas[@]}"; do
    if [ -d "$pasta" ]; then
        echo "O diretório $pasta existe."
    else
        echo "O diretório $pasta NÃO existe."
        mkdir projeto/$pasta
    fi
done

for item in "${src[@]}"; do
    echo "movendo $item -> src" 
    mv projeto/$item projeto/src
done

for item in "${docs[@]}"; do
    echo "movendo $item -> docs" 
    mv projeto/$item projeto/docs
done

for item in "${include[@]}"; do
    echo "movendo $item -> include" 
    mv projeto/$item projeto/include
done

for item in "${scripts[@]}"; do
    echo "movendo $item -> scripts" 
    mv projeto/$item projeto/scripts
    
done

for item in "${tb[@]}"; do
    echo "movendo $item -> tb" 
    mv projeto/$item projeto/tb
done