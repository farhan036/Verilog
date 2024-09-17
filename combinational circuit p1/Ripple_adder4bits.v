module rca_4bit (
input [3:0] x,y,
input cin,
output [3:0] s,
output cout
);
wire [3:1] c;
full_adder f0 (
.ci(cin),
.xi(x[0]),
.yi(y[0]),
.si(s[0]),
.co(c[1])
);
full_adder f1 (
.ci(c[1]),
.xi(x[1]),
.yi(y[1]),
.si(s[1]),
.co(c[2])
);
full_adder f2 (
.ci(c[2]),
.xi(x[2]),
.yi(y[2]),
.si(s[2]),
.co(c[3])
);
full_adder f3 (
.ci(c[3]),
.xi(x[3]),
.yi(y[3]),
.si(s[3]),
.co(cout)
);





endmodule


