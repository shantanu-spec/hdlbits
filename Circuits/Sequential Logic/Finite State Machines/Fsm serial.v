module top_module(
    input clk,
    input in,
    input reset,    // Synchronous reset
    output done
); 

    typedef enum logic [1:0] {START, DATA, STOP, ERROR} state_t; 
    state_t state, next_state;

    logic [3:0] bit_cnt;

    // State register and bit counter
    always @(posedge clk) begin
        if (reset) begin
            state <= START;
        end else begin
            state <= next_state;
        end
    end
    
    always@(posedge clk)
        begin
            if(reset)
                bit_cnt <= 4'd0;
            else if (state == DATA)
                bit_cnt <= bit_cnt +4'd1;
            else bit_cnt <=4'd0;
               
        end

    // Next-state logic
    always @(*) begin
        case (state)
            START:  next_state = (~in) ? DATA: START;
            DATA:   next_state = (bit_cnt < 8) ? DATA : (in? STOP: ERROR);
            STOP:   next_state = (in) ? START : DATA;
            ERROR:  next_state = in ? START: ERROR;
            default: next_state = START;
        endcase
    end
    

    assign done = (state == STOP);

endmodule
