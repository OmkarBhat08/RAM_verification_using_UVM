class ram_scoreboard extends uvm_scoreboard;
	
	ram_sequence_item queue [$];



	`uvm_component_utils(ram_scoreboard)

	function new(string name = "ram_scoreboard", uvm_component parent = null);
		super.new(name, parent);
	endfunction

endclass
