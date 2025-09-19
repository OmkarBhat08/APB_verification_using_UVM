class apb_passive_agent extends uvm_agent;
	apb_passive_monitor   apb_passive_monitor_1;

	`uvm_component_utils(apb_passive_agent)

	function new (string name = "apb_passive_agent", uvm_component parent);
		super.new(name, parent);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		apb_passive_monitor_1 = apb_passive_monitor::type_id::create("apb_passive_monitor_1", this);
	endfunction
endclass
