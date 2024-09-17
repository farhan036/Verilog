module mux2_1_data (
    input x1,x2,s,
    output f
); //dataflow structural modeling 
    
assign f = ~s & x1 | x2 & s;  // we use assign because this is continuos output
                             // if right change f will change 


endmodule