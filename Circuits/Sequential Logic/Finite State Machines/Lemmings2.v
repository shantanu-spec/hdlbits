module top_module(
    input clk,
    input areset,    // Freshly brainwashed Lemmings walk left.
    input bump_left,
    input bump_right,
    input ground,
    output walk_left,
    output walk_right,
    output aaah ); 
    
     parameter LEFT=2'd0,RIGHT=2'd1,GROUND =2'd3;
    reg[1:0] state, next_state,prev_state;
    
  // State transition logic
    always @(*) begin
        case(state)
            LEFT: begin
                	if(!ground)
           			next_state <=GROUND;
                	
                    else if(bump_left)
                       begin
                        next_state <= RIGHT;
                       end
                    else 
                        begin
                        next_state <= LEFT;
                        end
                	prev_state <=LEFT;
                	end
             RIGHT: 
                        begin
                            if(!ground)
                                next_state <= GROUND;
                            
                            else if(bump_right)
                                next_state <= LEFT;
                            else
                                begin
                                next_state <= RIGHT;
                                end
                            prev_state <=RIGHT;
                        end
            GROUND: 
                	begin
                        if(!ground)
                            begin
                            next_state <= GROUND;
                            end
                        else 
                            next_state <= prev_state;
                    end
            default: 
                begin
            	    	if(!ground)
           			next_state <=GROUND;
                	
                    else if(bump_left)
                       begin
                        next_state <= RIGHT;
                       end
                    else 
                        begin
                        next_state <= LEFT;
                        end
                	prev_state <=LEFT;
                end
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
    assign aaah = (state == GROUND);

endmodule
