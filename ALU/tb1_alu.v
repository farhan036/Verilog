module tb_Alu1;
    parameter bits = 4;
    
    // Inputs
    reg [bits-1:0] A, B;
    reg cin, red_op_A, red_op_B, bypass_A, bypass_B;
    reg [2:0] opcode;
    
    // Outputs
    wire [bits:0] Out;
    wire Odd_parity;
    wire Invalid;
    
    // Instantiate the ALU module
    Alu #(bits) uut (
        .A(A), .B(B), .cin(cin), .red_op_A(red_op_A), .red_op_B(red_op_B), 
        .bypass_A(bypass_A), .bypass_B(bypass_B), .opcode(opcode), 
        .Out(Out), .Odd_parity(Odd_parity), .Invalid(Invalid)
    );
    integer i;
    
    initial begin
        
        
        // Randomized test cases
        for (i = 0; i < 100; i = i + 1) begin
            A = $urandom_range(0, 2**bits-1);
            B = $urandom_range(0, 2**bits-1);
            cin = $urandom_range(0, 1);
            bypass_A = $urandom_range(0, 1);
            bypass_B = $urandom_range(0, 1);
            red_op_A = $urandom_range(0, 1);
            red_op_B = $urandom_range(0, 1);
            
            // Generate valid opcodes (0 to 5), plus include invalid ones (6, 7)
            if ($urandom_range(0, 1)) begin
                opcode = $urandom_range(0, 5);  // Valid opcodes
            end else begin
                opcode = $urandom_range(6, 7);  // Invalid opcodes
            end
            
            // Display the inputs and outputs
            #5;
            $display("A=%b, B=%b, cin=%b, bypass_A=%b, bypass_B=%b, red_op_A=%b, red_op_B=%b, opcode=%b | Out=%b, Invalid=%b", 
                      A, B, cin, bypass_A, bypass_B, red_op_A, red_op_B, opcode, Out, Invalid);
        end
        
        // Force invalid cases manually
        $display("Testing Invalid Cases...");
        
        // Invalid case: opcode 6
        opcode = 3'b110;
        A = $urandom_range(0, 2**bits-1);
        B = $urandom_range(0, 2**bits-1);
        bypass_A = 0;
        bypass_B = 0;
        red_op_A = 0;
        red_op_B = 0;
        #5;
        $display("Invalid case with opcode=110: Out=%b, Invalid=%b", Out, Invalid);
        
        // Invalid case: opcode 7
        opcode = 3'b111;
        A = $urandom_range(0, 2**bits-1);
        B = $urandom_range(0, 2**bits-1);
        bypass_A = 0;
        bypass_B = 0;
        red_op_A = 0;
        red_op_B = 0;
        #5;
        $display("Invalid case with opcode=111: Out=%b, Invalid=%b", Out, Invalid);
        
        // Invalid case: red_op_A or red_op_B used incorrectly for opcode 010, 011, 100, 101
        opcode = 3'b010;
        red_op_A = 1;
        red_op_B = 0;
        #5;
        $display("Invalid case with opcode=010 and red_op_A=1: Out=%b, Invalid=%b", Out, Invalid);
        
        opcode = 3'b011;
        red_op_A = 0;
        red_op_B = 1;
        #5;
        $display("Invalid case with opcode=011 and red_op_B=1: Out=%b, Invalid=%b", Out, Invalid);
        
        // Additional invalid cases can be added similarly.
        
        $finish;
    end
endmodule
