module FSM (clk, reset, mode, valid_in, last_in, enable_mode0, enable_mode1, valid_out, done);
input wire clk, reset;
input wire mode, valid_in, last_in;
output reg enable_mode0, enable_mode1, valid_out, done;

//values for mode
parameter MODE_0 = 1'b0;
parameter MODE_1 = 1'b1;

reg old_valid, last_input;

always @ (posedge clk or posedge reset) begin
	if (reset == 1'b1) begin
		enable_mode0 <= 1'b0;
		enable_mode1 <= 1'b0;
		valid_out <= 1'b0;
		last_input <= 1'b0;
		old_valid <= 1'b0;
		done <= 1'b0;
	end
	else begin
		case (mode)
		MODE_0: begin
			enable_mode0 <= 1'b1;
			enable_mode1 <= 1'b0;
			valid_out <= old_valid;
			last_input <= 1'b0;
			old_valid <= valid_in;
			done <= 0;
		end
		MODE_1: begin
			enable_mode0 <= 1'b0;
			enable_mode1 <= 1'b1;
			valid_out <= last_input;
			last_input <= last_in;
			old_valid <= valid_in;
			done <= last_in;
		end
		endcase
	end
end
endmodule
