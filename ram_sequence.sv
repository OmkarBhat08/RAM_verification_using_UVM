//`include "ram_sequence_item.sv"
//`include "defines.sv"
//`include "uvm_macros.svh"
import uvm_pkg ::*;
class ram_sequence extends uvm_sequence #(ram_sequence_item);
	`uvm_object_utils(ram_sequence)

	function new(string name = "ram_sequence");
		super.new(name);
	endfunction

	virtual task body();
		req = ram_sequence_item::type_id::create("req");
		wait_for_grant();
		req.randomize();
		send_request(req);
		wait_for_item_done();
	endtask
endclass
