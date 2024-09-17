module bcd (
    input clk,reset_n,up,enable,done,
    output [3:0] q
);
reg [3:0] q_next,q_reg;
always @(posedge clk,negedge reset_n) begin
    if(!reset_n)
    q_reg='b0;
    else if(enable)
            q_reg <= q_next;
        else
            q_reg <= q_reg;
end
    assign done= q_reg==9;
    always @(*) begin
        q_next=done?'b0 : q_reg+1;
    end
    assign q=q_reg;
endmodule