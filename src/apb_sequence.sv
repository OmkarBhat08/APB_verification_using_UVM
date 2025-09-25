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
// Transfer = 0
//------------------------------------------------------------------------------------------------------
class transfer0_sequence extends uvm_sequence #(apb_sequence_item); 
	`uvm_object_utils(transfer0_sequence)

	function new(string name = "transfer0_sequence");
		super.new(name);
	endfunction

	virtual task body();
		`uvm_do_with(req,{req.PRESETn == 1; req.transfer == 0; req.READ_WRITE == 0; req.apb_write_paddr == 9'b100001000;});
		`uvm_do_with(req,{req.PRESETn == 1; req.transfer == 0; req.READ_WRITE == 1;  req.apb_read_paddr == 9'b100001000;});
	endtask
endclass
//------------------------------------------------------------------------------------------------------
// Normal operation slave 0
//------------------------------------------------------------------------------------------------------
class slave0_sequence extends uvm_sequence #(apb_sequence_item); 
	`uvm_object_utils(slave0_sequence)

	function new(string name = "slave0_sequence");
		super.new(name);
	endfunction

	virtual task body();
      `uvm_do_with(req,{req.PRESETn == 1; req.transfer == 1; req.READ_WRITE == 0; req.apb_write_paddr == 9'b000001000;});
      `uvm_do_with(req,{req.PRESETn == 1; req.transfer == 1; req.READ_WRITE == 1;  req.apb_read_paddr == 9'b000001000;});
	endtask
endclass
//------------------------------------------------------------------------------------------------------
// RESET sequence
//------------------------------------------------------------------------------------------------------
class reset_sequence extends uvm_sequence #(apb_sequence_item); 
	`uvm_object_utils(reset_sequence)

	function new(string name = "reset_sequence");
		super.new(name);
	endfunction

	virtual task body();
	`uvm_do_with(req,{req.PRESETn == 0; req.transfer == 0;});
	endtask
endclass
//------------------------------------------------------------------------------------------------------
// Random sequence
//------------------------------------------------------------------------------------------------------
class random_sequence extends uvm_sequence #(apb_sequence_item); 
	`uvm_object_utils(random_sequence)

	function new(string name = "random_sequence");
		super.new(name);
	endfunction

	virtual task body();
		 repeat(100)
			`uvm_do_with(req,{req.PRESETn == 1; req.transfer == 1;});
	endtask
endclass
//------------------------------------------------------------------------------------------------------
// Normal operation slave 1
//------------------------------------------------------------------------------------------------------
class slave1_sequence extends uvm_sequence #(apb_sequence_item); 
	`uvm_object_utils(slave1_sequence)

	function new(string name = "slave1_sequence");
		super.new(name);
	endfunction

	virtual task body();
      `uvm_do_with(req,{req.PRESETn == 1; req.transfer == 1; req.READ_WRITE == 0; req.apb_write_paddr == 9'b100011000;});
      `uvm_do_with(req,{req.PRESETn == 1; req.transfer == 1; req.READ_WRITE == 1;  req.apb_read_paddr == 9'b100011000;});
	endtask
endclass
//------------------------------------------------------------------------------------------------------
// Non byte aligned
//------------------------------------------------------------------------------------------------------
class align_sequence extends uvm_sequence #(apb_sequence_item); 
	`uvm_object_utils(align_sequence)

	function new(string name = "align_sequence");
		super.new(name);
	endfunction

	virtual task body();
      `uvm_do_with(req,{req.PRESETn == 1; req.transfer == 1; req.READ_WRITE == 0; req.apb_write_paddr == 9'b100011001;});
      `uvm_do_with(req,{req.PRESETn == 1; req.transfer == 1; req.READ_WRITE == 1;  req.apb_read_paddr == 9'b100011001;});
	endtask
endclass
//------------------------------------------------------------------------------------------------------
// Back to back to same slave 0
//------------------------------------------------------------------------------------------------------
class b2bsame extends uvm_sequence #(apb_sequence_item); 
	`uvm_object_utils(b2bsame)

	function new(string name = "b2bsame");
		super.new(name);
	endfunction

	virtual task body();
      `uvm_do_with(req,{req.PRESETn == 1; req.transfer == 1; req.READ_WRITE == 0; req.apb_write_paddr == 9'b000011100;});
      `uvm_do_with(req,{req.PRESETn == 1; req.transfer == 1; req.READ_WRITE == 0; req.apb_write_paddr == 9'b000011110;});
      `uvm_do_with(req,{req.PRESETn == 1; req.transfer == 1; req.READ_WRITE == 1; req.apb_read_paddr == 9'b000011100;});
      `uvm_do_with(req,{req.PRESETn == 1; req.transfer == 1; req.READ_WRITE == 1; req.apb_read_paddr == 9'b000011110;});
	endtask
endclass
//------------------------------------------------------------------------------------------------------
// Back to back to different slaves
//------------------------------------------------------------------------------------------------------
class b2bdiff extends uvm_sequence #(apb_sequence_item); 
	`uvm_object_utils(b2bdiff)

	function new(string name = "b2bdiff");
		super.new(name);
	endfunction

	virtual task body();
      `uvm_do_with(req,{req.PRESETn == 1; req.transfer == 1; req.READ_WRITE == 0; req.apb_write_paddr == 9'b000011100;});
      `uvm_do_with(req,{req.PRESETn == 1; req.transfer == 1; req.READ_WRITE == 0; req.apb_write_paddr == 9'b000011110;});
      `uvm_do_with(req,{req.PRESETn == 1; req.transfer == 1; req.READ_WRITE == 1; req.apb_read_paddr == 9'b000011100;});
      `uvm_do_with(req,{req.PRESETn == 1; req.transfer == 1; req.READ_WRITE == 1; req.apb_read_paddr == 9'b000011110;});
	endtask
endclass
//------------------------------------------------------------------------------------------------------
// TO make SLVERR high
//------------------------------------------------------------------------------------------------------
class slave_err extends uvm_sequence #(apb_sequence_item); 
	`uvm_object_utils(slave_err)

	function new(string name = "slave_err");
		super.new(name);
	endfunction

	virtual task body();
			req = apb_sequence_item::type_id::create("req");
			wait_for_grant();
			req.randomize();
			req.apb_write_data = 8'bx;
			req.PRESETn = 'd1;
			req.transfer = 'd1;
			req.READ_WRITE = 'd0;
			send_request(req);
			wait_for_item_done();
	endtask
endclass
//------------------------------------------------------------------------------------------------------
// TO make SLVERR high when transfer is 0
//------------------------------------------------------------------------------------------------------
class slave_err2 extends uvm_sequence #(apb_sequence_item); 
	`uvm_object_utils(slave_err2)

	function new(string name = "slave_err2");
		super.new(name);
	endfunction

	virtual task body();
			req = apb_sequence_item::type_id::create("req");
			wait_for_grant();
			req.randomize();
			req.apb_write_data = 8'bx;
			req.PRESETn = 'd1;
			req.transfer = 'd0;
			req.READ_WRITE = 'd0;
			send_request(req);
			wait_for_item_done();
	endtask
endclass
//------------------------------------------------------------------------------------------------------
// TO make SLVERR high and coverage
//------------------------------------------------------------------------------------------------------
class slave_err1 extends uvm_sequence #(apb_sequence_item); 
	`uvm_object_utils(slave_err1)

	function new(string name = "slave_err1");
		super.new(name);
	endfunction

	virtual task body();
			req = apb_sequence_item::type_id::create("req");
			wait_for_grant();
			req.randomize();
			req.apb_write_data = 8'bx;
			req.PRESETn = 'd1;
			req.transfer = 'd1;
			req.READ_WRITE = 'd1;
			send_request(req);
			wait_for_item_done();
	endtask
endclass
//------------------------------------------------------------------------------------------------------
// Read_addr is X
//------------------------------------------------------------------------------------------------------
class read_addr_x extends uvm_sequence #(apb_sequence_item); 
	`uvm_object_utils(read_addr_x)

	function new(string name = "read_addr_x");
		super.new(name);
	endfunction

	virtual task body();
		repeat(5)
		begin
			req = apb_sequence_item::type_id::create("req");
			wait_for_grant();
			req.randomize();
			req.apb_read_paddr = 'bx;
			req.PRESETn = 'd1;
			req.transfer = 'd1;
			send_request(req);
			wait_for_item_done();
		end
	endtask
endclass
//------------------------------------------------------------------------------------------------------
// write_addr is X
//------------------------------------------------------------------------------------------------------
class write_addr_x extends uvm_sequence #(apb_sequence_item); 
	`uvm_object_utils(write_addr_x)

	function new(string name = "write_addr_x");
		super.new(name);
	endfunction

	virtual task body();
		repeat(5)
		begin
			req = apb_sequence_item::type_id::create("req");
			wait_for_grant();
			req.randomize();
			req.apb_write_paddr = 'bx;
			req.PRESETn = 'd1;
			req.transfer = 'd1;
			send_request(req);
			wait_for_item_done();
		end
	endtask
endclass
//------------------------------------------------------------------------------------------------------
// Out of range access
//------------------------------------------------------------------------------------------------------
class out_range_access extends uvm_sequence #(apb_sequence_item); 
	`uvm_object_utils(out_range_access)

	function new(string name = "out_range_access");
		super.new(name);
	endfunction

	virtual task body();
      `uvm_do_with(req,{req.PRESETn == 1; req.transfer == 1; req.READ_WRITE == 0; req.apb_write_paddr == 9'b001111000;});
      `uvm_do_with(req,{req.PRESETn == 1; req.transfer == 1; req.READ_WRITE == 1; req.apb_read_paddr == 9'b001111000;});
	endtask
endclass
//------------------------------------------------------------------------------------------------------
// Regression
//------------------------------------------------------------------------------------------------------
class regression_sequence extends uvm_sequence #(apb_sequence_item); 

	`uvm_object_utils(regression_sequence)

	reset_sequence rst_seq;	
	random_sequence rand_seq;	
	transfer0_sequence transfer_seq;
	slave0_sequence slv0_seq;
	slave1_sequence slv1_seq;
	align_sequence align_seq;
	b2bsame b2bsame_seq;
	b2bdiff b2bdiff_seq;
	slave_err slav_err_seq;
	slave_err2 slav_err2_seq;
	slave_err1 slav1_err_seq;
	out_range_access out_range_access_seq;
	read_addr_x read_addr_x_seq;
	write_addr_x write_addr_x_seq;
  
	function new(string name = "regression_sequence");
		super.new(name);
	endfunction

	virtual task body();
		`uvm_do(rst_seq);
		`uvm_do(transfer_seq);
		`uvm_do(rand_seq);
		`uvm_do(slv0_seq);
		`uvm_do(slv1_seq);
		`uvm_do(rst_seq);
		`uvm_do(align_seq);
		`uvm_do(b2bsame_seq);
		`uvm_do(b2bdiff_seq);
		`uvm_do(out_range_access_seq);

		// For coverage
		`uvm_do(slav_err_seq);
		`uvm_do(slav_err2_seq);
		`uvm_do(slav1_err_seq);
		`uvm_do(read_addr_x_seq);
		`uvm_do(write_addr_x_seq);
	endtask
endclass
