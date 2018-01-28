module QE_M (clk, reset, in_a, in_b, in_c, in_x, mode, valid_in, last_input, valid_out, result);
input wire clk, reset, mode;
input wire [7:0]in_a;
input wire [7:0]in_b;
input wire [7:0]in_c;
input wire [7:0]in_x;
input wire valid_in, last_input;
output wire valid_out;
output wire [15:0]result;

wire [15:0]result_0;
wire [15:0]result_1;
wire enable_mode0, enable_mode1, done;

assign result = (mode == 1'b0) ? result_0 : result_1;

Quadratic_Equation Quadratic_Equation (
	.clk		(clk),
	.reset 		(reset),
	.enable		(enable_mode0),
	.in_a 		(in_a),
	.in_x 		(in_x),
	.in_b 		(in_b),
	.in_c 		(in_c),
	.result		(result_0)
);

Product_Sum Product_Sum (
	.clk 		(clk),
	.reset 		(reset),
	.enable		(enable_mode1),
	.valid_in	(valid_in),
	.done		(done),
	.in_ai 		(in_a),
	.in_xi		(in_x),
	.result		(result_1)
);

FSM FSM (
	.clk			(clk),
	.reset 			(reset),
	.mode 			(mode),
	.valid_in 		(valid_in),
	.last_in		(last_in),
	.enable_mode0 	(enable_mode0),
	.enable_mode1 	(enable_mode1),
	.valid_out 		(valid_out),
	.done			(done)
);

endmodule
