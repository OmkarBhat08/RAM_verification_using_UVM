class ram_environment extends uvm_env;
	ram_agent agent;
	ram_scoreboard scbrd;
	//for coverage

	`uvm_component_utils(ram_environment)

	function new(string name = "ram_environment", uvm_component parent = null);
		super.new(name, parent);
	endfunction

	function void build_phase(uvm_phase phase);
		super.new(name, parent);
		agent = ram_agent::type_id::create("agent",this);
		scbd = ram_scoreboard::type_id::create("scbd",this);
	//for coverage
	endfunction

	function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
		agent.mon.item_collected_port.connect(scbd.item_collected_port);
		agent.mon.item_collected_port.connect(scbd.);	//Finish these
		agent.drv.item_collected_port.connect(scbd.);	// Finish these
	endfunction
endclass
