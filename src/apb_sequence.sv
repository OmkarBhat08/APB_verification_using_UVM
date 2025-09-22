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
class reset_sequence extends uvm_sequence #(apb_sequence_item); 
	`uvm_object_utils(reset_sequence)

	function new(string name = "reset_sequence");
		super.new(name);
	endfunction

	virtual task body();
		`uvm_do_with(req,{req.PRESETn == 0; req.transfer == 1;});
	endtask
endclass
//------------------------------------------------------------------------------------------------------
class random_sequence extends uvm_sequence #(apb_sequence_item); 
	`uvm_object_utils(random_sequence)

	function new(string name = "random_sequence");
		super.new(name);
	endfunction

	virtual task body();
		`uvm_do_with(req,{req.PRESETn == 1; req.transfer == 0;req.READ_WRITE == 1;});
	endtask
endclass
//------------------------------------------------------------------------------------------------------
class transfer_sequence1 extends uvm_sequence #(apb_sequence_item); 
	`uvm_object_utils(transfer_sequence1)

	function new(string name = "transfer_sequence1");
		super.new(name);
	endfunction

	virtual task body();
		`uvm_do_with(req,{req.PRESETn == 1; req.transfer == 1; req.READ_WRITE == 0; req.apb_write_paddr == 9'b000001000;});
	endtask
endclass
//------------------------------------------------------------------------------------------------------
class transfer_sequence2 extends uvm_sequence #(apb_sequence_item); 
	`uvm_object_utils(transfer_sequence2)

	function new(string name = "transfer_sequence1");
		super.new(name);
	endfunction

	virtual task body();
	`uvm_do_with(req,{req.PRESETn == 1; req.transfer == 1; req.READ_WRITE == 1;  req.apb_read_paddr == 9'b000001000;});
	endtask
endclass
//------------------------------------------------------------------------------------------------------
class write_sequence1 extends uvm_sequence #(apb_sequence_item); 
	`uvm_object_utils(write_sequence1)

	function new(string name = "write_sequence1");
		super.new(name);
	endfunction

	virtual task body();
      `uvm_do_with(req,{req.PRESETn == 1; req.transfer == 0; req.READ_WRITE == 0; req.apb_write_paddr == 9'b000001000;});
	endtask
endclass
//------------------------------------------------------------------------------------------------------
class read_sequence1 extends uvm_sequence #(apb_sequence_item); 
	`uvm_object_utils(read_sequence1)

	function new(string name = "read_sequence1");
		super.new(name);
	endfunction

	virtual task body();
      `uvm_do_with(req,{req.PRESETn == 1; req.transfer == 0; req.READ_WRITE == 1;  req.apb_read_paddr == 9'b000001000;});
	endtask
endclass
//------------------------------------------------------------------------------------------------------
class write_sequence2 extends uvm_sequence #(apb_sequence_item); 
	`uvm_object_utils(write_sequence2)

	function new(string name = "write_sequence2");
		super.new(name);
	endfunction

	virtual task body();
      `uvm_do_with(req,{req.PRESETn == 1; req.transfer == 1; req.READ_WRITE == 0; req.apb_write_paddr == 9'b100011000;});
	endtask
endclass
//------------------------------------------------------------------------------------------------------
class read_sequence2 extends uvm_sequence #(apb_sequence_item); 
	`uvm_object_utils(read_sequence2)

	function new(string name = "read_sequence2");
		super.new(name);
	endfunction

	virtual task body();
      `uvm_do_with(req,{req.PRESETn == 1; req.transfer == 1; req.READ_WRITE == 1;  req.apb_read_paddr == 9'b100011000;});
	endtask
endclass
//------------------------------------------------------------------------------------------------------
class regression_sequence extends uvm_sequence #(apb_sequence_item); 
	`uvm_object_utils(regression_sequence)
	reset_sequence rst_seq;	
	random_sequence rand_seq;	
	transfer_sequence1 tr1_seq;
	transfer_sequence2 tr2_seq;
	write_sequence1 wr_seq1;
	read_sequence1 rd_seq1;
	write_sequence2 wr_seq2;
	read_sequence2 rd_seq2;

	function new(string name = "regression_sequence");
		super.new(name);
	endfunction

	virtual task body();
		`uvm_do(rst_seq);
		`uvm_do(rand_seq);
		`uvm_do(tr1_seq);
		`uvm_do(tr2_seq);
		`uvm_do(wr_seq1);
		`uvm_do(rd_seq1);
		`uvm_do(wr_seq2);
		`uvm_do(rd_seq2);
	endtask
endclass
