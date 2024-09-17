module modulus_counter_up #(
    parameter load=500,
    parameter bits=$clog2(load)
) (
    input clk,reset_n,up,enable,
    output [bits:0] q
);
reg [bits-1:0] q_next,q_reg;
always @(posedge clk,negedge reset_n) begin
    if(!reset_n)
    q_reg='b0;
    else
    q_reg<=q_next;
end
    always @(q_reg,enable,load) begin
        q_next=q_reg;
        if(q_next<load)
        q_next=q_reg+1;
        else if(q_next>=load)
        q_next='b0;
    end
assign q=q_reg;


endmodule