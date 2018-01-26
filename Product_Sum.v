module Product_Sum (clk, reset, last_input, in_ai, in_xi, result);

input wire clk, reset, last_input;
input wire [7:0]in_ai;
input wire [7:0]in_xi;
output wire [15:0]result;

reg [15:0]mult_reg;
reg [15:0]register;
wire [15:0]mult_result;
reg done;

assign mult_result = in_ai*in_xi;
assign result = mult_reg + register;

always @ (posedge clk or posedge reset) begin
	if (reset == 1'b1) begin
		register <= 16'b0;
		mult_reg <= 16'b0;
	end
	else begin
		mult_reg <= mult_result;
		if (done == 0) begin
			register <= result;
		end
		else begin
			register <= 16'b0;
		end
	end
end

always @ ( posedge clk or posedge reset ) begin
	if (reset == 1) begin
		done <= 0;
	end
	else begin
		if (last_input == 1'b1) begin
			done <= 1;
		end
		else begin
			done <= 0;
		end
	end
end

endmodule
