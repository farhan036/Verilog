module simple_bram_dual_port_ram #(
    parameter ADDR_WIDTH=10,DATA_WIDTH=8
) (
    input we,clk,
    input [ADDR_WIDTH-1:0] addr_r,addr_w
    input [DATA_WIDTH-1:0] din,
    output reg [DATA_WIDTH-1:0] dout
);
    reg [DATA_WIDTH-1:0] memory [0:2**ADDR_WIDTH-1];
    // port a
always @(posedge clk) begin
    if(we)
    memory[addr_w]<=din;
     dout<=memory[addr_r];
end

 


endmodule