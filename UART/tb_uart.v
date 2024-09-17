`timescale 1ns / 1ps

module uart_tb;
    // Parameters
    parameter DBIT = 8;
    parameter SB_TICK = 16;
    parameter TIMER_FINAL_VALUE = 650;

    // Testbench signals
    reg clk;
    reg reset_n;
    reg rd_uart;
    reg rx;
    wire rx_empty;
    wire [DBIT-1:0] r_data;
    reg [DBIT-1:0] w_data;
    reg wr_uart;
    wire tx;
    wire tx_full;
    reg [10:0] timer_final_value;

    // Clock generation
    always #5 clk = ~clk; // 100 MHz clock

    // Instantiate the UART module
    uart #(
        .DBIT(DBIT),
        .SB_TICK(SB_TICK)
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
        .TIMER_FINAL_VALUE(timer_final_value)
    );

    initial begin
        // Initialize signals
        clk = 0;
        reset_n = 0;
        rd_uart = 0;
        rx = 1;
        w_data = 0;
        wr_uart = 0;
        timer_final_value = TIMER_FINAL_VALUE;

        // Apply reset
        #20;
        reset_n = 1;

        // Transmit data
        #10;
        w_data = 8'hA5; // Example data
        wr_uart = 1;
        #10;
        wr_uart = 0;

        // Wait for transmission to complete
        wait(tx_full == 0);
        #50;

        // Read data
        rd_uart = 1;
        #10;
        rd_uart = 0;

        // Wait for reception to complete
        wait(rx_empty == 0);
        #50;

        // Simulate RX data
        rx = 0; // Start bit
        #10417; // Wait for half of a bit period
        rx = 1; // Data bit 1
        #10417;
        rx = 0; // Data bit 0
        #10417;
        rx = 1; // Data bit 1
        #10417;
        rx = 0; // Data bit 0
        #10417;
        rx = 1; // Data bit 1
        #10417;
        rx = 0; // Data bit 0
        #10417;
        rx = 1; // Data bit 1
        #10417;
        rx = 1; // Stop bit
        #10417;

        // Finish simulation
        #100;
        $finish;
    end

    // Monitor signals
    initial begin
        $monitor("Time: %0d, rx_empty: %b, r_data: %h, tx_full: %b, tx: %b", $time, rx_empty, r_data, tx_full, tx);
    end

endmodule
