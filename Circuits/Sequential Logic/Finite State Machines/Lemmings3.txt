module top_module(
    input clk,
    input areset,    // Freshly brainwashed Lemmings walk left.
    input bump_left,
    input bump_right,
    input ground,
    input dig,
    output walk_left,
    output walk_right,
    output aaah,
    output digging ); 

    
    parameter LEFT=3'd0,RIGHT=3'd1,GROUND_LEFT=3'd2,  GROUND_RIGHT=3'd3, DIG_LEFT=3'd4, DIG_RIGHT=3'd5;
    reg[2:0] state, next_state;
    
  // State transition logic
    always @(*) begin
        case(state)
            LEFT: begin
                	if(!ground)
           			next_state <=GROUND_LEFT;
                	
                	else if(dig)
                        begin
                    next_state <=DIG_LEFT;
                        end
                    else if(bump_left)
                       begin
                        next_state <= RIGHT;
                       end
                    else 
                        begin
                        next_state <= LEFT;
                        end
                	end
            
             RIGHT: 
                        begin
                            if(!ground)
                                next_state <= GROUND_RIGHT;
                            	else if(dig)
                        begin
                    next_state <=DIG_RIGHT;
                        end
                            
                            else if(bump_right)
                                next_state <= LEFT;
                            else
                                begin
                                next_state <= RIGHT;
                                end
                        end
            GROUND_LEFT: 
                	begin
                        if(ground)
                            next_state <= LEFT;
                        else
                            next_state <= GROUND_LEFT;
                    end
            
            GROUND_RIGHT:
                begin
                        if(ground)
                            next_state <= RIGHT;
                        else
                            next_state <= GROUND_RIGHT;
                    end
                
            DIG_LEFT:
                begin
                	if(!ground)
                	next_state <= GROUND_LEFT;
                    else 
                    next_state <= DIG_LEFT;
                end
            DIG_RIGHT:
                    begin
            		if(!ground)
                	next_state <= GROUND_RIGHT;
                    else 
                    next_state <= DIG_RIGHT;
                    end
            
            default:   next_state <= LEFT;
                 
                
                        endcase
      
    end
    
  // State flip-flops with asynchronous reset
    always @(posedge clk, posedge areset) begin
        if(areset)
            state <= LEFT;
        else
            state <= next_state;
    end

    // Output logic
    assign walk_left = (state == LEFT);
    assign walk_right = (state == RIGHT);
    assign aaah = (state == GROUND_LEFT) || (state == GROUND_RIGHT );
    assign digging = (state == DIG_LEFT) || (state == DIG_RIGHT) ;
    
endmodule
