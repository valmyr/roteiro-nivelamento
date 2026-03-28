#!/usr/bin/bash
verilog=($(cd projeto; ls )) #Parenteses antes do cifrão para converter em uma lista
src=($(cd projeto; ls *.v))
docs=($(cd projeto; ls *.txt *.md))
scripts=($(cd projeto; ls *.sh *.do *.tcl))
tb=($(cd projeto; ls *_tb.v))
include=($(cd projeto; ls *.vh))


pastas=("src/" "tb/" "include/" "scripts/" "docs/") #Lista de diretórios a ser esttruturado

for pasta in "${pastas[@]}"; do
    if [ -d "$pasta" ]; then
        echo "O diretório $pasta existe."  #Caso a pasta exista
    else
        echo "O diretório $pasta NÃO existe. Criando pasta: $pasta" #caso contrário
        mkdir projeto/$pasta #Crie o novo conjunto de pastas
    fi
done


for item in "${src[@]}"; do
    if [[ "$item" == *"_tb.v"* ]]; then
        echo "ignorando $item"
    else 
        echo "movendo $item -> src" 
        mv "projeto/$item" "projeto/src/"
    fi
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

