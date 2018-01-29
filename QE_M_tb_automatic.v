module QE_M_tb_automatic ();

reg clk, reset;

//values from testvectors
reg valid_in, last_input, mode;
reg [7:0]in_a;
reg [7:0]in_x;
reg [7:0]in_b;
reg [7:0]in_c;

integer i;
reg [7:0]inA[5:0];
reg [7:0]inB[5:0];
reg [7:0]inC[5:0];
reg [7:0]inX[5:0];
reg valid_input[5:0];
reg last_in[5:0];
reg mode_sel[5:0];
reg [15:0]exp_result[5:0];
reg exp_valid_out[5:0];

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
	clk <= 1'b1;
	reset <= 1'b1;
	mode <= 1'b0;
	valid_in <= 1'b0;
	last_input <= 1'b0;
	#20 reset <= 1'b0;
	for (i=0; i<6; i=i+1) begin
	case(i)
		0: begin
			valid_input[i]	<= 1'b1;
			mode_sel[i]		<= 1'b0;
			last_in[i]		<= 1'b0;
			inA[i]			<= 8'd100;
			inB[i]			<= 8'd5;
			inC[i]			<= 8'd25;
			inX[i]			<= 8'd8;
			exp_result[i]	<= inA[i]*inX[i]*inX[i] + inB[i]*inX[i] + inC[i];
		end
		1: begin
			valid_input[i]	<= 1'b0;
			mode_sel[i]		<= 1'b0;
			last_in[i]		<= 1'b0;
			inA[i]			<= 8'd4;
			inB[i]			<= 8'd7;
			inC[i]			<= 8'd11;
			inX[i]			<= 8'd1;
			exp_result[i]	<= inA[i]*inX[i]*inX[i] + inB[i]*inX[i] + inC[i];
		end
		2: begin
			valid_input[i]	<= 1'b1;
			mode_sel[i]		<= 1'b0;
			last_in[i]		<= 1'b0;
			inA[i]			<= 8'd100;
			inB[i]			<= 8'd5;
			inC[i]			<= 8'd3;
			inX[i]			<= 8'd0;
			exp_result[i]	<= inA[i]*inX[i]*inX[i] + inB[i]*inX[i] + inC[i];
		end
		3: begin
			valid_input[i]	<= 1'b1;
			mode_sel[i]		<= 1'b1;
			last_in[i]		<= 1'b0;
			inA[i]			<= 8'd100;
			inB[i]			<= 8'd5;
			inC[i]			<= 8'd25;
			inX[i]			<= 8'd8;
			exp_result[i]	<= inA[i]*inX[i];
		end
		4: begin
			valid_input[i]	<= 1'b0;
			mode_sel[i]		<= 1'b1;
			last_in[i]		<= 1'b0;
			inA[i]			<= 8'd20;
			inB[i]			<= 8'd5;
			inC[i]			<= 8'd25;
			inX[i]			<= 8'd3;
			exp_result[i]	<= exp_result[i-1];
		end
		5: begin
			valid_input[i]	<= 1'b1;
			mode_sel[i]		<= 1'b1;
			last_in[i]		<= 1'b1;
			inA[i]			<= 8'd1;
			inB[i]			<= 8'd5;
			inC[i]			<= 8'd25;
			inX[i]			<= 8'd2;
			exp_result[i]	<= exp_result[i-1] + inA[i]*inX[i];
		end
	endcase

	end

	//result = 6465 (valid)
	#10 valid_in	<=	valid_input[0];
		mode		<=	mode_sel[0];
		last_input	<=	last_in[0];
		in_a		<=	inA[0];
		in_b		<=	inB[0];
		in_c		<=	inC[0];
		in_x		<=	inX[0];

	//result = 22 (invalid)
	#10 valid_in	<=	valid_input[1];
		mode		<=	mode_sel[1];
		last_input	<=	last_in[1];
		in_a		<=	inA[1];
		in_b		<=	inB[1];
		in_c		<=	inC[1];
		in_x		<=	inX[1];

	//result = 3 (valid)
	#10 valid_in	<=	valid_input[2];
		mode		<=	mode_sel[2];
		last_input	<=	last_in[2];
		in_a		<=	inA[2];
		in_b		<=	inB[2];
		in_c		<=	inC[2];
		in_x		<=	inX[2];

	//result = 800 (invalid - not completed)
	#20 valid_in	<=	valid_input[3];
		mode		<=	mode_sel[3];
		last_input	<=	last_in[3];
		in_a		<=	inA[3];
		in_b		<=	inB[3];
		in_c		<=	inC[3];
		in_x		<=	inX[3];

	//result = 800 (invalid - invalid data)
	#10 valid_in	<=	valid_input[4];
		mode		<=	mode_sel[4];
		last_input	<=	last_in[4];
		in_a		<=	inA[4];
		in_b		<=	inB[4];
		in_c		<=	inC[4];
		in_x		<=	inX[4];

	//result = 802 (valid)
	#10 valid_in	<=	valid_input[5];
		mode		<=	mode_sel[5];
		last_input	<=	last_in[5];
		in_a		<=	inA[5];
		in_b		<=	inB[5];
		in_c		<=	inC[5];
		in_x		<=	inX[5];
end

always begin
	#2.5 clk <= ~clk;
end

endmodule
