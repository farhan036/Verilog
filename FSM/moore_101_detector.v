module moore101 (
    input clk,reset_n,x,
    output y
);
reg [1:0] state_reg,state_next;
localparam s0 = 0;
localparam s1 = 1;
localparam s2 = 2;
localparam s3 = 3;

always @(posedge clk,negedge reset_n) begin
    if(!reset_n)
    state_reg<=s0;
    else
    state_reg<=state_next;
end

always @(*) begin
    case (state_reg)
       s0 : 
       if(x)
       state_next=s1;
       else
       state_next=s0;
       s1 : 
       if(x)
       state_next=s1;
       else
       state_next=s2;
       s2 : 
       if(x)
       state_next=s3;
       else
       state_next=s0;
       s3 : 
       if(x)
       state_next=s1;
       else
       state_next=s2; 
 default: state_next=state_reg;
    endcase
end
assign y= (state_reg==s3);
    
endmodule