module multiadder  (
    input [15:0] a,b, //adder 16 bits
    output [15:0] sum_ab,
    output cout_ab,
    input [33:0] x,y, //adder 34 bits
    output [33:0] sum_xy,
    output cout_xy
);
rca_nbit #(.n(16)) adder_16 (
.x(a),
.y(b),
.cin(0),
.s(sum_ab),
.cout(cout_ab)
);
rca_nbit #(.n(34)) adder_34 (
.x(x),
.y(y),
.cin(0),
.s(sum_xy),
.cout(cout_xy)
);




    
endmodule