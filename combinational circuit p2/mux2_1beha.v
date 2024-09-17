module mux2_1b #(parameter n=3) (
    input [n-1:0]w0,w1,
    input s,
    output reg [n-1:0] f //we use reg because we use always
);

always @(w0,w1,s) //we use always to run what is in it when w0 or w1 or s change
    begin
        f = s?w1:w0;
    end
    
endmodule