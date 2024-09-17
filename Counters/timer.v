module timer #(
    parameter n=4
) (
    input clk,reset_n,enable,
    input [n-1:0] final_value,
    output done
);
    reg [n-1:0] q_reg,q_next;

always @(posedge clk,negedge reset_n) begin
    if(!reset_n)
    q_reg<='b0;
    else if(enable)
    q_reg<=q_next;
    else
    q_reg=q_reg;

end
assign done=q_reg==final_value;
always @(*) begin
    q_next=done?'b0:q_reg+1;
end



endmodule