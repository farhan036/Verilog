`timescale 1ns/1ps
module d_negff (
    input D,clk,
    output reg q,
    output q_b
);

assign q_b=~q;
always @(negedge clk)
begin
   q=D;
end


    
endmodule