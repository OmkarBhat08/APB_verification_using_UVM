`include "uvm_macros.svh"
import uvm_pkg ::*;

class apb_sequence_item extends uvm_sequence_item;

	rand bit transfer;
	rand bit READ_WRITE;
	rand bit [8:0]apb_write_paddr;
	rand bit [7:0]apb_write_data;
	rand bit [8:0]apb_read_paddr;

	logic [7:0]apb_read_data_out;
	logic PSLVERR;

	`uvm_object_utils_begin(apb_sequence_item)
		`uvm_field_int(transfer, UVM_ALL_ON)
		`uvm_field_int(READ_WRITE, UVM_ALL_ON)
		`uvm_field_int(apb_write_paddr, UVM_ALL_ON)
		`uvm_field_int(apb_read_paddr, UVM_ALL_ON)
  `uvm_field_int(apb_write_data, UVM_ALL_ON | UVM_DEC)
		`uvm_field_int(apb_read_data_out, UVM_ALL_ON | UVM_DEC)
		`uvm_field_int(PSLVERR, UVM_ALL_ON)
	`uvm_object_utils_end

	function new(string name = "apb_sequence_item");
		super.new(name);
	endfunction

endclass
