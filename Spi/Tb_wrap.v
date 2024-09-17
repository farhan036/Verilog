module tb_wrapper;

    // Testbench signals
    reg MOSI;
    reg [1:0] SS_n;  // Adjusted to 2-bit as per your original testbench
    reg clk;
    reg rst_n;
    wire MISO;

    // Instantiate the wrapper module
    wrapper uut (
        .MOSI(MOSI),
        .SS_n(SS_n),
        .clk(clk),
        .rst_n(rst_n),
        .MISO(MISO)
    );

    integer i;

    // Clock generation
    always #5 clk = ~clk;

    initial begin
        // Initialize signals
        clk = 0;
        rst_n = 0;

        // Test reset behavior
        for (i = 0; i < 10; i = i + 1) begin
            MOSI = $random;
            if (MISO != 1'b0) $display("error in rst");
            @(negedge clk);
        end

        // Release reset
        rst_n = 1; @(negedge clk);

        // Write address
        SS_n = 2'b00; @(negedge clk); // Adjusted for 2-bit SS_n
        MOSI = 1'b0; @(negedge clk);
        MOSI = 1'b0; @(negedge clk);
        MOSI = 1'b0; @(negedge clk);
        MOSI = 1'b1; @(negedge clk);
        MOSI = 1'b1; @(negedge clk);
        MOSI = 1'b1; @(negedge clk);
        MOSI = 1'b1; @(negedge clk);
        MOSI = 1'b1; @(negedge clk);
        MOSI = 1'b1; @(negedge clk);
        MOSI = 1'b1; @(negedge clk);
        MOSI = 1'b1; @(negedge clk);
        MOSI = 1'b1; SS_n = 2'b01; @(negedge clk); // Deactivate chip select

        MOSI = 'z; @(negedge clk);
        SS_n = 2'b01; @(negedge clk);

        // Write data
        SS_n = 2'b00; @(negedge clk); // Activate chip select
        MOSI = 1'b0; @(negedge clk);
        MOSI = 1'b0; @(negedge clk);
        MOSI = 1'b1; @(negedge clk);
        MOSI = 1'b1; @(negedge clk);
        MOSI = 1'b1; @(negedge clk);
        MOSI = 1'b1; @(negedge clk);
        MOSI = 1'b1; @(negedge clk);
        MOSI = 1'b1; @(negedge clk);
        MOSI = 1'b1; @(negedge clk);
        MOSI = 1'b1; @(negedge clk);
        SS_n = 2'b01; @(negedge clk); // Deactivate chip select

        MOSI = 'z; @(negedge clk);
        SS_n = 2'b01; @(negedge clk);

        // Read address
        SS_n = 2'b00; @(negedge clk); // Activate chip select
        MOSI = 1'b1; @(negedge clk);
        MOSI = 1'b1; @(negedge clk);
        MOSI = 1'b0; @(negedge clk);
        MOSI = 1'b0; @(negedge clk);
        MOSI = 1'b0; @(negedge clk);
        MOSI = 1'b1; @(negedge clk);
        MOSI = 1'b1; @(negedge clk);
        MOSI = 1'b1; @(negedge clk);
        MOSI = 1'b1; @(negedge clk);
        MOSI = 1'b1; @(negedge clk);
        MOSI = 1'b1; @(negedge clk);
        SS_n = 2'b01; @(negedge clk); // Deactivate chip select

        MOSI = 'z; @(negedge clk);
        SS_n = 2'b01; @(negedge clk);

        // Read data
        SS_n = 2'b00; @(negedge clk); // Activate chip select
        MOSI = 1'b1; @(negedge clk);
        MOSI = 1'b1; @(negedge clk);
        MOSI = 1'b1; @(negedge clk);
        MOSI = 1'b1; @(negedge clk);
        MOSI = 1'b1; @(negedge clk);
        MOSI = 1'b1; @(negedge clk);
        MOSI = 1'b1; @(negedge clk);
        MOSI = 1'b1; @(negedge clk);
        MOSI = 1'b1; @(negedge clk);
        MOSI = 1'b1; @(negedge clk);

        for (i = 0; i < 8; i = i + 1) begin
            @(negedge clk);
        end

        SS_n = 2'b01;

        // Finish simulation
        #100;
        $finish;
    end

endmodule
