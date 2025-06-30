module top_module (
    input clk,
    input areset,
    input x,
    output reg z
); 
    typedef enum logic[1:0] {IDLE,S0, S1} state_t;
    state_t state, next_state;
    reg value;
    
    // Reset goes to S0 immediately
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= IDLE;
        else
            state <= next_state;
    end
    
    // State transition logic
    always @(*) begin
        case(state)
            IDLE: 	begin next_state = x ? S1 : S0; value =  x ? 1'b0:1'b1;end
            S0: 	begin next_state = x?(value? S1:S0):(value? S0:S1); value = value; end
            S1: 	begin next_state = x?S0:S1;value = 1'b0;  end
            default: next_state = IDLE;
        endcase
    end

    // Output logic (Moore: based only on state)
  
    assign z = (state==S1);
endmodule
