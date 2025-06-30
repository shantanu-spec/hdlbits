module top_module (
    input clk,
    input aresetn,    // Asynchronous active-low reset
    input x,
    output z ); 

    typedef enum logic[1:0] {S0,S1,S2} state_t;
    state_t state, next_state;
    
    always @(posedge clk or negedge aresetn)
    begin
        if (!aresetn)
            state <= S0;
        else
            state <= next_state;
    end
            
            
    always@(*) begin
        
        case(state)
           
     S0:
        begin
            next_state = x ? S1 : S0;  // detect 1 -> S1, or 0 -> IDLE
            z = 1'b0;
        end
     S1: 
        begin
        	next_state = x ? S1 : S2; //detect 11 -> S1 since detected 1, else next state 10
            z = 1'b0;
        end
     S2:
        begin
            next_state = x ? S1 : S0; //detect 101 -> S1 since detected 1, else next state 100-> error or idle
            z = x ? 1'b1:1'b0;
        end
    default: next_state = S0;
       
        endcase
    
    end
    
endmodule
