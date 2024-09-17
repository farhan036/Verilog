`timescale 1ns / 1ps
module uart #(
    parameter DBIT=8,SB_TICK=16 // # stop bit ticks
) (
    input clk,reset_n,
    // receiver port
    input rd_uart,
    input rx,
    output rx_empty,
    output [DBIT-1:0] r_data,
    // transimitter port
    input [DBIT-1:0] w_data,
    input wr_uart,
    output tx,tx_full,
    //timer
    input [10: 0] TIMER_FINAL_VALUE
);
    //Timer
    wire tick;
    Timer #(.bits(11)) baud_rate(
        .clk(clk),
        .reset_n(reset_n),
        .TIMER_FINAL_VALUE(TIMER_FINAL_VALUE),
        .enable(1'b1),
        .done(tick)
    );
    wire rx_done_tick;
    wire [DBIT-1:0] rx_dout;
    // receiver
    rx #(.DBIT(DBIT),.SB_TICK(SB_TICK)) rx1(
        .clk(clk),
        .reset_n(reset_n),
        .rx(rx),
        .s_tick(tick),
        .rx_done_tick(rx_done_tick),
        .rx_dout(rx_dout)

    );

    //fifo_rx
    fifo f_rx (
        .clk(clk),          // Connect system clock
        .rst_n(~reset_n),      // Connect active-low reset
        .wr_en(rx_done_tick),      // Connect write enable signal
        .rd_en(rd_uart),      // Connect read enable signal
        .din(rx_dout),      // Connect input data (8 bits)
        .dout(r_data),    // Connect output data (8 bits)
        .empty(rx_empty), // Connect empty flag
        .full()    // Connect full flag
    );
    
   //transimitter
   wire tx_fifo_empty;
   wire [DBIT-1:0] tx_din;
   wire tx_done_tick;
 tx #(.DBIT(DBIT),.SB_TICK(SB_TICK)) tx1(
        .clk(clk),
        .reset_n(reset_n),
        .s_tick(tick),
        .tx_start(~tx_fifo_empty),
        .tx_din(tx_din),
        .tx(tx),
        .tx_done_tick(tx_done_tick)

 );


   //fifo_tx
fifo f_tx (
        .clk(clk),          // Connect system clock
        .rst_n(~reset_n),      // Connect active-low reset
        .wr_en(wr_uart),      // Connect write enable signal
        .rd_en(tx_done_tick),      // Connect read enable signal
        .din(w_data),      // Connect input data (8 bits)
        .dout(tx_din),    // Connect output data (8 bits)
        .empty(tx_fifo_empty), // Connect empty flag
        .full(tx_full)    // Connect full flag
    );



endmodule