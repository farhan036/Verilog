module counter_up_down #(
    parameter bits=4
) (
    input clk,reset_n,up,enable,
    output [bits-1:0] q
);
reg [bits-1:0] q_next,q_reg;
always @(posedge clk,negedge reset_n) begin
    if(!reset_n)
    q_reg='b0;
    else
    q_reg<=q_next;
end
    always @(q_reg,enable) begin
        q_next=q_reg;
        if(enable)
        begin
            if(up)
            q_next=q_reg+1;
            else
            q_next=q_reg-1;
        end
        else
        q_next=q_reg;

    end
assign q=q_reg;


endmodule