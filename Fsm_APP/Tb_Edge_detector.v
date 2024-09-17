module tb_Edge_detector();
    // Testbench signals
    reg reset_n;
    reg clk;
    reg level;
    wire p_edge;
    wire n_edge;
    wire _edge;

    // Instantiate the Edge_detector module
    Edge_detector uut (
        .reset_n(reset_n),
        .clk(clk),
        .level(level),
        .p_edge(p_edge),
        .n_edge(n_edge),
        ._edge(_edge)
    );

    // Clock generation
    always begin
        #5 clk = ~clk;  // Toggle clock every 5 time units (100 MHz)
    end

    // Test sequence
    initial begin
        // Initialize signals
        clk = 0;
        reset_n = 0;
        level = 0;

        // Apply reset
        #10 reset_n = 1;  // Release reset after 10 time units

        // Test case 1: Level stays low
        #10 level = 0;
        #20;

        // Test case 2: Rising edge
        #10 level = 1;
        #20;

        // Test case 3: Level stays high
        #10 level = 1;
        #20;

        // Test case 4: Falling edge
        #10 level = 0;
        #20;

        // Test case 5: Reset in the middle
        #10 reset_n = 0;  // Assert reset
        #10 reset_n = 1;  // Release reset
        #20;

        // Test case 6: Another rising edge after reset
        #10 level = 1;
        #20;

        // Test case 7: Another falling edge
        #10 level = 0;
        #20;

        // End simulation
        $stop;
    end
endmodule
