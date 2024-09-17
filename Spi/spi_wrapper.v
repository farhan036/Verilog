module wrapper (
    input MOSI,
    input [1:0] SS_n,
    input clk,rst_n,
    output MISO
);
wire [9:0] rx_data;
wire rx_valid;
wire [7:0] tx_data;
wire tx_valid;


ram_spi#(.adder_width(8),.data_width(8)) ram1(
.din(rx_data),
.rx_valid(rx_valid),
.dout(tx_data),
.tx_valid(tx_valid),
.clk(clk),
.rst_n(rst_n)
);



spi_slave slave1(
.rx_data(rx_data),
.rx_valid(rx_valid),
.tx_data(tx_data),
.tx_valid(tx_valid),
.clk(clk),
.rst_n(rst_n),
.MOSI(MOSI),
.SS_n(SS_n),
.MISO(MISO)
);
    
endmodule