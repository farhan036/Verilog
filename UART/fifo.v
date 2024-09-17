module fifo #(
    parameter DATA_WIDTH = 8, // Width of data (DBIT in UART module)
    parameter ADDR_WIDTH = 4  // Address width, defines FIFO depth (2^ADDR_WIDTH)
)(
    input wire clk,              // System clock
    input wire rst_n,            // Active-low reset
    input wire wr_en,            // Write enable
    input wire rd_en,            // Read enable
    input wire [DATA_WIDTH-1:0] din, // Data input
    output wire [DATA_WIDTH-1:0] dout, // Data output
    output wire empty,           // Empty flag
    output wire full             // Full flag
);

    // FIFO depth is 2^ADDR_WIDTH
    localparam DEPTH = (1 << ADDR_WIDTH);

    // Memory to store the data
    reg [DATA_WIDTH-1:0] fifo_mem [0:DEPTH-1];

    // Read and write pointers
    reg [ADDR_WIDTH-1:0] rd_ptr, wr_ptr;

    // Full and empty flags
    reg full_reg, empty_reg;

    // Write and read operations
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            wr_ptr <= 0;
            rd_ptr <= 0;
            full_reg <= 1'b0;
            empty_reg <= 1'b1;
        end
        else begin
            // Write operation
            if (wr_en && !full_reg) begin
                fifo_mem[wr_ptr] <= din;
                wr_ptr <= wr_ptr + 1;
            end

            // Read operation
            if (rd_en && !empty_reg) begin
                rd_ptr <= rd_ptr + 1;
            end

            // Update full and empty flags
            if ((wr_ptr + 1) == rd_ptr) begin
                full_reg <= 1'b1;
            end else begin
                full_reg <= 1'b0;
            end

            if (wr_ptr == rd_ptr) begin
                empty_reg <= 1'b1;
            end else begin
                empty_reg <= 1'b0;
            end
        end
    end

    // Assign output signals
    assign dout = fifo_mem[rd_ptr];
    assign full = full_reg;
    assign empty = empty_reg;

endmodule
