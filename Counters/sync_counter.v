module counterup (
    input clk,reset_n,
    output [3:0] q
);
wire q0next,q1next,q2next,q3next;
assign q0next=1'b1;
Tff T1(
.clk(clk),
.T(q0next),
.reset_n(reset_n),
.q(q[0])
);
assign q1next = q[0] & q0next;
Tff T2(
.clk(clk),
.T(q1next),
.reset_n(reset_n),
.q(q[1])
);
assign q2next = q1next & q[1];
Tff T3(
.clk(clk),
.T(q2next),
.reset_n(reset_n),
.q(q[2])
);
assign q3next = q2next & q[2];
Tff T4(
.clk(clk),
.T(q3next),
.reset_n(reset_n),
.q(q[3])
);
    
endmodule