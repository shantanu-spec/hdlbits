module top_module (
    input clk,
    input reset,   // Synchronous active-high reset
    input w,
    output z
);

        typedef enum logic [2:0] {A,B,C,D,E,F} state_t;
    state_t state, next_state;
    
    always@(posedge clk)
        begin
            if(reset) state <= A;
            else state <= next_state;
        end
    
    always@(*)
        begin
            case(state)
                A: begin next_state = w ? B:A; end
            	B: begin next_state = w ? C:D; end
            	C: begin next_state = w ? E:D; end 
            	D: begin next_state = w ? F:A; end
            	E: begin next_state = w ? E:D; end
            	F: begin next_state = w ? C:D; end
            default: next_state = A;
            endcase
        end
    
    assign z = (state == E)| (state== F);
    
endmodule
