module tb_fifo;

    // Parameters
    localparam DATA_WIDTH = 8;
    localparam ADDR_WIDTH = 4;

    // Testbench signals
    reg clk;
    reg rst_n;
    reg wr_en;
    reg rd_en;
    reg [DATA_WIDTH-1:0] din;
    wire [DATA_WIDTH-1:0] dout;
    wire empty;
    wire full;

    // Instantiate FIFO
    fifo #(
        .DATA_WIDTH(DATA_WIDTH),
        .ADDR_WIDTH(ADDR_WIDTH)
    ) fifo_inst (
        .clk(clk),
        .rst_n(rst_n),
        .wr_en(wr_en),
        .rd_en(rd_en),
        .din(din),
        .dout(dout),
        .empty(empty),
        .full(full)
    );

    // Clock generation
    always begin
        #5 clk = ~clk; // 10 time units clock period
    end

    // Test sequence
    initial begin
        // Initialize signals
        clk = 0;
        rst_n = 0;
        wr_en = 0;
        rd_en = 0;
        din = 0;

        // Apply reset
        #10;
        rst_n = 1;

        // Test writing to FIFO
        #10;
        wr_en = 1;
        din = 8'hAA; // Example data
        #10;
        din = 8'hBB;
        #10;
        din = 8'hCC;
        #10;
        wr_en = 0;

        // Test reading from FIFO
        #10;
        rd_en = 1;
        #10;
        rd_en = 0;

        // Test full and empty flags
        #10;
        wr_en = 1;
        din = 8'hDD;
        #10;
        wr_en = 0;
        #10;
        rd_en = 1;
        #10;
        rd_en = 0;

        // Check FIFO state
        #10;
        $finish;
    end

    // Monitor signals
    initial begin
        $monitor("Time: %0t | clk: %b | rst_n: %b | wr_en: %b | rd_en: %b | din: %h | dout: %h | empty: %b | full: %b",
                 $time, clk, rst_n, wr_en, rd_en, din, dout, empty, full);
    end

endmodule
