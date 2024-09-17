module Fsm_swap (
    input clk,reset_n,swap,
    output [1:0] sel,
    output w
);
    reg [1:0] state_reg,state_next;
    localparam s0 = 0;
    localparam s1 = 1;
    localparam s2 = 2;
    localparam s3 = 3;
    always @(posedge clk,negedge reset_n) begin
        if(!reset_n)
        state_reg<=0;
        else
        state_reg<=state_next;
    end
        always @(*) begin
            case (state_reg)
               s0 : 
               if(~swap)
               state_next=s0;
               else
               state_next=s1;
               s1 : 
               state_next=s2;
               s2 : 
               state_next=s3;
               s3 : 
               state_next=s0;
                default:state_next=s0; 
            endcase
        end
        assign sel=state_reg;
        assign w=(state_reg!=s0);
    
endmodule