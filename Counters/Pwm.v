module Pwm #(
    parameter n=4
) (
    input clk,reset_n,
    input  [n-1:0]  duty,
    output [n-1:0] q,
    output  pwm_out
);
reg [n-1:0] q_next,q_reg;
always @(posedge clk,negedge reset_n) begin
    if(!reset_n)
        q_reg<='b0;
    else
        q_reg<=q_next;
end
always @(*) begin
    
    q_next=q_reg+1;
    
end
assign q=q_reg;
assign pwm_out = (q < duty);



    
endmodule