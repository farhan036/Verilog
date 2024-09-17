module swap_fun #(parameter ADDR_WIDTH = 7, DATA_WIDTH=8) (
   input we ,swap,
   input [ADDR_WIDTH-1:0] address_r,address_w,
   input [ADDR_WIDTH-1:0] address_A,address_B,
   input [DATA_WIDTH-1:0] data_w,
   input reset_n,clk,
   output [DATA_WIDTH-1:0] data_r
);
 wire [1:0] sel;
    wire w;
    wire [ADDR_WIDTH - 1:0] MUX_READ_f, MUX_WRITE_f;
    
reg_file #(.ADDR_WIDTH(ADDR_WIDTH),.DATA_WIDTH(DATA_WIDTH)) R1 (
.clk(clk),
.we(w?'1b1:we),
.address_w(MUX_WRITE_f),
.address_r(MUX_READ_f),
.data_w(w?data_r:data_w),
.data_r(data_r)
);
Fsm_swap s1(
.clk(clk),
.swap(swap),
.reset_n(reset_n),
.sel(sel)
.w(w)
);
Mux4 #(.n(4)) m1 (
    .sel(sel),
    .w[0](address_w),
    .w[1]('b0),
    .w[2](address_A),
    .w[3](address_B),
    .f(MUX_WRITE_f)
);
Mux4 #(.n(4)) m2 (
    .sel(sel),
    .w[0](address_r),
    .w[1](address_A),
    .w[2](address_B),
    .w[3]('b0),
    .f(MUX_WRITE_r)
);
    
endmodule