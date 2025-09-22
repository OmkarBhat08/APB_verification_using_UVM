coverage: simulate
	vcover report -html coverage.ucdb -htmldir covReport -details

simulate: compile 
	vsim -c top +UVM_VERBOSITY=UVM_MEDIUM -do "run -all;exit"

compile:
	clear
	clear
	vlog top.sv +incdir+/tools/mentor/questasim_10.6c/questasim/uvm-1.1d/../verilog_src/uvm-1.1d/src

clean:
	rm -rf work/	 
	rm  dump.vcd transcript
	clear
	clear
