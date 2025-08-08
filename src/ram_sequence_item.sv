`include "defines.sv"
`include "uvm_macros.svh"
import uvm_pkg ::*;

class ram_sequence_item extends uvm_sequence_item;
	rand bit wr_en, rd_en;
	rand bit [`WIDTH-1:0] data_in;
	rand bit [ $clog2(`DEPTH)-1:0 ] address;	
	bit [`WIDTH-1:0] data_out;

	`uvm_object_utils_begin(ram_sequence_item)
		`uvm_field_int(wr_en, UVM_ALL_ON);
		`uvm_field_int(rd_en, UVM_ALL_ON);
		`uvm_field_int(data_in, UVM_ALL_ON);
		`uvm_field_int(address, UVM_ALL_ON);
	`uvm_object_utils_end

	function new(string name = "ram_sequence_item");
		super.new(name);
	endfunction
	
	constraint en{wr_en != rd_en;};
endclass
