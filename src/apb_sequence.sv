`include "defines.svh"

class apb_sequence extends uvm_sequence #(apb_sequence_item);

	`uvm_object_utils(apb_sequence)

	apb_sequence_item seq_item;

	function new(string name = "apb_sequence");
		super.new(name);
	endfunction

	virtual task body();
			req = apb_sequence_item::type_id::create("req");
			wait_for_grant();
			req.randomize();
			send_request(req);
			wait_for_item_done();
		endtask
endclass

//------------------------------------------------------------------------------------------------------
class write_sequence extends uvm_sequence #(apb_sequence_item); 
	`uvm_object_utils(write_sequence)

	function new(string name = "write_sequence");
		super.new(name);
	endfunction

	virtual task body();
		`uvm_do_with(req,{req.transfer == 1; req.READ_WRITE == 1; req.apb_write_paddr == 9'b000000010;});
		//`uvm_info(get_type_name(), $sformatf("SEQUENCE GENERATED: transfer = %0d, READ_WRITE = %0d, apb_write_paddr = %0h, apb_write_data = %0d, apb_read_paddr = %0h", seq_item.transfer, seq_item.READ_WRITE, seq_item.apb_write_paddr, seq_item.apb_write_data, seq_item.apb_read_paddr), UVM_MEDIUM)
	endtask
endclass
//------------------------------------------------------------------------------------------------------
class read_sequence extends uvm_sequence #(apb_sequence_item); 
	`uvm_object_utils(read_sequence)

	function new(string name = "read_sequence");
		super.new(name);
	endfunction

	virtual task body();
		`uvm_do_with(req,{req.transfer == 1; req.READ_WRITE == 0; req.apb_read_paddr == 9'b000000010;});
		//`uvm_info(get_type_name(), $sformatf("SEQUENCE GENERATED: transfer = %0d, READ_WRITE = %0d, apb_write_paddr = %0h, apb_write_data = %0d, apb_read_paddr = %0h", seq_item.transfer, seq_item.READ_WRITE, seq_item.apb_write_paddr, seq_item.apb_write_data, seq_item.apb_read_paddr), UVM_MEDIUM)
	endtask
endclass
//------------------------------------------------------------------------------------------------------
class regression_sequence extends uvm_sequence #(apb_sequence_item); 
	`uvm_object_utils(regression_sequence)

	write_sequence wr_seq;
	read_sequence rd_seq;

	function new(string name = "regression_sequence");
		super.new(name);
	endfunction

	virtual task body();
		`uvm_do(wr_seq);
		`uvm_do(rd_seq);
	endtask
endclass
 
