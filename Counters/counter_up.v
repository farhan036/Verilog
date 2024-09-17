module counterup (
    input clk,reset_n,
    output [3:0] q
);
Tff T1(
.clk(clk),
.T(1'b1),
.reset_n(reset_n),
.q(q[0])
);
Tff T2(
.clk(~q[0]),
.T(1'b1),
.reset_n(reset_n),
.q(q[1])
);
Tff T3(
.clk(~q[1]),
.T(1'b1),
.reset_n(reset_n),
.q(q[2])
);
Tff T4(
.clk(~q[2]),
.T(1'b1),
.reset_n(reset_n),
.q(q[3])
);
    
endmodule