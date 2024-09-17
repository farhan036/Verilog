module sub_4bits 
(
input [3:0] x,y,
input cin,
output [3:0] s,
output cout
);
wire [3:0] xored_y;
assign xored_y[0]=y[0] ^ cin;
assign xored_y[1]=y[1] ^ cin;
assign xored_y[2]=y[2] ^ cin;
assign xored_y[3]=y[3] ^ cin;
rca_nbit #(.n(4)) sub0(
.x(x),
.y(xored_y),
.cin(cin),
.s(s),
.cout(cout)
);

endmodule