module top_module (
    input clk,
    input resetn,    // active-low synchronous reset
    input [3:1] r,   // request
    output [3:1] g   // grant
); 

    typedef enum logic [2:0] {A,B,C,D} state_t;
    state_t state, next_state;
    
    always@(posedge clk)
        begin 
            if(!resetn)
                state <= A;
            else 
                state <= next_state;
        end
    
    always@(*)
        begin
            case(state)
                A: begin next_state = r[1] ? B: (r[2]?C:(r[3]?D:A)); end
                B: begin next_state = r[1] ? B: A ; end
                C: begin next_state = r[2] ? C: A; end
                D: begin next_state = r[3] ? D: A; end
                default: next_state = A;
            endcase
        end
   
    assign g[1] = (state==B);
    assign g[2] = (state==C);
    assign g[3] = (state==D);
    
endmodule
