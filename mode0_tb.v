module mode0_tb ();

reg clk, reset, enable;
reg [7:0]in_a;
reg [7:0]in_x;
reg [7:0]in_b;
reg [7:0]in_c;
wire [15:0]result;

Quadratic_Equation Quadratic_Equation(
    .clk    (clk),
    .reset  (reset),
    .enable (enable),
    .in_a   (in_a),
    .in_x   (in_x),
    .in_b   (in_b),
    .in_c   (in_c),
    .result (result)
);

initial begin
    clk <= 1;
    reset <= 1;
    enable <= 1;
    #50reset <= 0;
    in_a <= 8'd5;
    in_x <= 8'd8;
    in_b <= 8'd13;
    in_c <= 8'd7;
    #10in_a <= 8'd1;
    in_x <= 8'd0;
    in_b <= 8'd2;
    in_c <= 8'd3;
    #10in_a <= 8'd25;
    in_x <= 8'd4;
    in_b <= 8'd18;
    in_c <= 8'd10;
    #10enable <= 0;
    in_a <= 8'd10;
    in_x <= 8'd4;
    in_b <= 8'd5;
    in_c <= 8'd10;
    #10enable <= 1;
    in_a <= 8'd25;
    in_x <= 8'd4;
    in_b <= 8'd18;
    in_c <= 8'd10;
end

always begin
    #5clk <= ~clk;
end

endmodule
