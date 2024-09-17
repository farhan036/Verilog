module mux4_1_u(
input x0,x1,x2,x3,s0,s1,
output f
);               // we can use any implementation of mux behav,dataflow ,structural
wire g0,g1; //writing m0 m1 m2 is mandatory 
mux2_1behav m0    
(
.x1(x0),  //using .() we don't need to check the order of parameter
.x2(x1),
.s(s0),
.f(g0)
);
mux2_1 m1(x2,s0,x3,g1); //we must take care of order
mux2_1_data m2(
.x1(g0),
.x2(g1),
.s(s1),
.f(f)
);

endmodule