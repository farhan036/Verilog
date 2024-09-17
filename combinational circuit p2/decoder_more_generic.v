module decoder_generic #(parameter n=3) (
    input [n-1:0] w,
    input en,
    output reg [0:2 ** n -1] y
);
    always @(w,en) begin
        y='b0;
        if(en)
        y[w]=1'b1;
        else
        y='b0;
    end



endmodule