module shift_register #(parameter n=4)(
    input SI,clk,
    input load,reset_n,
    input[n-1:0] I,
    output so,
    output [n-1:0] q
);
reg [n-1:0] qnext,qreg;

always @(posedge clk,negedge reset_n) begin
    if(!reset_n)
    qreg<=1'b0;
    else
    qreg<=qnext;
end
always @(load,qreg,SI,I) begin
    if(load)
    qnext=I;
    else
    qnext={SI,qreg[n-1:1]}; //shift right
    //qnext ={qreg[n-2:0],SI};
end
assign q=qreg;
assign so=qreg[0]; //as shift right

    
endmodule