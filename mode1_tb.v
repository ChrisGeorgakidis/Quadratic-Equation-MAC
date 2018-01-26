module mode1_tb ();

reg clk, reset;
reg last_input;
reg [7:0]in_ai;
reg [7:0]in_xi;
wire [15:0]result;

Product_Sum Product_Sum (
    .clk             (clk),
    .reset           (reset),
    .last_input      (last_input),
    .in_ai           (in_ai),
    .in_xi           (in_xi),
    .result          (result)
);

initial begin
    clk <= 1;
    reset <= 1;
    last_input <= 0;
    #50 reset <= 0;

    in_ai <= 8'd1;
    in_xi <= 8'd2;

    #10 in_ai <= 8'd3;
    in_xi <= 8'd4;

    #10 in_ai <= 8'd5;
    in_xi <= 8'd6;

    #10 in_ai <= 8'd7;
    in_xi <= 8'd8;
    last_input <= 1'b1;
    #10 last_input <= 1'b0;

    #10 in_ai <= 8'd9;
    in_xi <= 8'd10;

    #10 in_ai <= 8'd11;
    in_xi <= 8'd12;
end

always begin
    #5 clk <= ~clk;
end

endmodule
