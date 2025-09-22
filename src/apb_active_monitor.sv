class apb_active_monitor extends uvm_monitor;

	virtual apb_interfs vif;

	uvm_analysis_port #(apb_sequence_item) active_item_port;

	apb_sequence_item apb_sequence_item_1;

	`uvm_component_utils(apb_active_monitor)

	function new (string name = "apb_active_monitor", uvm_component parent);
		super.new(name, parent);
		apb_sequence_item_1 = new();
		active_item_port = new("active_item_port", this);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		if(!uvm_config_db#(virtual apb_interfs)::get(this, "", "vif", vif))
			`uvm_fatal("NOVIF",{"virtual interface must be set for: ",get_full_name(),".vif"});
	endfunction

	virtual task run_phase(uvm_phase phase);
    repeat(1)@(vif.monitor_cb);
		forever 
		begin
      repeat(1)@(vif.monitor_cb);
			//apb_sequence_item_1.PRESETn = vif.PRESETn;
			apb_sequence_item_1.transfer = vif.transfer;
			apb_sequence_item_1.READ_WRITE = vif.READ_WRITE;
			apb_sequence_item_1.apb_write_paddr = vif.apb_write_paddr;
			apb_sequence_item_1.apb_write_data = vif.apb_write_data;
			apb_sequence_item_1.apb_read_paddr = vif.apb_read_paddr;
          
      $display("---------------------------Active Monitor @%0d-----------------------------------",$time);
			apb_sequence_item_1.print();

			active_item_port.write(apb_sequence_item_1);
      repeat(2)@(vif.monitor_cb);
		end
	endtask
endclass
