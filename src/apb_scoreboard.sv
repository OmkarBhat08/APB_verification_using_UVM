`uvm_analysis_imp_decl(_from_inp)
`uvm_analysis_imp_decl(_from_out)

class apb_scoreboard extends uvm_scoreboard();

	bit [7:0] mem1 [127:0];
	bit [7:0] mem2 [127:0];

	uvm_analysis_imp_from_inp #(apb_sequence_item, apb_scoreboard) inputs_export;
	uvm_analysis_imp_from_out #(apb_sequence_item, apb_scoreboard) outputs_export;

	apb_sequence_item input_packet[$];

	apb_sequence_item output_packet[$];

	`uvm_component_utils(apb_scoreboard)

	function new(string name = "apb_scoreboard", uvm_component parent = null);
		super.new(name, parent);
		inputs_export = new("inputs_export", this);
		outputs_export = new("outputs_export", this);
	endfunction

	virtual function void write_from_inp(apb_sequence_item t);
		`uvm_info(get_type_name,"Scoreboard received input packet", UVM_NONE);
		input_packet.push_back(t);
	endfunction

	virtual function void write_from_out(apb_sequence_item u);
		`uvm_info(get_type_name,"Scoreboard received output packet", UVM_NONE);
		output_packet.push_back(u);
	endfunction

	virtual task run_phase(uvm_phase phase);
		apb_sequence_item packet1;
		apb_sequence_item packet2;
		super.run_phase(phase);
		forever
		begin

			wait((input_packet.size() > 0) && (output_packet.size() > 0));
			begin
				packet1 = input_packet.pop_front();
				packet2 = output_packet.pop_front();
			end
			// Writing or reading
      if(packet1.READ_WRITE == 0)  // Write
			begin
				if(packet1.apb_write_paddr[8])
					mem2[packet1.apb_write_paddr[7:0]] = packet1.apb_write_data;
				else
					mem1[packet1.apb_write_paddr[7:0]] = packet1.apb_write_data;
			end
			else  //Read and compare
			begin
				if(packet1.apb_write_paddr[8])
				begin
					if(packet2.apb_read_data_out === mem2[packet1.apb_read_paddr])
					begin
				$display("memory2 value = %0d", mem2[packet1.apb_read_paddr]);
						$display("------------------------------------------------------------------------------");
						$display("                TEST PASSED                                 ");
						$display("------------------------------------------------------------------------------");
					end
					else
					begin
				$display("memory2 value = %0d", mem2[packet1.apb_read_paddr]);
						$display("------------------------------------------------------------------------------");
						$display("                TEST FAILED                                 ");
						$display("------------------------------------------------------------------------------");
					end
				end
				else
				begin
					if(packet2.apb_read_data_out === mem1[packet1.apb_read_paddr])
					begin
				$display("memory1 value = %0d", mem1[packet1.apb_read_paddr]);
						$display("------------------------------------------------------------------------------");
						$display("                TEST PASSED                                 ");
						$display("------------------------------------------------------------------------------");
					end
					else
					begin
				$display("memory1 value = %0d", mem1[packet1.apb_read_paddr]);
						$display("------------------------------------------------------------------------------");
						$display("                TEST FAILED                                 ");
						$display("------------------------------------------------------------------------------");
					end
				end
			end
		end
	endtask
endclass
