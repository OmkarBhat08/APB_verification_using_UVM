coverage_it: simulate_it
	vcover report -html coverage.ucdb -htmldir covReport -details

simulate_it: compile 
	vsim -vopt work.first -voptargs=+acc=npr -assertdebug -l *.log -coverage -c -do "coverage save -onexit -assert -directive -cvg -codeAll coverage.ucdb; run -all; exit"

compile:
	vlog top.sv +incdir+/tools/mentor/questasim_10.6c/questasim/uvm-1.1d/../verilog_src/uvm-1.1d/src

clean:
	rm -rf work/	 
	rm  dump.vcd top.log transcript
