module bram_dual_port_ram #(
    parameter ADDR_WIDTH=10,DATA_WIDTH=8
) (
    input we_a,we_b,clk,
    input [ADDR_WIDTH-1:0] addr_a,addr_b,
    input [DATA_WIDTH-1:0] din_a,din_b,
    output reg [DATA_WIDTH-1:0] dout_a,dout_b
);
    reg [DATA_WIDTH-1:0] memory [0:2**ADDR_WIDTH-1];
    // port a
always @(posedge clk) begin
    if(we_a)
    memory[addr_a]<=din_a;
     dout_a<=memory[addr_a];
end
// port b
always @(posedge clk) begin
    if(we_b)
    memory[addr_b]<=din_b;
    dout_b<=memory[addr_b];
end
 


endmodule