module decoder2_4 (
    input [1:0] w,
    input en,
    output reg [0:3] y //so y0 is most significant bit 
);
    always @(w) 
    begin
      y=4'b000;
      /* if (w==2'b00)
      y=4'b1000;   //or y[0]=1'b1 and so on on rest cases
      else if(w==2'b01)
      y=4'b0100;
      else if(w==2'b10)
      y=4'b0010;
      else if(w==2'b11)
      y=4'b0001;
      else
      y=4'bx;*/
     /* case(w)   // we can 0:bla bla bla ; instead of 2'b00
        2'b00:y[0]=1'b1;   //we can use y=4'b1000 and so on   
        2'b01:y[1]=1'b1;
        2'b10:y[2]=1'b1;
        2'b11:y[3]=1'b1;
        default:y=4'bx; 

      endcase */
      if(en)
      y[w]=1'b1; //easier way
      else
      y=4'b000;
    end




endmodule

