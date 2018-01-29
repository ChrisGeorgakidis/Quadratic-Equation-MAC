module QE_M_tb_automatic ();

reg clk, reset;

//values from testvectors
reg valid_in, last_input, mode;
reg [7:0]in_a;
reg [7:0]in_x;
reg [7:0]in_b;
reg [7:0]in_c;

integer i, counter, errors;
reg [7:0]inA[5:0];
reg [7:0]inB[5:0];
reg [7:0]inC[5:0];
reg [7:0]inX[5:0];
reg valid_input[5:0];
reg last_in[5:0];
reg mode_sel[5:0];
reg [15:0]exp_result[5:0];
reg [0:0]exp_valid_out[5:0];

//outputs of circuit
wire valid_out;
wire [15:0]result;

//instantiate DUT (Device Under Test)
QE_M QE_M (
	.clk            (clk),
	.reset          (reset),
	.in_a           (in_a),
	.in_b           (in_b),
	.in_c           (in_c),
	.in_x           (in_x),
	.mode           (mode),
	.valid_in       (valid_in),
	.last_input     (last_input),
	.valid_out      (valid_out),
	.result         (result)
);

initial begin
	clk = 1'b1;
	counter = 0;
	errors = 0;
	reset = 1'b1;
	mode = 1'b0;
	valid_in = 1'b0;
	last_input = 1'b0;
	#20 reset = 1'b0;
	for (i=0; i<6; i=i+1) begin
	case(i)
		0: begin
			valid_input[i]		= 1'b1;
			mode_sel[i]			= 1'b0;
			last_in[i]			= 1'b0;
			inA[i]				= $random%256;
			inB[i]				= $random%256;
			inC[i]				= $random%256;
			inX[i]				= $random%256;
			exp_result[i]		= inA[i]*inX[i]*inX[i] + inB[i]*inX[i] + inC[i];
			exp_valid_out[i]	= valid_input[i];
		end
		1: begin
			valid_input[i]		= 1'b0;
			mode_sel[i]			= 1'b0;
			last_in[i]			= 1'b0;
			inA[i]				= $random%256;
			inB[i]				= $random%256;
			inC[i]				= $random%256;
			inX[i]				= $random%256;
			exp_result[i]		= inA[i]*inX[i]*inX[i] + inB[i]*inX[i] + inC[i];
			exp_valid_out[i]	= valid_input[i];
		end
		2: begin
			valid_input[i]		= 1'b1;
			mode_sel[i]			= 1'b0;
			last_in[i]			= 1'b0;
			inA[i]				= $random%256;
			inB[i]				= $random%256;
			inC[i]				= $random%256;
			inX[i]				= $random%256;
			exp_result[i]		= inA[i]*inX[i]*inX[i] + inB[i]*inX[i] + inC[i];
			exp_valid_out[i]	= valid_input[i];
		end
		//mode 1
		3: begin
			valid_input[i]		= 1'b1;
			mode_sel[i]			= 1'b1;
			last_in[i]			= 1'b0;
			inA[i]				= $random%256;
			inB[i]				= $random%256;
			inC[i]				= $random%256;
			inX[i]				= $random%256;
			exp_result[i]		= inA[i]*inX[i];
			exp_valid_out[i]	= last_in[i];
		end
		4: begin
			valid_input[i]		= 1'b0;
			mode_sel[i]			= 1'b1;
			last_in[i]			= 1'b0;
			inA[i]				= $random%256;
			inB[i]				= $random%256;
			inC[i]				= $random%256;
			inX[i]				= $random%256;
			exp_result[i]		= exp_result[i-1];
			exp_valid_out[i]	= last_in[i];
		end
		5: begin
			valid_input[i]		= 1'b1;
			mode_sel[i]			= 1'b1;
			last_in[i]			= 1'b1;
			inA[i]				= $random%256;
			inB[i]				= $random%256;
			inC[i]				= $random%256;
			inX[i]				= $random%256;
			exp_result[i]		= exp_result[i-1] + inA[i]*inX[i];
			exp_valid_out[i]	= last_in[i];
		end
	endcase

	end

	//result = 6465 (valid)
	#5.5 valid_in	=	valid_input[0];
		mode		=	mode_sel[0];
		last_input	=	last_in[0];
		in_a		=	inA[0];
		in_b		=	inB[0];
		in_c		=	inC[0];
		in_x		=	inX[0];

	//result = 22 (invalid)
	#5.5 valid_in	=	valid_input[1];
		mode		=	mode_sel[1];
		last_input	=	last_in[1];
		in_a		=	inA[1];
		in_b		=	inB[1];
		in_c		=	inC[1];
		in_x		=	inX[1];

	//result = 3 (valid)
	#5.5 valid_in	=	valid_input[2];
		mode		=	mode_sel[2];
		last_input	=	last_in[2];
		in_a		=	inA[2];
		in_b		=	inB[2];
		in_c		=	inC[2];
		in_x		=	inX[2];

	//result = 800 (invalid - not completed)
	#11 valid_in	=	valid_input[3];
		mode		=	mode_sel[3];
		last_input	=	last_in[3];
		in_a		=	inA[3];
		in_b		=	inB[3];
		in_c		=	inC[3];
		in_x		=	inX[3];
	#5.5;
	//result = 800 (invalid - invalid data)
	#5.5 valid_in	=	valid_input[4];
		mode		=	mode_sel[4];
		last_input	=	last_in[4];
		in_a		=	inA[4];
		in_b		=	inB[4];
		in_c		=	inC[4];
		in_x		=	inX[4];

	//result = 802 (valid)
	#5.5 valid_in	=	valid_input[5];
		mode		=	mode_sel[5];
		last_input	=	last_in[5];
		in_a		=	inA[5];
		in_b		=	inB[5];
		in_c		=	inC[5];
		in_x		=	inX[5];
	#50 $finish;
