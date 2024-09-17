module tb_spi_slave;
    reg MOSI, tx_valid, rst_n, clk;
    reg [7:0] tx_data;
    reg [1:0] SS_n;
    wire MISO;
    wire rx_valid;
    wire [9:0] rx_data;

    // Instantiate the SPI slave module
    spi_slave uut (
        .MOSI(MOSI),
        .tx_valid(tx_valid),
        .rst_n(rst_n),
        .clk(clk),
        .tx_data(tx_data),
        .SS_n(SS_n),
        .MISO(MISO),
        .rx_valid(rx_valid),
        .rx_data(rx_data)
    );

    // Clock generation
    always #5 clk = ~clk;  // Clock with a period of 10 units

    // Testbench sequence
    initial begin
        // Initialize inputs
        MOSI = 0;
        tx_valid = 0;
        rst_n = 0;
        clk = 0;
        tx_data = 8'b0;
        SS_n = 2'b0;  // Slave select is inactive

        // Reset the design
        #10;
        rst_n = 1;  // Release reset

        // SPI write operation
        #10;
        SS_n = 2'b00;  // Slave select active (chip select)
        MOSI = 1'b0;   // cmd
        #10;
        SS_n = 2'b00;  // Slave select active (chip select)
        MOSI = 1'b1;   //case write
        #10;
        MOSI = 1'b1; //1001010101
        #10;
        MOSI = 1'b1; //1101010101
        #10;
        MOSI = 1'b0;
        #10;
        MOSI = 1'b1;
        #10;
        MOSI = 1'b0;
        #10;
        MOSI = 1'b1;
        #10;
        MOSI = 1'b0;
        #10;
        MOSI = 1'b0;
        #10;
        MOSI = 1'b0;
        #10;
        SS_n = 2'b11;  
        #10;
        SS_n = 2'b0;
        MOSI = 1'b0; //cmd
        #10;
        SS_n = 2'b00;  // Slave select active (chip select)
        MOSI = 1'b1;   //case write
        #10;
        MOSI = 1'b1; //1001010101
        #10;
        MOSI = 1'b1; //1101010101
        #10;
        MOSI = 1'b0;
        #10;
        MOSI = 1'b1;
        #10;
        MOSI = 1'b0;
        #10;
        MOSI = 1'b1;
        #10;
        MOSI = 1'b0;
        #10;
        MOSI = 1'b0;
        #10;
        MOSI = 1'b0;
        #10;
        SS_n = 2'b11;


        // Wait a bit
        #50;

        // SPI read operation
        /*tx_data = 8'b10101010;  // Data to read from SPI slave
        SS_n = 2'b00;  // Slave select active
        #10;           // Wait for one clock cycle
        SS_n = 2'b11;  // End the read operation
*/
        // Finish the simulation
        #100;
        $finish;
    end
endmodule
