module mux1bit #(parameter inputs=5) (
    input [$clog2(inputs)-1:0] s,
    input [inputs-1:0] w,
    output reg f
);
    integer k;
    always @(w,s)
    begin

        for(k=0;k<inputs;k=k+1)
        begin
            if (s==k)
            f=w[k];
        end
    end




endmodule