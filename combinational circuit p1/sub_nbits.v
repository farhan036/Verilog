module sub_nbits #(parameter n=4) 
(
    input [n-1:0] x,y,
    input cin, //if cin =0 is adder n bits if cin = 1 so is subtractor n bits 
    output [n-1:0] s,
    output cout,
    output overflow
);
wire [n-1:0] xored_y;

    generate
        genvar k;
        for( k = 0; k<n ; k=k+1)
        begin
        assign xored_y[k]=y[k] ^ cin;
        end
    endgenerate
rca_nbit #(.n(n)) sub0(
    .x(x),
    .y(xored_y),
    .cin(cin),
    .s(s),
    .cout(cout)
);
    assign overflow = (x[n-1] & xored_y[n-1] & ~s[n-1] | ~x[n-1] & ~xored_y[n-1]& s[n-1]); 

endmodule