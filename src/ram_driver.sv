`include "uvm_macros.svh"
`include "ram_sequence_item.sv"
`include "ram_interfs.sv"
import uvm_pkg ::*;

class ram_driver extends uvm_driver #(ram_sequence_item);

	virtual ram_interfs vif;
	uvm_analysis_port #(ram_sequence_item) item_collected_port;		// For coverage

	`uvm_component_utils(ram_driver)

	function new(string name = "ram_driver", uvm_component parent = null);
		super.new(name, parent);
		item_collected_port = new("item_collected_port", this);
	endfunction

	function void build_phase(uvm_phase phase);
		build_phase(phase);
		if(!uvm_config_db #(virtual ram_interfs)::get(this,"","vif",vif))
			`uvm_fatal(get_type_name(),"Not set at top");
	endfunction

	virtual task run_phase (uvm_phase phase);
		super.run_phase(phase);
		forever
		begin
			seq_item_port.get_next_item(req);
			drive();
			seq_item_port.item_done();
		end
	endtask

	virtual task drive();
		@(posedge vif.driver_cb);
		vif.wr_en <= req.wr_en;
		vif.rd_en <= req.rd_en;
		vif.data_in <= req.data_in;
		vif.rd_en <= req.rd_en;
		vif.address <= req.address;
	
		req.print();
		item_collected_port.write(req);
	endtask
endclass
