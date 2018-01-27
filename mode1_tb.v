module mode1_tb ();

reg clk, reset;
reg done, enable, valid_in;
reg [7:0]in_ai;
reg [7:0]in_xi;
wire [15:0]result;

Product_Sum Product_Sum (
    .clk                (clk),
    .reset              (reset),
    .done               (done),
    .enable             (enable),
    .valid_in           (valid_in),
    .in_ai              (in_ai),
    .in_xi              (in_xi),
    .result             (result)
);

initial begin
    clk <= 1;
    reset <= 1;
    done <= 0;
    enable <= 1;
    valid_in <= 1;
    #50 reset <= 0;

    in_ai <= 8'd1;
    in_xi <= 8'd2;

    #10 in_ai <= 8'd3;
    in_xi <= 8'd4;

    #10 in_ai <= 8'd5;
    in_xi <= 8'd6;

    #10 in_ai <= 8'd7;
    in_xi <= 8'd8;
    #1done <= 1'b1;
    #10done <= 1'b0;

    #9 in_ai <= 8'd9;
    in_xi <= 8'd10;

    #10 in_ai <= 8'd11;
    in_xi <= 8'd12;

    #10 enable <= 0;
    #20 enable <= 1;
end

always begin
    #5 clk <= ~clk;
end

endmodule
