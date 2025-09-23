`uvm_analysis_imp_decl(_inp_cg)
`uvm_analysis_imp_decl(_out_cg)

class apb_subscriber extends uvm_component;

  uvm_analysis_imp_inp_cg #(apb_sequence_item, apb_subscriber) aport_inputs;
  uvm_analysis_imp_out_cg #(apb_sequence_item, apb_subscriber) aport_outputs;

  apb_sequence_item trans_inp, trans_out;
  real inp_cov, out_cov;

  `uvm_component_utils(apb_subscriber)

  covergroup input_cov;
    reset: coverpoint trans_inp.PRESETn;
    transfer: coverpoint trans_inp.transfer;
    read_write: coverpoint trans_inp.READ_WRITE iff(trans_inp.transfer == 1);
		write_data: coverpoint trans_inp.apb_write_data {bins w_range0 = {[0:50]};
			                                        bins w_range1 = {[51:100]};
			                                        bins w_range2 = {[101:150]};
			                                        bins w_range3 = {[151:200]};
			                                        bins w_range4 = {[201:255]};
			                                        }
  endgroup

  covergroup output_cov;
    error: coverpoint trans_out.PSLVERR;
		read_data: coverpoint trans_out.apb_read_data_out {bins r_range0 = {[0:50]};
			                                        bins r_range1 = {[51:100]};
			                                        bins r_range2 = {[101:150]};
			                                        bins r_range3 = {[151:200]};
			                                        bins r_range4 = {[201:255]};
			                                        }
  endgroup

  function new(string name = "apb_subscriber", uvm_component parent = null);
    super.new(name, parent);
    input_cov = new();
    output_cov = new();
    aport_inputs = new("aport_inputs", this);
    aport_outputs = new("aport_outputs", this);
  endfunction

  function void write_inp_cg(apb_sequence_item t);
    trans_inp = t;
    input_cov.sample();
    `uvm_info(get_type_name,$sformatf("transfer=%b | read_write = %b",trans_inp.transfer,trans_inp.READ_WRITE), UVM_MEDIUM);
  endfunction

  function void write_out_cg(apb_sequence_item t);
    trans_out = t;
    output_cov.sample();
    `uvm_info(get_type_name,$sformatf("PSLVERR=%b",trans_out.PSLVERR), UVM_MEDIUM);
  endfunction

  function void extract_phase(uvm_phase phase);
    super.extract_phase(phase);
    inp_cov = input_cov.get_coverage();
    out_cov = output_cov.get_coverage();
  endfunction
 
	function void report_phase(uvm_phase phase);
    super.report_phase(phase);
    `uvm_info(get_type_name(), $sformatf("[Input]: Coverage --> %0.2f", inp_cov), UVM_MEDIUM);
    `uvm_info(get_type_name(), $sformatf("[Output]: Coverage --> %0.2f", out_cov), UVM_MEDIUM);
  endfunction
endclass
