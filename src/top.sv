`include "defines.svh"
`include "apb_interfs.sv"
`include "apb_pkg.sv"
`include "apb_protocol.v"
//`include "uvm_macros.svh"

import uvm_pkg::*;
import apb_pkg::*;

module top();
	bit PCLK, PRESETn;

	apb_interfs vif(PCLK, PRESETn);

	APB_Protocol DUT(
		.PCLK(PCLK),
		.PRESETn(PRESETn),
		.transfer(vif.transfer),
		.READ_WRITE(vif.READ_WRITE),
		.apb_write_paddr(vif.apb_write_paddr),
		.apb_write_data(vif.apb_write_data),
		.apb_read_paddr(vif.apb_read_paddr),
		.PSLVERR(vif.PSLVERR),
		.apb_read_data_out(vif.apb_read_data_out)
	);

	always
		#5 PCLK = ~PCLK;

	initial
	begin
		PCLK = 1;
		PRESETn = 1;
		//#20 PRESETn = 0;
	end

	initial
	begin
		uvm_config_db #(virtual apb_interfs)::set(uvm_root::get(),"*","vif",vif);

		$dumpfile("dump.vcd");
		$dumpvars;
	end

	initial
	begin
		run_test("regression_test");
		#100 $finish;
	end
endmodule
