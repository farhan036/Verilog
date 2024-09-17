`timescale 1ns/1ps
module d_posff (
    input D,clk,
    output reg q,
    output q_b
);

assign q_b=~q;
always @(posedge clk)
begin
   q=D;
end


    
endmodule