module sync_counter_tb (
    
);
reg clk,reset_n;
wire [3:0] q ;
counterup uut (
.clk(clk),
.reset_n(reset_n),
.q(q)
);
initial 
    #200 $stop;
 
localparam t = 10;
always begin
    clk=1'b0;
    #(t/2);
    clk=1'b1;
    #(t/2);
end
initial
begin
    reset_n=1'b0;
    #2; 
    reset_n=1'b1;
end
    



    
endmodule