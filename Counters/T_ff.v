module Tff (
input T,clk,reset_n,
output q
);
reg qreg;
wire qnext;
always @(posedge clk,negedge reset_n) begin
    if(!reset_n)
    qreg<=1'b0;
else
qreg<=qnext;
end
   assign  qnext=T?~qreg:qreg;

assign q=qreg;
    
endmodule