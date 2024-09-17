module arithmetic #(parameter n=4) (
    input [n-1:0] x,y,
    output [n-1:0] s,
    output cout,overflow
);
wire [n:0] sum; //store all carry
assign sum={1'b0,x}+{1'b0,y}; //add binary 0 to x and y number so will be 5 bit  (new value concatenate)xxxx 
// if x= 1010 so {1'b0,x} mean use 01010;
//assign sum=x+y; we can use this because verilog check length of x and y and sum if sum bigger then x any y will expand to length of sum
assign s=sum[n-1:0];
assign cout=sum[n];
/* way another this assign s=sum[n-1:0];
assign cout=sum[n]; 
is
assign {cout,s}=x+y;
*/
assign overflow=sum[n-1] ^ cout;
// another way     assign overflow = (x[n-1] & y[n-1] & ~s[n-1] | ~x[n-1] & ~xored_y[n-1]& s[n-1]); 

    
endmodule