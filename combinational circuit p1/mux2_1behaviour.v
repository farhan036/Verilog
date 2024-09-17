module mux2_1behav (
    input x1,s,x2,
    output reg f    // we use (reg) to store current value when we use always
);
    always @(x1,x2,s) //when x1 or x2 or s change we excute in block always (like as loop)
       /* begin         // begin w end like { } in c
            if (s)  //if s=1 "true" f=x2 
                begin
                    f=x2;

                end
            else
                begin
                    f=x1;

                 end

        end */
        case (s)
        1:f=x2;
        0:f=x1;
        endcase 



endmodule