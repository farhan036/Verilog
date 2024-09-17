module mux2_1 (
    input x1,s,x2,
    output f
);   //structural modeling
    not  (sn,s);
    and A0  (g0,x1,sn); 
    and A1 (g1,x2,s);
    or  O0   (f,g0,g1);

endmodule