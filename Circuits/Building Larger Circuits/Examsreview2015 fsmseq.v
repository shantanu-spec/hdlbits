module top_module (
    input clk,
    input reset,      // Synchronous reset
    input data,
    output start_shifting);

    typedef enum logic[2:0] {S0,S1,S2,S3,S4} state_t;
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
            S0: next_state = data ? S1: S0;
            S1: next_state = data ? S2: S0;
            S2: next_state = data ? S2: S3;
            S3: next_state = data ? S4: S0;
            S4: next_state = S4;
                default: next_state = S0;
            endcase
        end
    
    assign start_shifting = (state == S4);
endmodule