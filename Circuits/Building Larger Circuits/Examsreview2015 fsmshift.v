module top_module (
    input clk,
    input reset,      // Synchronous reset
    output shift_ena);

    typedef enum logic[2:0] {A,B,C,D,E} state_t;
    state_t state, next_state;
    
    always@(posedge clk)
        begin
            if(reset)
                state <= A;
			else
                state <= next_state;
        end
    
    always@(*)
        begin
            case(state)
                A: begin next_state = B; shift_ena = 1'b1; end
                B: begin next_state = C; shift_ena = 1'b1; end
                C: begin next_state = D; shift_ena = 1'b1; end
               	D: begin next_state = E; shift_ena = 1'b1; end
                E: begin next_state = E; shift_ena = 1'b0; end
                default: next_state = A;
            endcase
        end
endmodule
