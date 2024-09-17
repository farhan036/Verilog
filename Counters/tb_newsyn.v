module tb_counterup;
    // Inputs
    reg clk;
    reg reset_n;

    // Outputs
    wire [3:0] q;

    // Instantiate the counterup module
    counterup uut (
        .clk(clk),
        .reset_n(reset_n),
        .q(q)
    );

    // Clock generation
    always #5 clk = ~clk; // Toggle clock every 5 time units (period = 10 units)

    initial begin
        // Initialize inputs
        clk = 0;
        reset_n = 0;

        // Apply reset
        #10;
        reset_n = 1;

        // Observe counter operation
        #100;

        // Apply reset again to check reset functionality
        reset_n = 0;
        #10;
        reset_n = 1;

        // Run for more time to observe counter behavior
        #100;

        // Finish simulation
        $stop;
    end

    // Monitor outputs
    initial begin
        $monitor("At time %t: q = %b, reset_n = %b", $time, q, reset_n);
    end
endmodule
