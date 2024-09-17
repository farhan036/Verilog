module Edge_detector (
    input reset_n,clk,level,
    output p_edge,n_edge,_edge
);
    reg [1:0] state_reg,state_next;
    localparam s0 = 0;
    localparam s1 = 1;
    always @(posedge clk,negedge reset_n) begin
        if(!reset_n)
        state_reg<=0;
        else
        state_reg<=state_next;
    end
    always @(*) begin
        case (state_reg)
            s0: 
            if(~level)
            state_next=s0;
            else if(level) 
            state_next=s1;
            s1:
            if(level)
            state_next=s1;
            else  
            state_next=s0; 
            default: state_next=state_reg;
        endcase
    end
assign p_edge= (state_reg==s0 )& level;
assign n_edge= (state_reg==s1) & ~level;
assign _edge=p_edge | n_edge;


endmodule