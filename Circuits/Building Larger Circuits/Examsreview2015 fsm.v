module top_module (
    input clk,
    input reset,      // Synchronous reset
    input data,
    output shift_ena,
    output counting,
    input done_counting,
    output done,
    input ack );

    
    typedef enum logic[3:0] {S0,S1,S2,S3,S4,S5,S6,S7,S8,S9} state_t;
    state_t state,next_state;
    
    always@(posedge clk)
        begin
            if(reset)
                state <= S0;
            else state <= next_state;
        end
    
    always@(*)
        begin
            case(state)
           		S0: begin next_state =  data ? S1: S0; shift_ena = 1'b0; end//fsm start
                S1: begin next_state = data ? S2: S0; shift_ena = 1'b0;end
                S2: begin next_state = data ? S2: S3; shift_ena = 1'b0; end
                S3: begin next_state = data ? S4: S0; shift_ena = 1'b0; end//fsm done
                S4: begin next_state = S5; shift_ena = 1'b1; end//start shifting for 4 cycles
                S5: begin next_state = S6; shift_ena = 1'b1; end
                S6: begin next_state = S7; shift_ena = 1'b1; end
                S7: begin next_state = S8; shift_ena = 1'b1; end
                S8: begin next_state = (done_counting)? S9: S8; shift_ena = 1'b0; end//check if done counting or not
                S9: begin next_state = ack ? S0: S9; shift_ena = 1'b0; end //check for acknowledgement
                   
                default: next_state = S0;
            endcase
        end

    assign counting = (state ==S8);
    assign done = (state == S9);
endmodule
