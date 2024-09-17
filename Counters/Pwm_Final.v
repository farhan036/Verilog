`timescale 1ns / 1ps
module Pwm_f #(
    parameter n=8,Time_bit=15
) (
    input clk,reset_n,
    input  [n:0]  duty, //0 to 256 example
    input [Time_bit-1:0] final_value,
    output [n-1:0] q,
    output  pwm_out 
);
reg [n-1:0] q_reg,q_next;
reg d_next,d_reg;
wire tick;  //enable of timer
always @(posedge clk,negedge reset_n) begin
    if(!reset_n) begin
        q_reg<='b0;
        d_reg<=1'b0;
    end
    else if(tick) begin
        q_reg<=q_next;
        d_reg<=d_next;
    end
    else
    begin
    q_reg<=q_reg;
    d_reg<=d_reg;
    end
end
always @(q_reg,duty) begin
    q_next=q_reg+1;
    d_next=(q_reg<duty);
end
assign pwm_out=d_reg;
timer #(.n(Time_bit)) t0(

.clk(clk),
.reset_n(reset_n),
.enable(1'b1),
.final_value(final_value),
.done(tick)
);
    assign q=q_reg;
endmodule