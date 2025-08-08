`include "defines.sv"
interface ram_interfs (input logic clk, rst);
	logic wr_en,rd_en;
	logic [`WIDTH-1:0] data_in;
	logic [$clog2(`DEPTH)-1:0] address;
	logic [`WIDTH-1:0] data_out;
	 
	clocking driver_cb @(posedge clk);
		default input #0 output #0;
		input rst;
		output wr_en;
		output rd_en;
		output data_in;
		output address;
	endclocking

	clocking monitor_cb @(posedge clk);
		default input #0 output #0;
		input rst;
		input wr_en;
		input rd_en;
		input data_in;
		input address;
		input data_out;
	endclocking

	clocking reference_cb @(posedge clk);
		default input #0 output #0;
		input rst;
	endclocking

	modport DRIVER (clocking driver_cb, input clk, rst);
	modport MONITOR (clocking monitor_cb, input clk, rst);
endinterface
