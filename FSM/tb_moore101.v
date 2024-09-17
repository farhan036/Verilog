module tb_moore101;

    reg clk;
    reg reset_n;
    reg x;
    wire y;

    // Instantiate the DUT (Design Under Test)
    moore101 uut (
        .clk(clk),
        .reset_n(reset_n),
        .x(x),
        .y(y)
    );

    // Clock generation
    always begin
        #5 clk = ~clk;  // 100MHz clock (10ns period)
    end

    initial begin
        // Initial values
        clk = 0;
        reset_n = 0;
        x = 0;

        // Reset the design
        #10 reset_n = 1;

        // Test cases for the pattern "101"
        // Pattern 101 -> y should be 1 after detecting "101"
        x = 0; #10;
        x = 1; #10;
        x = 0; #10;
        x = 1; #10;  // "101" detected here, y should be 1
        x = 0; #10;  // y should return to 0
        
        // Additional test cases
        x = 1; #10;
        x = 1; #10;  // No "101" pattern, y should stay 0
        x = 0; #10;
        x = 1; #10;  // Another "101", y should be 1

        // Reset again
        reset_n = 0; #10;
        reset_n = 1; #10;

        // Random input patterns
        x = 1; #10;
        x = 0; #10;
        x = 1; #10;
        x = 0; #10;
        x = 1; #10;  // Another "101" pattern
        $finish;      // End simulation
    end

endmodule
