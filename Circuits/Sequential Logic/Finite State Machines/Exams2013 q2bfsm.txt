module top_module (
    input clk,
    input resetn,    // active-low synchronous reset
    input x,
    input y,
    output f,
    output g
); 

    
    typedef enum logic[3:0] {A,F1,B,C,D,G1,G1P,E,G0P} state_t;
    state_t state,next_state;
    
    always@(posedge clk)
        begin
            if(~resetn)
                state <= A;
            else state <= next_state;
        end
    
    always@(*) begin
    
        case(state)
        A: 	    	next_state = (resetn) ?F1:A;
        F1:  		next_state = B;
        B:			next_state = x ? C: B;//t0
        C: 			next_state = x ? C: D; //t1
        D: 			next_state = x ? G1:B;//t2
        G1:			next_state = y ? G1P:E; 
        E:  		next_state = y ? G1P:G0P; //t3
        G1P:   		next_state = (~resetn)? A:G1P;
        G0P: 		next_state = (~resetn) ?A:G0P;
           
        endcase
    end
    
    always@(posedge clk)
        begin
            case(next_state)
            F1 : f <= 1'b1;
            G1,
            E,
       		G1P:    g <= 1'b1;
            G0P:    g <= 1'b0;
            default: begin
                    f <= 1'b0;
                    g <= 1'b0;
                 end
            endcase
        
        end
endmodule
