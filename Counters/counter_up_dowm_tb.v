module tb_counter_up_down;
    // Testbench parameters
    parameter bits = 4;

    // Testbench signals
    reg clk, reset_n, up, enable;
    wire [bits-1:0] q;

    // Instantiate the counter_up_down module
    counter_up_down #(bits) uut (
        .clk(clk),
        .reset_n(reset_n),
        .up(up),
        .enable(enable),
        .q(q)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk;  // 100 MHz clock (10 time units period)
    end

    // Test procedure
    initial begin
        // Initial values
        reset_n = 0;
        up = 0;
        enable = 0;

        // Apply reset
        #10 reset_n = 1;  // Release reset

        // Enable and count up
        #10 enable = 1; up = 1;
        #50;

        // Count down
        up = 0;
        #50;

        // Disable counting
        enable = 0;
        #20;

        // Enable and count up again
        enable = 1;
        up = 1;
        #50;

        // Finish simulation
        #10 $stop;
    end

    // Monitor output
    initial begin
        $monitor("Time = %0d | clk = %b | reset_n = %b | enable = %b | up = %b | q = %b",
                 $time, clk, reset_n, enable, up, q);
    end
endmodule
