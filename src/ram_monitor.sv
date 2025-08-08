class ram_monitor extends uvm_monitor;

	ram_interfs vif;
	uvm_analysis_port #(ram_sequence_item) item_collected_port;

	`uvm_component_utils(ram_monitor)

	function new(string name = "ram_monitor", uvm_component parent = null);
		super.new(name, parent);
		ram_sequence_item_monitor = new();
		item_collected_port = new("item_collected_port", this);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		if(!uvm_config_db #(ram_sequence_item)::get(this,"","vif",vif))
			`uvm_fatal(get_type_name(), "Not set at top");
	endfunction

	virtual task run_phase(uvm_phase phase)
		super.run_phase(phase);
		forever
		begin
			@(posedge vif.monitor_cb);
			wait(vif.wr_en || vif.rd_en);
			ram_sequence_item_monitor.wr_en = vif.wr_en;
			ram_sequence_item_monitor.rd_en = vif.rd_en;
			ram_sequence_item_monitor.address = vif.address;
			ram_sequence_item_monitor.data_in = vif.data_in;
			ram_sequence_item_monitor.data_out = vif.data_out;

			item_collected_port.write(ram_sequence_item_monitor);
		end
		ram_sequence_item_monitor.print();
	endtask
endclass
