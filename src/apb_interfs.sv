interface apb_interfs(input bit PCLK);
	logic transfer, READ_WRITE, PRESETn;
	logic [8:0] apb_write_paddr;
	logic [7:0] apb_write_data;
	logic [8:0] apb_read_paddr;

	logic PSLVERR;
	logic [7:0] apb_read_data_out;

	clocking driver_cb@(posedge PCLK);
		default input #0 output #0;
		output PRESETn;
		output transfer, READ_WRITE;
		output apb_write_paddr, apb_write_data, apb_read_paddr;
	endclocking

	clocking monitor_cb@(posedge PCLK);                                                                                  
		default input #0 output #0;
		input PRESETn;
		input transfer, READ_WRITE;
		input apb_write_paddr, apb_write_data, apb_read_paddr;
		input PSLVERR, apb_read_data_out;
	endclocking

	modport DRIVER (clocking driver_cb, input PCLK);
	modport MONITOR (clocking monitor_cb, input PCLK);

endinterface
