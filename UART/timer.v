`timescale 1ns / 1ps
module Timer #(
    parameter bits=4
) (
    input clk,reset_n,enable,
    input [bits-1:0] TIMER_FINAL_VALUE,
    output done
);
reg [bits-1:0] q_reg,q_next;
always @(posedge clk,negedge reset_n) begin
    if(!reset_n)
    q_reg<='b0;
    else if(enable)
    q_reg<=q_next;
    else
    q_reg<=q_reg;
end
assign done =(q_reg==TIMER_FINAL_VALUE);
always @(*) begin
    q_next= done?'b0: q_reg+1;
end

    
endmodule