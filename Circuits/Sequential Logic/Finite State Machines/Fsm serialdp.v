module top_module(
    input clk,
    input in,
    input reset,    // Synchronous reset
    output [7:0] out_byte,
    output done
);

     // Use FSM from Fsm_serial
    typedef enum logic [2:0] {START, DATA, PARITY,STOP, ERROR} state_t; 
    state_t state, next_state;
    
    reg[7:0] temp;
	integer i;
    logic [3:0] bit_cnt;
    reg odd;

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
            else if (next_state == DATA)
                begin
                bit_cnt <= bit_cnt +4'd1;
            //if(bit_cnt >1)
              //  out_byte [bit_cnt -2] = in;
                end
            if(next_state == ERROR || next_state == STOP)begin
            bit_cnt <=0;
            end
               
        end

    // Next-state logic
    always @(*) begin
        case (state)
            START:  next_state = (~in) ? DATA: START;
            DATA:   next_state = (bit_cnt == 4'd9  && in == ~odd) ? PARITY :(bit_cnt == 4'd9 && ~(in == ~odd))?ERROR: DATA;
            PARITY: next_state = in? STOP: ERROR;
            STOP:   next_state = (in) ? START : DATA;
            ERROR:  next_state = in ? START: ERROR;
            default: next_state = START;
        endcase
    end
    
    parity p_check(clk,~(state == DATA), in, odd);
    assign done = (state == STOP);
    
    always@(posedge clk)
        begin
            if(reset)
                i <= 0;
            else if (state == DATA)
                begin
                    temp[i] <= in;
                    i<=i+8'd1;
                end
  			else i<=0;          
        end

    assign out_byte = (done) ? temp :8'd0;
    // New: Datapath to latch input bits.


endmodule
