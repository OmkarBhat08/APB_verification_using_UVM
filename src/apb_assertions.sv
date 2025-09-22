program apb_assertions(PCLK, PRESETn, transfer, READ_WRITE, apb_write_paddr, apb_write_data, apb_read_paddr, PSLVERR, apb_read_data_out);
	input PCLK, PRESETn, transfer, READ_WRITE, PSLVERR;
	input [8:0] apb_write_paddr;
	input [7:0] apb_write_data;
	input [8:0] apb_read_paddr;
	input [7:0] apb_read_data_out;	

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
endprogram
