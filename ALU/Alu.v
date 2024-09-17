module Alu #(
    parameter bits=4,INPUT_PRIORITY=1,FULL_ADDER=1'b1 //1 AS A 2 AS B & FULL_ADDER 1 AS ON
) (
    input [bits-1:0] A , B,
    input cin,red_op_A,red_op_B,bypass_A,bypass_B,
    input [2:0] opcode,
    output reg  [bits:0] Out,
    output  Odd_parity,
    output reg Invalid
);
    always @(*) begin
        Invalid=1'b0;
    if(bypass_A&&bypass_B)
        if(INPUT_PRIORITY)
        Out=A;
        else
        Out=B;
    else if(bypass_A)
        Out=A;
    else if(bypass_B)
        Out=B;
        else
        begin
        case(opcode)
        3'b000:
        begin
            if(red_op_A&&red_op_B)
                if(INPUT_PRIORITY) //A
                Out=&A;
                else
                Out=&B;
            else if(red_op_A)
                Out=&A;
            else if(red_op_B)
                 Out=&B;
            else
            Out=A & B;
        end
        3'b001:
         begin
            if(red_op_A&&red_op_B)
                if(INPUT_PRIORITY) //A
                Out=^A;
                else
                Out=^B;
            else if(red_op_A)
                Out=^A;
            else if(red_op_B)
                 Out=^B;
             else
            Out=A ^ B;
        end
        3'b010:
        begin if(red_op_A||red_op_B) begin
            Invalid=1;
        end
        else
        Invalid=0;
            if(FULL_ADDER)
            Out=A+B+cin;
            else
            Out=A+B;
        end
        3'b011:
        begin
            if(red_op_A||red_op_B) begin
            Invalid=1'b1;
        end
        else
        Invalid=0;
            Out=A * B;
        end
        3'b100:
        begin
            if(red_op_A||red_op_B) begin
            Invalid=1'b1;
        end
        else
        Invalid=0;
            if (A>=B) 
            Out=A-B;
            else
            Out=B-A;
        end
        3'b101:
        begin
            if(red_op_A||red_op_B) begin
            Invalid=1'b1;
        end
        else
        Invalid=0;
            if(A=='b0&& B=='b0) 
             Out='b0;
            else if(A=='b0) 
            Out=B; 
            
            else if(B=='b0) begin
            Out=A; Invalid=1;
            end
            else 
            Out=A/B; 
            
        end
        3'b110: Invalid=1'b1;
        3'b111:Invalid=1'b1;
        endcase
        end
    end
assign Odd_parity = ~^Out;
endmodule