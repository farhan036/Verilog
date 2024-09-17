module full_adder (
input ci,xi,yi,
output si ,co
);
wire c1,c2,s;
half_adder h0(xi,yi,s,c1);
half_adder h1(
.x(ci),
.y(s),
.s(si),
.c(c2)
);
assign co =c1 |c2;




endmodule