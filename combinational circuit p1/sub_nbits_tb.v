module sub_nbits_tb (

);
parameter n=4;
reg [n-1:0] x,y;
    reg cin;  
    wire [n-1:0] s;
    wire cout,overflow;
    
sub_nbits #(.n(n)) uut(
.x(x),
.y(y),
.cin(cin),
.s(s),
.cout(cout),
.overflow(overflow)
);
initial begin
    #40 $finish;

end
initial begin
    x=4'd5;
    y=4'd6;
    cin=1'b0;
    #10
    cin=1'b1;
    #10
    x=4'd6;
    y=-4'd3;
     #10
    x=-4'd4;
    y=-4'd5;
    cin=1'b0;
    #10;
    
end
initial begin
    
$monitor("Time = %3d , x = %d , y = %d , s = %d , cout = %1b , cin = %1b , overflow = %1b ",$Time,x,y,s,cout,cin,overflow);



end


endmodule