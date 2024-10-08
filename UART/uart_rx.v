`timescale 1ns / 1ps

module rx #(
    parameter DBIT=8,SB_TICK=16
) (
    input clk,reset_n,s_tick,rx,
    output reg rx_done_tick,
    output [DBIT-1:0] rx_dout
);
localparam idle = 0;
localparam start = 1;
localparam data = 2;
localparam stop = 3;
 reg [1:0] state_reg,state_next;
 reg [DBIT-1:0] b_reg,b_next;
 reg [3:0] s_reg,s_next;
 reg [$clog2(DBIT) - 1:0] n_reg, n_next; // keep track of the number of data bits recieved
     //sync
     always @(posedge clk,negedge reset_n) begin
        if(!reset_n) 
        begin
            state_reg<=idle;
            s_reg<=0;
            b_reg<=0;
            n_reg<=0;
        end
        else 
        begin
            state_reg<=state_next;
            s_reg<=s_next;
            b_reg<=b_next;
            n_reg<=n_next;
        end
        
     end
always @(*) begin
    state_next = state_reg;
        s_next = s_reg;
        n_next = n_reg;
        b_next = b_reg;
        rx_done_tick = 1'b0;
    case (state_reg)
        idle:
        if(rx==0) 
        begin
        s_next=0;
        state_next=start;
        end
        start: 
        if(s_tick==1)
            if(s_reg==7)
            begin
              s_next=0;
              n_next=0; 
              state_next=data; 
            end
            else 
            s_next=s_reg+1;
        data: 
        if(s_tick==1)
            if(s_reg==15)
            begin
                s_next=0;
                b_next={rx,b_reg[DBIT-1:1]};
                    if(n_reg==(DBIT-1))
                    state_next=stop;
                    else
                        n_next=n_reg+1;
                    
            end
            else
                s_next=s_reg+1;      

        stop: 
        if(s_tick==1)
            if(s_reg==(SB_TICK-1))
            begin
                rx_done_tick=1;
                state_next=idle;
            end
            else
                s_next=s_reg+1;
        default: state_next=idle;
    endcase

end
assign rx_dout=b_reg;

endmodule