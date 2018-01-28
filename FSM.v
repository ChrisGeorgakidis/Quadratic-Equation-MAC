module FSM (clk, reset, mode, valid_in, last_in, enable_mode0, enable_mode1, valid_out, done);
input wire clk, reset;
input wire mode, valid_in, last_in;
output reg enable_mode0, enable_mode1, valid_out, done;

//values for mode
parameter MODE_0 = 1'b0;
parameter MODE_1 = 1'b1;
//~~~~~~~~~~~~~~~~~~~~~~~~//
//values for mode_state
//parameter IDLE = 2'd0;
//parameter MODE_0_SIGNALS = 1'd0;
//parameter MODE_1_SIGNALS = 1'd1;

//wire mode_state;
//reg [1:0]state;
reg old_valid, last_input;

//assign mode_state = mode;

// always @ (posedge clk or posedge reset) begin
// 	if (reset == 1'b1) begin
// 		state <= IDLE;
// 	end
// 	else begin
// 		case (mode)
// 		MODE_0: begin
// 			state <= MODE_0_SIGNALS;
// 		end
// 		MODE_1: begin
// 			state <= MODE_1_SIGNALS;
// 		end
// 		default: begin
// 			state <= IDLE;
// 		end
// 		endcase
// 	end
// end

always @ (posedge clk or posedge reset) begin
	if (reset == 1'b1) begin
		enable_mode0 <= 1'b0;
		enable_mode1 <= 1'b0;
		valid_out <= 1'b0;
		last_input <= 1'b0;
		old_valid <= 1'b0;
		done <= last_in;
	end
	else begin
		case (mode)
		// IDLE: begin
		// 	enable_mode0 <= 1'b0;
		// 	enable_mode1 <= 1'b0;
		// 	valid_out <= 1'b0;
		// 	last_input <= 1'b0;
		// 	old_valid <= 1'b0;
		// 	done <= last_in;
		// end
		MODE_0: begin
			enable_mode0 <= 1'b1;
			enable_mode1 <= 1'b0;
			valid_out <= old_valid;
			last_input <= 1'b0;
			old_valid <= valid_in;
			done <= last_in;
		end
		MODE_1: begin
			enable_mode0 <= 1'b0;
			enable_mode1 <= 1'b1;
			valid_out <= last_input;
			last_input <= last_in;
			old_valid <= valid_in;
			done <= last_in;
		end
		// default: begin
		// 	enable_mode0 <= 1'b0;
		// 	enable_mode1 <= 1'b0;
		// 	valid_out <= 1'b0;
		// 	last_input <= 1'b0;
		// 	old_valid <= 1'b0;
		// 	done <= last_in;
		// end
		endcase
	end
end
endmodule
