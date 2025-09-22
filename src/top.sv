`include "defines.svh"
`include "apb_interfs.sv"
`include "apb_pkg.sv"
`include "apb_design.sv"
`include "apb_assertions.sv"

import uvm_pkg::*;
import apb_pkg::*;

module top();
	bit PCLK;

	apb_interfs vif(PCLK);

	APB_Protocol DUT(
		.PCLK(PCLK),
		.PRESETn(vif.PRESETn),
		.transfer(vif.transfer),
		.READ_WRITE(vif.READ_WRITE),
		.apb_write_paddr(vif.apb_write_paddr),
		.apb_write_data(vif.apb_write_data),
		.apb_read_paddr(vif.apb_read_paddr),
		.PSLVERR(vif.PSLVERR),
		.apb_read_data_out(vif.apb_read_data_out)
	);

	bind vif apb_assertions ASSERTION (.*);
	always
		#5 PCLK = ~PCLK;

	initial
	begin
		PCLK = 0;
		uvm_config_db #(virtual apb_interfs)::set(uvm_root::get(),"*","vif",vif);

		$dumpfile("dump.vcd");
		$dumpvars;
	end

	initial
	begin
		run_test("regression_test");
		$finish;
	end
endmodule
