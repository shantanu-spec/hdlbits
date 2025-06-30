module top_module (
    input [3:1] y,
    input w,
    output Y2);
    
    typedef enum logic [2:0] {A,B,C,D,E,F} state_t;
    state_t next_state;
    
    always@(*)
	begin
        case(y)
            A: begin next_state = w ? A:B; end
            B: begin next_state = w ? D:C; end
            C: begin next_state = w ? D:E; end 
            D: begin next_state = w ? A:F; end
            E: begin next_state = w ? D:E; end
            F: begin next_state = w ? D:C; end
            default: next_state = A;
        endcase
    end
    
    assign Y2 = next_state[1];
endmodule
