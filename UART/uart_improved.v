`timescale 1ns / 1ps
module uart_improved #(
    parameter DBIT=8, SB_TICK=16 // # stop bit ticks
) (
    input clk, reset_n,
    // receiver port
    input rd_uart,
    input rx,
    output rx_empty,
    output [DBIT-1:0] r_data,
    // transmitter port
    input [DBIT-1:0] w_data,
    input wr_uart,
    output tx, tx_full,
    // timer
    input [10:0] TIMER_FINAL_VALUE
);
    // Timer
    wire tick;
    Timer #(.bits(11)) baud_rate(
        .clk(clk),
        .reset_n(reset_n),
        .TIMER_FINAL_VALUE(TIMER_FINAL_VALUE),
        .enable(1'b1),
        .done(tick)
    );

    // Receiver
    wire rx_done_tick;
    wire [DBIT-1:0] rx_dout;
    rx #(.DBIT(DBIT), .SB_TICK(SB_TICK)) rx1(
        .clk(clk),
        .reset_n(reset_n),
        .rx(rx),
        .s_tick(tick),
        .rx_done_tick(rx_done_tick),
        .rx_dout(rx_dout)
    );

    // Directly assign received data
    assign r_data = (rd_uart && rx_done_tick) ? rx_dout : {DBIT{1'b0}};
    assign rx_empty = !(rd_uart && rx_done_tick);

    // Transmitter
    wire tx_done_tick;
    wire tx_start;
    wire [DBIT-1:0] tx_din;
    tx #(.DBIT(DBIT), .SB_TICK(SB_TICK)) tx1(
        .clk(clk),
        .reset_n(reset_n),
        .s_tick(tick),
        .tx_start(tx_start),
        .tx_din(tx_din),
        .tx(tx),
        .tx_done_tick(tx_done_tick)
    );

    // Directly handle write data
    assign tx_din = w_data;
    assign tx_start = wr_uart;
    assign tx_full = 1'b0; // No FIFO, so tx_full is always 0

endmodule
