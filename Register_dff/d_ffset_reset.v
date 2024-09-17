module  d_ffset_reset (
    input D,clk,
    input reset_n,set_n, //RESET ASYNC SO THAT DON'T CARE OF D BUT set IS SYNCRO set if 0 then it work
    output q
);
reg q_next,q_reg;
    always @(negedge clk or negedge reset_n) begin  //negedge from 1 to 0
        q_reg=q_reg;
        if(!reset_n)
        q_reg<=1'b0;
        else
        q_reg<=q_next;
    end
    always @(D,set_n) begin
        q_next = q_reg;
        if(!set_n)
        q_next=1'b1;
        else
        q_next=D;

    end
assign q=q_reg;



endmodule