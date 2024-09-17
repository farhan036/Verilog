module compare_storage_elements (
    input D,clk,
    output qa,qpos,qneg
);

d_latch d0(
.D(D),
.clk(clk),
.q(qa),
.q_b(~qa)

);
d_posff d1(
.D(D),
.clk(clk),
.q(qb),
.q_b(~qb)

);
d_negff d2(
.D(D),
.clk(clk),
.q(qc),
.q_b(~qc)
);







endmodule