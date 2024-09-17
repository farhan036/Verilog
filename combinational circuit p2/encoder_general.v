module encoder_general #( parameter n=4) (
    input [n-1:0] w,
    output z,
    output reg [$clog2(n)-1:0] y // c as ceiling
);
assign z=|w;
integer k;
always @(w)
begin
    y='bx;
    for(k=0;k<n;k=k+1)
    begin
        if(w[k])
        y=k;


    end




end





    
endmodule