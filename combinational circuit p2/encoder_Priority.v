module encoder_priority (
    input [3:0] w,
    output z,   //priority
    output reg [1:0]y
);
    always @(w)
    assign z=|w;
    begin 
      /* case (w)
        4'b0000:  y=x; 
        4'b1xxx:  y=3; 
        4'b01xx:  y=2; 
        4'b001x:  y=1; 
        4'b0001:  y=0; 
        default:  y=2'bx; 
      endcase */
      if(w[3]) //w[3]=1 and i don't care about others
      y=2'b11;
      else if(w[2])
      y=2'b10;
      else if(w[1])
      y=2'b01;
      else if(w[0])
      y=2'b00;
      else
      y=2'bxx;

    end




endmodule