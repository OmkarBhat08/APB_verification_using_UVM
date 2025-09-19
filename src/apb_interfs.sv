interface apb_interfs(input bit PCLK, PRESETn);
	logic transfer, READ_WRITE;
	logic [8:0] apb_write_paddr;
	logic [7:0] apb_write_data;
	logic [8:0] apb_read_paddr;

	logic PSLVERR;
	logic [7:0] apb_read_data_out;

	clocking driver_cb@(posedge PCLK);
		default input #0 output #0;

		output transfer, READ_WRITE;
		output apb_write_paddr, apb_write_data, apb_read_paddr;
	endclocking

	clocking monitor_cb@(posedge PCLK);                                                                                           
		default input #0 output #0;

		input transfer, READ_WRITE;
		input apb_write_paddr, apb_write_data, apb_read_paddr;
		input PSLVERR, apb_read_data_out;
	endclocking

	modport DRIVER (clocking driver_cb, input PCLK, PRESETn);
	modport MONITOR (clocking monitor_cb, input PCLK, PRESETn);

	// *********************************************************************************************************
	//                                              Assertions

	property PRESETn_check;
		@(posedge PCLK) (!PRESETn) |=> (PSLVERR == 0) && (apb_read_data_out == 0);
	endproperty

	property transfer_check0;
		@(posedge PCLK) disable iff (!PRESETn)
			(!transfer) |=> ($stable(PSLVERR) && $stable(apb_read_data_out));
	endproperty

	property transfer_check1;
		@(posedge PCLK) disable iff (!PRESETn)
			$rose(transfer) |=> ##[1:2] ($stable(apb_write_paddr) && $stable(READ_WRITE) && $stable(apb_read_paddr));
	endproperty
endinterface
