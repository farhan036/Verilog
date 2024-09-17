module tb_Alu;
    // Parameters for the ALU
    parameter BITS = 4;
    parameter INPUT_PRIORITY = 1;
    parameter FULL_ADDER = 1'b1;

    // Inputs
    reg [BITS-1:0] A, B;
    reg cin, red_op_A, red_op_B, bypass_A, bypass_B;
    reg [2:0] opcode;

    // Outputs
    wire [BITS:0] Out;
    wire Odd_parity;
    wire Invalid;

    // Instantiate the ALU
    Alu #(
        .bits(BITS),
        .INPUT_PRIORITY(INPUT_PRIORITY),
        .FULL_ADDER(FULL_ADDER)
    ) uut (
        .A(A),
        .B(B),
        .cin(cin),
        .red_op_A(red_op_A),
        .red_op_B(red_op_B),
        .bypass_A(bypass_A),
        .bypass_B(bypass_B),
        .opcode(opcode),
        .Out(Out),
        .Odd_parity(Odd_parity),
        .Invalid(Invalid)
    );

    // Randomization function
    task randomize_inputs;
        begin
            A = $urandom_range(0, (2**BITS)-1);
            B = $urandom_range(0, (2**BITS)-1);
            cin = $urandom_range(0, 1);
            red_op_A = $urandom_range(0, 1);
            red_op_B = $urandom_range(0, 1);
            bypass_A = $urandom_range(0, 1);
            bypass_B = $urandom_range(0, 1);
            opcode = $urandom_range(0, 7);
        end
    endtask

    // Testbench procedure
    initial begin
        // Randomize inputs and apply test cases
        repeat (100) begin
            // Randomize inputs
            randomize_inputs;

            // Apply random inputs
            #10;
            $display("Random Test: A = %b, B = %b, cin = %b, red_op_A = %b, red_op_B = %b, bypass_A = %b, bypass_B = %b, opcode = %b, Out = %b, Odd_parity = %b, Invalid = %b",
                A, B, cin, red_op_A, red_op_B, bypass_A, bypass_B, opcode, Out, Odd_parity, Invalid);
        end

        // Test all invalid opcodes
        // Invalid opcodes: 3'b110 and 3'b111
        opcode = 3'b110;
        #10;
        $display("Invalid Opcode Test: opcode = %b, Out = %b, Odd_parity = %b, Invalid = %b", opcode, Out, Odd_parity, Invalid);

        opcode = 3'b111;
        #10;
        $display("Invalid Opcode Test: opcode = %b, Out = %b, Odd_parity = %b, Invalid = %b", opcode, Out, Odd_parity, Invalid);

        // Finish simulation
        $finish;
    end
endmodule
