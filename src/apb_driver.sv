class apb_driver extends uvm_driver #(apb_sequence_item);

	virtual apb_interfs vif;
	apb_sequence_item seq;

	`uvm_component_utils(apb_driver)

	function new(string name = "apb_driver", uvm_component parent);
		super.new(name, parent);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		if(!uvm_config_db#(virtual apb_interfs)::get(this,"","vif", vif))
			`uvm_error(get_type_name(), $sformatf("Failed to get VIF"))
	endfunction

	virtual task run_phase(uvm_phase phase);
		forever 
		begin
			seq_item_port.get_next_item(seq);
			drive();
			seq_item_port.item_done();
		end
	endtask

	virtual task drive();
		vif.driver_cb.transfer <= seq.transfer;
		vif.driver_cb.READ_WRITE <= seq.READ_WRITE;
		vif.driver_cb.apb_write_paddr <= seq.apb_write_paddr;
		vif.driver_cb.apb_read_paddr <= seq.apb_read_paddr;
		vif.driver_cb.apb_write_data <= seq.apb_write_data;
		`uvm_info(get_type_name(), $sformatf("DRIVER: transfer = %0d, READ_WRITE = %0d, apb_write_paddr = %0h, apb_write_data = %0d, apb_read_paddr = %0h", vif.driver_cb.transfer, vif.driver_cb.READ_WRITE, vif.driver_cb.apb_write_paddr, vif.driver_cb.apb_write_data, vif.driver_cb.apb_read_paddr), UVM_MEDIUM)
		repeat(4) @(vif.driver_cb);
	endtask
endclass
