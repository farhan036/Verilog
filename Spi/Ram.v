module ram_spi #(
    parameter adder_width=8,data_width=8
) (
    input [9:0] din,
    input clk,rst_n,rx_valid,
    output reg tx_valid,
    output [data_width-1:0] dout
);
reg [adder_width-1:0] write_address,read_address;
reg [9:0] memory [0:255];
always @(posedge clk,negedge rst_n) begin
    if(!rst_n)
    write_address <= 0;
    read_address <= 0;
    tx_valid <= 1'b0;
    
end
always @(*) begin
    case(din[9:8])
    2'b00:
    begin 
        if(rx_valid)
        write_address=din[7:0];
        tx_valid=1'b0;
    end
    2'b01:
    begin 
        if(rx_valid)
    memory[write_address]=din[7:0];
    tx_valid=1'b0;
    end
    2'b10:
    begin if(rx_valid)
    read_address=din[7:0];
    tx_valid=1'b0;
    end
    2'b11:
    begin
        memory[read_address]=din[7:0];
        tx_valid=1'b1;
    end
    default:tx_valid=1'b0;
    endcase
    
end
    assign dout=memory[read_address];
endmodule