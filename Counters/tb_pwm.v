module Pwm_f_tb;

  // Parameters
  parameter n = 4;
  parameter Time_bit = 4;

  // Inputs
  reg clk;
  reg reset_n;
  reg [n:0] duty;
  reg [Time_bit-1:0] final_value;

  // Outputs
  wire [n-1:0] q;
  wire pwm_out;

  // Instantiate the PWM module
  Pwm_f #(.n(n), .Time_bit(Time_bit)) dut (
    .clk(clk),
    .reset_n(reset_n),
    .duty(duty),
    .final_value(final_value),
    .q(q),
    .pwm_out(pwm_out)
  );

  // Clock generation
  always begin
    #5 clk = ~clk;  // 10 time units clock period
  end

  // Test procedure
  initial begin
    // Initialize inputs
    clk = 0;
    reset_n = 0;
    duty = 0;
    final_value = 4'b1111;  // Max value for 4-bit timer

    // Reset the system
    #20;
    reset_n = 1;

    // Test with different duty cycles
    #10;
    duty = 5;  // Small duty cycle

    #100;
    duty = 10;  // Medium duty cycle

    #100;
    duty = 15;  // Almost full duty cycle

    #100;
    duty = 0;  // Zero duty cycle

    #100;
    duty = 16;  // Full duty cycle

    #100;

    // Finish the simulation
    $stop;
  end

  // Monitor the outputs for debugging
  initial begin
    $monitor("At time %t: duty = %d, pwm_out = %b, q = %d", 
             $time, duty, pwm_out, q);
  end

endmodule
