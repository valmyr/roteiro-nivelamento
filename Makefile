all:report file_generator file_organizer
report:
	tclsh relatorio_completo.tcl
file_generator:
	bash ./roteiro_shell/file_gen.sh

file_organizer:
	bash ./roteiro_shell/file_sorted.sh

clean:
	bash ./roteiro_shell/clear.sh