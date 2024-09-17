module Mux4 #(
    parameter n=4
) (
    input [1:0] sel,
    input[n-1:0] w,
    output reg [n-1:0] f
);
always @(*) begin
f='bx;
    case (sel)
        2'b00: f=w[0]; 
        2'b01: f=w[1];
        2'b10: f=w[2];
        2'b11: f=w[3];
        default: f='bx;
    endcase
end
    
endmodule