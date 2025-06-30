module top_module (
    input clk,
    input [2:0] y,
    input x,
    output Y0,
    output z
);
    
    typedef enum logic[2:0] {A,B,C,D,E} state_t;
    state_t next_state;
    
    always@(*)
        begin
            case(y)
                A : begin next_state = x ? B:A; z = 0;  end
                B : begin next_state = x ? E:B; z = 0;  end
                C : begin next_state = x ? B:C; z = 0;	end
                D : begin next_state = x ? C:B; z = 1;  end
                E : begin next_state = x ? E:D; z = 1;  end
                default : begin next_state = A;z  = 0; end
            endcase
        end
    
    assign Y0 = next_state[0];

endmodule
