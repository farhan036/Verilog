module u_shift_reg #(parameter n = 4) (
    input [1:0] s,
    input clk,msb,lsb, //msb //input bit from left &lsb input bit from right
    input [n-1:0] I,
    input reset_n,
    output [n-1:0] q
    
);
reg [n-1:0] qnext,qreg;

always @(posedge clk,negedge reset_n) begin
    if(!reset_n)
    qreg<=1'b0;
    else
    qreg<=qnext;
end
always @(s,I,qreg,msb,lsb) begin
    qnext=qreg; //initial
    case (s)
    2'b00:qnext=qreg;
    2'b01:qnext={msb,qreg[n-1:1]};
    2'b10:qnext={qreg[n-2:0],lsb};
    2'b11:qnext=I;
    default:qnext=qreg;
    endcase
    
end
assign q=qreg;
    
endmodule