module top_module (
    input clk,
    input areset,
    input x,
    output z
); 

    typedef enum logic[1:0] {A,B} state_t;
    state_t state, next_state;
    reg value;
    
    
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= A;
        else
            state <= next_state;
    end
    
     always @(*) begin
        case(state)
            A: begin next_state = x ? B: A; z = x ? 1'b1 : 1'b0; end
            B: begin next_state = x ? B: B; z = x ? 1'b0 : 1'b1; end
            
            //IDLE: 	begin next_state = x ? S1 : S0; value =  x ? 1'b0:1'b1;end
            //S0: 	begin next_state = x?(value? S1:S0):(value? S0:S1); value = value; end
            //S1: 	begin next_state = x?S0:S1;value = 1'b0;  end
            default: next_state = A;
        endcase
    end

    
endmodule
