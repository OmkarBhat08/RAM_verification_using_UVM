`include "uvm_macros.svh"
`include "ram_driver.sv"
`include "ram_monitor.sv"
`include "ram_sequencer.sv"
import uvm_pkg ::*;
class ram_agent extends uvm_agent;
	ram_driver drv;
	ram_monitor mon;
	ram_sequencer seqr;

	`uvm_component_utils(ram_agent)

	function new(string name = "ram_agent", uvm_component parent  = null);
		super.new(name,parent);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		if(get_is_active() == UVM_ACTIVE)
		begin
			drv = ram_driver::type_id::create("drv",this);
			seqr = ram_sequencer::type_id::create("seqr",this);
		end
		mon = ram_monitor::type_id::create("mon",this);
	endfunction

	function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
		if(get_is_active == UVM_ACTIVE)
			drv.seq_item_port.connect(seqr.seq_item_export);
	endfunction

endclass
