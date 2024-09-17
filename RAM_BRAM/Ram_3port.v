module ram_3_port #(parameter ADDR_WIDTH = 3,DATA_WIDTH=8) (
    input [ADDR_WIDTH-1:0] r_addr0,r_addr1,
    input [ADDR_WIDTH-1:0] w_addr,
    input [DATA_WIDTH-1:0] w_data,
    input we,clk,
    output [DATA_WIDTH-1:0] r_data0,
    output [DATA_WIDTH-1:0] r_data1

);
    // memory
    reg [DATA_WIDTH-1:0] memory [0:2 ** ADDR_WIDTH-1];
    always @(posedge clk) begin
        if(we)
        memory[w_addr]<=w_data;
    end
    assign r_data0 = memory[r_addr0];
    assign r_data1 = memory[r_addr1];


endmodule