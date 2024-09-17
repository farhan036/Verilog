module  d_ff_reset (
    input D,clk,
    input reset_n,clear_n, //RESET ASYNC SO THAT DON'T CARE OF D BUT CLEAR IS SYNCRO
    output q
);
reg q_next,q_reg;
    always @(negedge clk,negedge reset_n) begin  //negedge from 1 to 0
        q_reg=q_reg;
        if(!reset_n)
        q_reg=1'b0;
        else
        q_reg<=q_next;
    end
    always @(D,clear_n,q_reg) begin
        q_next=q_reg;
        if(!clear_n)
        q_next=1'b0;
        else
        q_next=D;

    end
assign q=q_reg;



endmodule