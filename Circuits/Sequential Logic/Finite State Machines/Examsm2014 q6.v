module top_module (
    input clk,
    input reset,     // synchronous reset
    input w,
    output z);

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
                A: begin next_state = w ? A:B; end
            	B: begin next_state = w ? D:C; end
            	C: begin next_state = w ? D:E; end 
            	D: begin next_state = w ? A:F; end
            	E: begin next_state = w ? D:E; end
            	F: begin next_state = w ? D:C; end
            default: next_state = A;
            endcase
        end
    
    assign z = (state == E)| (state== F);
    
endmodule
