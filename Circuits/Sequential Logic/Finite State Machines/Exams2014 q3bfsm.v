module top_module (
    input clk,
    input reset,   // Synchronous reset
    input x,
    output z
);
    typedef enum logic[2:0] {A,B,C,D,E} state_t;
    state_t state, next_state;
    
    always@(posedge clk)
        begin
            if(reset) state <= A;
            else state <= next_state;
        end

    always@(*)
        begin
            case(state)
                A : begin next_state = x ? B:A; z = 0;  end
                B : begin next_state = x ? E:B; z = 0;  end
                C : begin next_state = x ? B:C; z = 0;	end
                D : begin next_state = x ? C:B; z = 1;  end
                E : begin next_state = x ? E:D; z = 1;  end
            endcase
        end
endmodule
