module QE_M_tb ();

reg clk, reset;

//values from testvectors
reg valid_in, last_input, mode;
reg [7:0]in_a;
reg [7:0]in_x;
reg [7:0]in_b;
reg [7:0]in_c;
reg [15:0]expected_result;
reg expected_valid_out;

reg [31:0]vectornum, [31:0]errors;  //bookeeping variables
reg [51:0] testvectors[10000:0];      //array of testvectors


//outputs of circuit
wire valid_out;
wire [15:0]result;

//instamtiate DUT (Device Under Test)
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

// initial begin
//   clk <= 1'b1;
//   reset <= 1'b1;
//   last_input <= 1'b0;
//   mode <= 1'b0;
//   #20 reset <= 1'b0;
//
//   //51265 valid
//   #10 valid_in <= 1'b1;
//   in_a <= 8'd100;
//   in_b <= 8'd5;
//   in_c <= 8'd25;
//   in_x <= 8'd8;
//
//   //22 invalid
//   #10 valid_in <= 1'b0;
//   in_a <= 8'd4;
//   in_b <= 8'd7;
//   in_c <= 8'd11;
//   in_x <= 8'd1;
//
//   //3 valid
//   #10valid_in <= 1'b1;
//   in_a <= 8'd100;
//   in_b <= 8'd5;
//   in_c <= 8'd3;
//   in_x <= 8'd0;
//
//   //800 invalid
//   #20 mode <= 1'b1;
//   in_a <= 8'd100;
//   in_x <= 8'd8;
//
//   //800 invalid
//   #10valid_in <= 1'b0;
//   in_a <= 8'd20;
//   in_x <= 8'd3;
//
//   //802 valid
//   #10valid_in <= 1'b1;
//   last_input <= 1'b1;
//   in_a <= 8'd1;
//   in_x <= 8'd2;
//
// end

//generate clk
always begin
  clk <= 1'b1;  #2.5 clk <= ~clk; #2.5; //5ns clk period
end

//at start of test, load vectors and pulse reset
initial begin
  $readmemb("example.tv", testvectors);   //Read vectors
  vectornum <= 3'b0;  errors <= 3'b0;     //Initialise
  //Apply reset
  reset <= 1'b1;
  #20 reset <= 1'b0;
end

//apply test vectors on rising edge of clk
always @ (posedge clk) begin
  #1 {valid_in, last_input, mode, in_a, in_b, in_c, in_x, expected_result, expected_valid_out} <= testvectors[vectornum];
end

//check results on falling edge of clk
always @ (negedge clk) begin
  if (~reset) begin
    if (result != expected_result) begin
      $display("Error: inputs = %d, {a, b, c}");
      $display("  outputs = %d (%d exp)", result, expected_result);
      errors <= errors + 1;
    end
    vectornum = vectornum + 1;
    if (testvectors[vectornum] == 53'bx) begin
      $display("%d tests completed with %d errors", vectornum, errors);
      $finish;  //End Simulation
    end
end

endmodule
