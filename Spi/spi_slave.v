module spi_slave (
    input MOSI, tx_valid, rst_n, clk,
    input [7:0] tx_data,
    input [1:0] SS_n,
    output reg MISO,
    output reg rx_valid,
    output reg [9:0] rx_data
);
    localparam IDLE = 0;
    localparam READ = 1;
    localparam WRITE = 2;
    localparam CHK_CMD = 3;
     // This state is not used currently

    reg [2:0] state_reg, state_next;
    reg [3:0] count_reg, count_next;
    reg [3:0] countx_reg, countx_next;
    reg [9:0] data_reg, data_next;
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            state_reg <= IDLE;
            data_reg <= 10'b0; // Initialize to zero or some default value
            count_reg <= 0;
            countx_reg <= 0;
            rx_valid <= 0;
            
        end 
        else begin
            state_reg <= state_next;
            data_reg <= data_next;
            count_reg <= count_next;
            countx_reg <= countx_next;
            
        end
    end

    always @(*) begin
        state_next = state_reg;
        data_next = data_reg;
        count_next = count_reg;
        countx_next = countx_reg;
        rx_valid = 0; // Default value
        
        case (state_reg)
            IDLE: begin
                if (!SS_n) 
                    state_next = CHK_CMD;
            end

            CHK_CMD: begin
                if (SS_n == 2'b00 && MOSI == 0)
                    state_next = WRITE;
                else if (SS_n == 2'b00 && MOSI == 1)
                    state_next = READ;
                else if (SS_n != 2'b00)
                    state_next = IDLE;
            end

            WRITE: begin
                if (SS_n) 
                    state_next = IDLE;
                else 
                begin count_next = count_reg + 1;
                
                if(count_reg<10)
                    data_next = {data_reg[8:0],MOSI};
                   else if (count_reg == 10) begin

                        rx_valid = 1;
                        //data_next[9:8] = 2'b00;
                        state_next = IDLE;
                        count_next=0; // No change needed here
                    end
                end
            end

            READ: begin
                if (SS_n != 2'b00) 
                    state_next = IDLE;
                else begin
                    MISO=tx_data[7-countx_reg];
                    countx_next=countx_reg+1;
                    if(countx_next==8) begin
                        countx_next=0;
                        state_next=IDLE;
                    end
                    
                end
            end

            default: state_next = IDLE;
        endcase
    end

    assign rx_data = data_reg;
endmodule
