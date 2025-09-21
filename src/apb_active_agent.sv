class apb_active_agent extends uvm_agent;
	apb_driver apb_driver_1;
	apb_sequencer apb_sequencer_1;
	apb_active_monitor apb_active_monitor_1;

	`uvm_component_utils(apb_active_agent)

	function new (string name = "apb_active_agent", uvm_component parent);
		super.new(name, parent);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		apb_driver_1 = apb_driver::type_id::create("apb_driver_1", this);
		apb_sequencer_1 = apb_sequencer::type_id::create("apb_sequencer_1", this);
		apb_active_monitor_1 = apb_active_monitor::type_id::create("apb_active_monitor_1", this);
	endfunction

	function void connect_phase(uvm_phase phase);
		apb_driver_1.seq_item_port.connect(apb_sequencer_1.seq_item_export);
	endfunction
endclass
