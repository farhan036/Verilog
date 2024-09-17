module Lfsr #(
    parameter n=3
) (
    input clk,reset_n,
    output [1:n] Q
);
    reg [1:n] Q_reg,Q_next;
    wire taps;
always @(posedge clk,negedge reset_n) begin
    if(!reset_n)
    Q_reg=1;
    else
    Q_reg<=Q_next;
end
assign taps=Q_reg[3] ^ Q_reg[2];
always @(taps,Q_reg) begin
    Q_next={taps,Q_reg[1:n-1]};
end
assign Q=Q_reg;



endmodule