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
