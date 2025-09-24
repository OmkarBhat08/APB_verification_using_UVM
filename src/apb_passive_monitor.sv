class apb_passive_monitor extends uvm_monitor;

	virtual apb_interfs vif;

	uvm_analysis_port #(apb_sequence_item) passive_item_port;
	bit rst_flag;

	apb_sequence_item apb_sequence_item_1;

	`uvm_component_utils(apb_passive_monitor)

	function new (string name = "apb_passive_monitor", uvm_component parent);
		super.new(name, parent);
		apb_sequence_item_1 = new();
		passive_item_port = new("passive_item_port", this);
		rst_flag = 0;
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		if(!uvm_config_db#(virtual apb_interfs)::get(this, "", "vif", vif))
			`uvm_fatal("NOVIF",{"virtual interface must be set for: ",get_full_name(),".vif"});
	endfunction

	virtual task run_phase(uvm_phase phase);
		forever 
		begin
			/*
			if(rst_flag ==1)
     		repeat(4)@(vif.monitor_cb);
			else
				*/
     		repeat(3)@(vif.monitor_cb);
			apb_sequence_item_1.PSLVERR = vif.PSLVERR;
			apb_sequence_item_1.apb_read_data_out = vif.apb_read_data_out;

			if(vif.PRESETn == 1)
				rst_flag = 1;
			else
				rst_flag = 0;
			passive_item_port.write(apb_sequence_item_1);
      $display("---------------------------Passive Monitor @%0d-----------------------------------",$time);
			apb_sequence_item_1.print();
		end
	endtask
endclass
