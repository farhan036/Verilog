module encoder4_2 (
    input [3:0] w,
    input z,   //priority
    output reg [1:0]y
);
    always @(w)
    begin 
      case (w)
        4'b0001:y=0;
        4'b0010:y=1;
        4'b0100:y=2;
        4'b1000:y=3; 
        default:y=2'bx;
      endcase

    end




endmodule