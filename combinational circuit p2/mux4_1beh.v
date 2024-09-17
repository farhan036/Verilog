module mux4_1b #(parameter n=3) (
    input [n-1:0] w3,w2,w1,w0,
    input [1:0] s,
    output reg [n-1:0] f
);
always @(w3,w2,w1,w0,s)
begin
case(s)
2'b00:f=w0;
2'b01:f=w1;
2'b10:f=w2;
2'b11:f=w3;
default:f='bx;
endcase
/*
another way
f=s[1]?(s[0]?w3:w2 ):(s[0]? w1:w0);
or do if-else
*/

end
    
endmodule