class apb_env extends uvm_env;
  apb_active_agent apb_active_agent_1;
  apb_passive_agent apb_passive_agent_1;
  apb_scoreboard apb_scoreboard_1;
  apb_subscriber apb_subscriber_1;

  `uvm_component_utils(apb_env)

  function new(string name = "apb_env", uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    apb_active_agent_1 = apb_active_agent::type_id::create("apb_active_agent_1", this);
    apb_passive_agent_1 = apb_passive_agent::type_id::create("apb_passive_agent_1", this);
    apb_scoreboard_1 = apb_scoreboard::type_id::create("apb_scoreboard_1", this);
    apb_subscriber_1 = apb_subscriber::type_id::create("apb_subscriber_1", this);
  endfunction

  function void connect_phase(uvm_phase phase);
    apb_active_agent_1.apb_active_monitor_1.active_item_port.connect(apb_scoreboard_1.inputs_export);
    apb_passive_agent_1.apb_passive_monitor_1.passive_item_port.connect(apb_scoreboard_1.outputs_export);
    apb_active_agent_1.apb_active_monitor_1.active_item_port.connect(apb_subscriber_1.aport_inputs);
    apb_passive_agent_1.apb_passive_monitor_1.passive_item_port.connect(apb_subscriber_1.aport_outputs);
  endfunction
endclass
