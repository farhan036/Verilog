module rca_nbit
#(parameter n =4 )
(
input [n-1:0] x,y,
input cin,
output [n-1:0] s,
output cout

);
wire [n:0] c;
assign c[0]=cin;
 generate  // we use it when we use for loop

    genvar k;  //as int k in c
    for (k =0 ;k<n ;k=k+1 ) begin
        full_adder f0(
            .xi(x[k]),
            .yi(y[k]),
            .ci(c[k]),
            .si(s[k]),
            .co(c[k+1])
        );

    end
assign cout=c[n];






 endgenerate







endmodule