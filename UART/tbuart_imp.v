`timescale 1ns / 1ps

module tb_uart_improved;

    // Testbench signals
    reg clk;
    reg reset_n;
    reg rd_uart;
    reg rx;
    reg [7:0] w_data;
    reg wr_uart;
    wire rx_empty;
    wire [7:0] r_data;
    wire tx;
    wire tx_full;
    reg [10:0] TIMER_FINAL_VALUE;

    // Instantiate the UART module
    uart_improved #(
        .DBIT(8),
        .SB_TICK(16)
    ) uut (
        .clk(clk),
        .reset_n(reset_n),
        .rd_uart(rd_uart),
        .rx(rx),
        .rx_empty(rx_empty),
        .r_data(r_data),
        .w_data(w_data),
        .wr_uart(wr_uart),
        .tx(tx),
        .tx_full(tx_full),
        .TIMER_FINAL_VALUE(TIMER_FINAL_VALUE)
    );

    // Clock generation
    always #5 clk = ~clk; // 100 MHz clock

    // Test procedure
    initial begin
        // Initialize signals
        clk = 0;
        reset_n = 0;
        rd_uart = 0;
        rx = 1;
        w_data = 8'h00;
        wr_uart = 0;
        TIMER_FINAL_VALUE = 11'd1000; // Example value

        // Apply reset
        #10 reset_n = 1;
        #10 reset_n = 0;
        #10 reset_n = 1;

        // Test 1: Write and send data
        w_data = 8'hA5; // Example data
        wr_uart = 1;
        #10 wr_uart = 0;

        // Simulate transmitter activity
        wait (tx); // Wait for the tx signal to be high
        #10; // Wait for data to be sent
        rx = 0; // Start receiving a bit (e.g., start bit)
        #10 rx = 1; // Stop receiving a bit (simulate data bits)
        #100; // Wait for the byte to be received

        // Test 2: Read received data
        rd_uart = 1;
        #10;
        $display("Received Data: %h", r_data);
        rd_uart = 0;

        // End simulation
        #100 $stop;
    end

endmodule
