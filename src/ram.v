`include "defines.sv"
module ram (data_out, clk, rst, wr_en, rd_en, data_in, address);
	input wire clk, rst, wr_en, rd_en;
	input wire [`WIDTH-1:0] data_in;
	input wire [$clog2(`DEPTH)-1:0] address;
	output reg [`WIDTH-1:0] data_out;

	reg [`WIDTH-1:0] memory [0:`DEPTH-1];

	always@(posedge clk or negedge rst)
	begin
		if(~rst)
			data_out <= {`WIDTH{1'b0}};
		else if(rd_en)
			data_out <= memory[address];
		else if (wr_en)
			memory[address] <= data_in; 
		else
			data_out <= data_out;
	end
endmodule
