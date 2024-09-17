module multi_decade (
    input clk,reset_n,up,enable,done,
    output [3:0] ones,tens,hundreds;
);

wire net1,net2,net3;
wire a0, a1, a2;
    bcd b1(
.clk(clk),
.reset_n(reset_n),
.enable(enable),
.done(net1),
.up(up),
.q(ones)
    );
    assign a0=net1&enable;
      bcd b2(
.clk(clk),
.reset_n(reset_n),
.enable(a0),
.done(net2),
.up(up),
.q(tens)
    );
    assign a1=net2&a0;
      bcd b3(
.clk(clk),
.reset_n(reset_n),
.enable(a1),
.done(net3),
.up(up),
.q(hundreds)
    );
    assign a2=net3&a1;
    assign done=a2;

endmodule