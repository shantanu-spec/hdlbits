module top_module(
    input clk,
    input reset,    // Synchronous reset
    input in,
    output disc,
    output flag,
    output err);
    
    typedef enum logic[3:0] {IDLE, ONE, TWO, THREE, FOUR, FIVE, SIX, ERROR, DISCARD, FLAG} state_t;
    state_t state, next_state;
    
    always@(posedge clk)
        begin
            if(reset) state <= IDLE;
            else state <= next_state;
        end
    
    always@(*)
        begin
            case(state)
                IDLE:	 next_state = in ? ONE: IDLE; 
                ONE:	 next_state = in ? TWO: IDLE;  
                TWO:	 next_state = in ? THREE : IDLE; 
                THREE:	 next_state = in ? FOUR : IDLE; 
                FOUR:	 next_state = in ? FIVE : IDLE; 
                FIVE:	 next_state = in ? SIX : DISCARD; 
                SIX:	 next_state = in ? ERROR : FLAG; 
                ERROR:	 next_state = in ? ERROR : IDLE; 
                DISCARD: next_state = in ? ONE : IDLE; 
                FLAG: 	 next_state = in ? ONE : IDLE;
                
                default: next_state = IDLE;
            endcase
        end
    
    assign flag= (state == FLAG);
    assign err=  (state == ERROR);
    assign disc= (state == DISCARD);
    
endmodule
