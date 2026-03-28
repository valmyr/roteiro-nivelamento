#!/usr/bin/bash

if [ -d "projeto/" ]; then
    echo "A pasta projeto ja existe"
else
    mkdir projeto
    sleep 1
    touch projeto/ula.v
    touch projeto/regfile.v
    touch projeto/top.v
    touch projeto/mux.v
    touch projeto/ula_tb.v
    touch projeto/defs.vh
    touch projeto/script.tcl
    touch projeto/sim.do
    touch projeto/README.md
fi