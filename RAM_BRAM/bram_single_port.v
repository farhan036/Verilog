module bram_single_port_ram #(
    parameter ADDR_WIDTH=10,DATA_WIDTH=8
) (
    input we_a,clk,
    input [ADDR_WIDTH-1:0] addr_a,
    input [DATA_WIDTH-1:0] din_a,
    output reg [DATA_WIDTH-1:0] dout_a
);
    reg [DATA_WIDTH-1:0] memory [0:2**ADDR_WIDTH-1];
    // port a
always @(posedge clk) begin
    if(we_a)
    memory[addr_a]<=din_a;
     dout_a<=memory[addr_a];
end



endmodule