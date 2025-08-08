class ram_environment extends uvm_env;
	ram_agent agent;
	ram_scoreboard scbrd;

	`uvm_component_utils(ram_environment)

	function new(string name = "ram_environment", uvm_component parent = null);
		super.new(name, parent);
	endfunction

	function void build_phase(uvm_phase phase);
		super.new(name, parent);
		agent = ram_agent::type_id::create("agent",this);
		scbd = ram_scoreboard::type_id::create("scbd",this);
	endfunction
endclass
