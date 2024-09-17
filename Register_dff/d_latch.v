`timescale 1ns/1ps
module d_latch (
    input D,clk,
    output reg q,
    output q_b
);

assign q_b=~q;
always @(D,clk)
begin
    q=q; //initial
    if (clk)
    q=D;
    else
    q=q;
end


    
endmodule