module reg_4bit_reg #(parameter n = 4 ) (
    input [n-1:0] I,
    input load,clk,
    output [n-1:0] Q
);

reg [n-1:0] Q_NEXT,Q_REG ;
//non block 
always @(posedge clk) begin
    Q_REG<=Q_NEXT;
end
always @(load,I,Q_REG) begin
    if(load)
    Q_NEXT=I;
    else
    Q_NEXT=Q_REG;
end

assign q=Q_REG;

    
endmodule