module QE_M_tb ();

reg clk, reset;
reg valid_in, last_input, mode;
reg [7:0]in_a;
reg [7:0]in_x;
reg [7:0]in_b;
reg [7:0]in_c;

wire valid_out;
wire [15:0]result;

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
  last_input <= 1'b0;
  mode <= 1'b0;
  #20 reset <= 1'b0;

  //51265 valid
  #10 valid_in <= 1'b1;
  in_a <= 8'd100;
  in_b <= 8'd5;
  in_c <= 8'd25;
  in_x <= 8'd8;

  //22 invalid
  #10 valid_in <= 1'b0;
  in_a <= 8'd4;
  in_b <= 8'd7;
  in_c <= 8'd11;
  in_x <= 8'd1;

  //3 valid
  #10valid_in <= 1'b1;
  in_a <= 8'd100;
  in_b <= 8'd5;
  in_c <= 8'd3;
  in_x <= 8'd9;

  //800 invalid
  #20 mode <= 1'b1;
  in_a <= 8'd100;
  in_x <= 8'd8;

  //800 invalid
  #10valid_in <= 1'b0;
  in_a <= 8'd20;
  in_x <= 8'd3;

  //802 valid
  #10valid_in <= 1'b1;
  last_input <= 1'b1;
  in_a <= 8'd1;
  in_x <= 8'd2;

end

always begin
  #2.5 clk <= ~clk;
end

endmodule
