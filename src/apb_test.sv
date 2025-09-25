class apb_base_test extends uvm_test;
	apb_env env;

	`uvm_component_utils(apb_base_test)

	function new(string name = "apb_base_test", uvm_component parent = null);
	super.new(name, parent);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		env = apb_env::type_id::create("env", this);
	endfunction

	virtual function void end_of_elaboration();
		print();
	endfunction
endclass
//---------------------------------------------------------------------------------------------------------
class reset_test extends apb_base_test;
	`uvm_component_utils(reset_test)

	function new(string name = "reset_test", uvm_component parent = null);
		super.new(name, parent);
	endfunction

	virtual task run_phase(uvm_phase phase);
		reset_sequence seq;
		super.run_phase(phase);
		phase.raise_objection(this, "Objection Raised");
		seq = reset_sequence::type_id::create("seq");
		seq.start(env.apb_active_agent_1.apb_sequencer_1);
		phase.drop_objection(this, "Objection Dropped");
	endtask
endclass
//---------------------------------------------------------------------------------------------------------
class random_test extends apb_base_test;
	`uvm_component_utils(random_test)

	function new(string name = "random_test", uvm_component parent = null);
		super.new(name, parent);
	endfunction

	virtual task run_phase(uvm_phase phase);
		random_sequence seq;
		super.run_phase(phase);
		phase.raise_objection(this, "Objection Raised");
		seq = random_sequence::type_id::create("seq");
		seq.start(env.apb_active_agent_1.apb_sequencer_1);
		phase.drop_objection(this, "Objection Dropped");
	endtask
endclass
//---------------------------------------------------------------------------------------------------------
class transfer0_test extends apb_base_test;
	`uvm_component_utils(transfer0_test)

	function new(string name = "transfer0_test", uvm_component parent = null);
		super.new(name, parent);
	endfunction

	virtual task run_phase(uvm_phase phase);
		transfer0_sequence seq;
		super.run_phase(phase);
		phase.raise_objection(this, "Objection Raised");
		seq = transfer0_sequence::type_id::create("seq");
		seq.start(env.apb_active_agent_1.apb_sequencer_1);
		phase.drop_objection(this, "Objection Dropped");
	endtask
endclass
//---------------------------------------------------------------------------------------------------------
class slave0_test extends apb_base_test;
	`uvm_component_utils(slave0_test)

	function new(string name = "slave0_test", uvm_component parent = null);
		super.new(name, parent);
	endfunction

	virtual task run_phase(uvm_phase phase);
		slave0_sequence seq;
		super.run_phase(phase);
		phase.raise_objection(this, "Objection Raised");
		seq = slave0_sequence::type_id::create("seq");
		seq.start(env.apb_active_agent_1.apb_sequencer_1);
		phase.drop_objection(this, "Objection Dropped");
	endtask
endclass
//---------------------------------------------------------------------------------------------------------
class slave1_test extends apb_base_test;
	`uvm_component_utils(slave1_test)

	function new(string name = "slave1_test", uvm_component parent = null);
		super.new(name, parent);
	endfunction

	virtual task run_phase(uvm_phase phase);
		slave1_sequence seq;
		super.run_phase(phase);
		phase.raise_objection(this, "Objection Raised");
		seq = slave1_sequence::type_id::create("seq");
		seq.start(env.apb_active_agent_1.apb_sequencer_1);
		phase.drop_objection(this, "Objection Dropped");
	endtask
endclass
//---------------------------------------------------------------------------------------------------------
class align_test extends apb_base_test;
	`uvm_component_utils(align_test)

	function new(string name = "align_test", uvm_component parent = null);
		super.new(name, parent);
	endfunction

	virtual task run_phase(uvm_phase phase);
		align_sequence seq;
		super.run_phase(phase);
		phase.raise_objection(this, "Objection Raised");
		seq = align_sequence::type_id::create("seq");
		seq.start(env.apb_active_agent_1.apb_sequencer_1);
		phase.drop_objection(this, "Objection Dropped");
	endtask
endclass
//---------------------------------------------------------------------------------------------------------
class b2bsame_test extends apb_base_test;
	`uvm_component_utils(b2bsame_test)

	function new(string name = "b2bsame_test", uvm_component parent = null);
		super.new(name, parent);
	endfunction

	virtual task run_phase(uvm_phase phase);
		b2bsame seq;
		super.run_phase(phase);
		phase.raise_objection(this, "Objection Raised");
		seq = b2bsame::type_id::create("seq");
		seq.start(env.apb_active_agent_1.apb_sequencer_1);
		phase.drop_objection(this, "Objection Dropped");
	endtask
endclass
//---------------------------------------------------------------------------------------------------------
class b2bdiff_test extends apb_base_test;
	`uvm_component_utils(b2bdiff_test)

	function new(string name = "b2bdiff_test", uvm_component parent = null);
		super.new(name, parent);
	endfunction

	virtual task run_phase(uvm_phase phase);
		b2bdiff seq;
		super.run_phase(phase);
		phase.raise_objection(this, "Objection Raised");
		seq = b2bdiff::type_id::create("seq");
		seq.start(env.apb_active_agent_1.apb_sequencer_1);
		phase.drop_objection(this, "Objection Dropped");
	endtask
endclass
//---------------------------------------------------------------------------------------------------------
class regression_test extends apb_base_test;
	`uvm_component_utils(regression_test)

	function new(string name = "regression_test", uvm_component parent = null);
		super.new(name, parent);
	endfunction

	virtual task run_phase(uvm_phase phase);
		regression_sequence seq;
		super.run_phase(phase);
		phase.raise_objection(this, "Objection Raised");
		repeat(100)
		begin
			seq = regression_sequence::type_id::create("seq");
			seq.start(env.apb_active_agent_1.apb_sequencer_1);
		end
		phase.drop_objection(this, "Objection Dropped");
	endtask

	virtual function void end_of_elaboration();
		print();
	endfunction
endclass
