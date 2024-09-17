module tb_bcd;

// Declare inputs as regs and outputs as wires
reg clk, reset_n, up, enable;
wire [3:0] q;
wire done;

// Instantiate the BCD module
bcd UUT (
    .clk(clk),
    .reset_n(reset_n),
    .up(up),
    .enable(enable),
    .done(done),
    .q(q)
);

// Clock generation
initial begin
    clk = 0;
    forever #5 clk = ~clk;  // 100MHz clock, period = 10ns
end

// Test procedure
initial begin
    // Initialize signals
    reset_n = 0;
    up = 1;  // Assuming the up signal is used for counting up
    enable = 0;

    // Apply reset
    #10 reset_n = 1;    // Release reset after 10ns
    #10 enable = 1;     // Enable counting after 10ns

    // Wait for counting to complete and observe done signal
    wait (done == 1);
    #10;  // Small delay to observe 'done' behavior

    // Apply another reset to restart counting
    reset_n = 0;
    #10 reset_n = 1;
    #10 enable = 1;

    // Wait for the second cycle to complete
    wait (done == 1);
    #10;

    // Finish simulation
    $stop;
end

// Monitor output
initial begin
    $monitor("Time = %0t | reset_n = %b | enable = %b | q = %b | done = %b",
              $time, reset_n, enable, q, done);
end

endmodule
