module Product_Sum (clk, reset, enable, valid_in, done, in_ai, in_xi, result);

input wire clk, reset;
input wire done, enable, valid_in;
input wire [7:0]in_ai;
input wire [7:0]in_xi;
output reg [15:0]result;

reg [15:0]mult_reg;
reg [15:0]register;
wire [15:0]mult_result;
wire [15:0]result_w;

assign mult_result = in_ai*in_xi;
assign result_w = mult_reg + register;

always @ (posedge clk or posedge reset) begin
	if (reset == 1'b1) begin
		register <= 16'b0;
		mult_reg <= 16'b0;
	end
	else begin
		if (enable == 1) begin
			if (valid_in == 1) begin
				mult_reg <= mult_result;
			end
			else begin
				mult_reg <= 16'b0;
			end
			if (done == 0) begin
				register <= result_w;
			end
			else begin
				register <= 16'b0;
			end
			result <= result_w;
		end
		else begin
			register <= 16'b0;
		end
	end
end

endmodule
