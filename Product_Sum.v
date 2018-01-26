module Product_Sum (clk, reset, last_input, in_ai, in_xi, result);

input wire clk, reset;
input wire [7:0]in_ai, [7:0]in_xi;
output wire [15:0]result;

reg [15:0]register;
wire [15:0]mult_result;

assign mult_result = in_ai*in_xi;
assign result = mult_result + register;

always @ (posedge clk or posedge reset) begin
	if (reset == 1'b1) begin
		register <= 0;
	end
	else begin
		if (last_input == 1'b1) begin
			register <= 16'b0;
		end
		else begin
			register <= result;
		end
	end
end

endmodule
