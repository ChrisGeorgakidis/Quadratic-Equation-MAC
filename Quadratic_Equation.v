module Quadratic_Equation (clk, reset, enable,in_a, in_x, in_b, in_c, result);

input wire clk, reset, enable;
input wire [7:0]in_a;
input wire [7:0]in_x;
input wire [7:0]in_b;
input wire [7:0]in_c;
output reg [15:0]result;

reg [7:0]C;
reg [7:0]rX;
reg [15:0]R;

always @ ( posedge clk or posedge reset ) begin
    if (reset == 1) begin
        R <= 16'b0;
        C <= 8'b0;
        result <= 16'b0;
    end
    else begin
        if (enable == 1) begin
            rX <= in_x;
            C <= in_c;
            R <= (in_a * in_x) + in_b;
        end
        else begin
            rX <= 0;
            C <= 0;
            R <= 0;
        end
        result <= (R * rX) + C;
    end
end
endmodule // Quadratic_Equation