end

always begin
	#2.75 clk = ~clk;
	if (clk == 1) begin
		counter = counter + 1;
	end
end

always @ (negedge clk) begin
	case (counter)
		6: begin
			if (result == exp_result[0] && valid_out == exp_valid_out[0] ) begin
				$display("Success: inputs = %d %d %d %d %d %d %d %d %d", valid_input[0], last_in[0], mode_sel[0], inA[0], inB[0], inC[0], inX[0], exp_result[0], exp_valid_out[0]);
				$display("  outputs: result = %d (%d exp) | valid_out = %d (%d exp)", result, exp_result[0], valid_out, exp_valid_out[0]);
			end
			else begin
				$display("Error: inputs =  %d %d %d %d %d %d %d %d %d", valid_input[0], last_in[0], mode_sel[0], inA[0], inB[0], inC[0], inX[0], exp_result[0], exp_valid_out[0]);
				$display("  outputs: result = %d (%d exp) | valid_out = %d (%d exp)", result, exp_result[0], valid_out, exp_valid_out[0]);
				errors <= errors + 1;
			end
		end
		7: begin
			if (result == exp_result[1] && valid_out == exp_valid_out[1] ) begin
				$display("Success: inputs =  %d %d %d %d %d %d %d %d %d", valid_input[1], last_in[1], mode_sel[1], inA[1], inB[1], inC[1], inX[1], exp_result[1], exp_valid_out[1]);
				$display("  outputs: result = %d (%d exp) | valid_out = %d (%d exp)", result, exp_result[1], valid_out, exp_valid_out[1]);
			end
			else begin
				$display("Error: inputs =  %d %d %d %d %d %d %d %d %d", valid_input[1], last_in[1], mode_sel[1], inA[1], inB[1], inC[1], inX[1], exp_result[1], exp_valid_out[1]);
				$display("  outputs: result = %d (%d exp) | valid_out = %d (%d exp)", result, exp_result[1], valid_out, exp_valid_out[1]);
				errors <= errors + 1;
			end
		end
		8: begin
			if (result == exp_result[2] && valid_out == exp_valid_out[2] ) begin
				$display("Success: inputs =  %d %d %d %d %d %d %d %d %d", valid_input[2], last_in[2], mode_sel[2], inA[2], inB[2], inC[2], inX[2], exp_result[2], exp_valid_out[2]);
				$display("  outputs: result = %d (%d exp) | valid_out = %d (%d exp)", result, exp_result[2], valid_out, exp_valid_out[2]);
			end
			else begin
				$display("Error: inputs =  %d %d %d %d %d %d %d %d %d", valid_input[2], last_in[2], mode_sel[2], inA[2], inB[2], inC[2], inX[2], exp_result[2], exp_valid_out[2]);
				$display("  outputs: result = %d (%d exp) | valid_out = %d (%d exp)", result, exp_result[2], valid_out, exp_valid_out[2]);
				errors <= errors + 1;
			end
		end
		11: begin
			if (result == exp_result[3] && valid_out == exp_valid_out[3] ) begin
				$display("Success: inputs =  %d %d %d %d %d %d %d %d %d", valid_input[3], last_in[3], mode_sel[3], inA[3], inB[3], inC[3], inX[3], exp_result[3], exp_valid_out[3]);
				$display("  outputs: result = %d (%d exp) | valid_out = %d (%d exp)", result, exp_result[3], valid_out, exp_valid_out[3]);
			end
			else begin
				$display("Error: inputs =  %d %d %d %d %d %d %d %d %d", valid_input[3], last_in[3], mode_sel[3], inA[3], inB[3], inC[3], inX[3], exp_result[3], exp_valid_out[3]);
				$display("  outputs: result = %d (%d exp) | valid_out = %d (%d exp)", result, exp_result[3], valid_out, exp_valid_out[3]);
				errors <= errors + 1;
			end
		end
		12: begin
			if (result == exp_result[4] && valid_out == exp_valid_out[4] ) begin
				$display("Success: inputs =  %d %d %d %d %d %d %d %d %d", valid_input[4], last_in[4], mode_sel[4], inA[4], inB[4], inC[4], inX[4], exp_result[4], exp_valid_out[4]);
				$display("  outputs: result = %d (%d exp) | valid_out = %d (%d exp)", result, exp_result[4], valid_out, exp_valid_out[4]);
			end
			else begin
				$display("Error: inputs =  %d %d %d %d %d %d %d %d %d", valid_input[4], last_in[4], mode_sel[4], inA[4], inB[4], inC[4], inX[4], exp_result[4], exp_valid_out[4]);
				$display("  outputs: result = %d (%d exp) | valid_out = %d (%d exp)", result, exp_result[4], valid_out, exp_valid_out[4]);
				errors <= errors + 1;
			end
		end
		13: begin
			if (result == exp_result[5] && valid_out == exp_valid_out[5] ) begin
				$display("Success: inputs =  %d %d %d %d %d %d %d %d %d", valid_input[5], last_in[5], mode_sel[5], inA[5], inB[5], inC[5], inX[5], exp_result[5], exp_valid_out[5]);
				$display("  outputs: result = %d (%d exp) | valid_out = %d (%d exp)", result, exp_result[5], valid_out, exp_valid_out[5]);
			end
			else begin
				$display("Error: inputs =  %d %d %d %d %d %d %d %d %d", valid_input[5], last_in[5], mode_sel[5], inA[5], inB[5], inC[5], inX[5], exp_result[5], exp_valid_out[5]);
				$display("  outputs: result = %d (%d exp) | valid_out = %d (%d exp)", result, exp_result[5], valid_out, exp_valid_out[5]);
				errors <= errors + 1;
			end
		end
		default:;
	endcase
end
endmodule
