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

    parameter LEFT=3'd0, RIGHT=3'd1, GROUND_LEFT=3'd2, GROUND_RIGHT=3'd3,
              DIG_LEFT=3'd4, DIG_RIGHT=3'd5, SPLAT=3'd6, OOPS=3'd7;

    reg [2:0] state, next_state;
    reg [5:0] time_count;

    // State transition logic
    always @(*) begin
        case(state)
        		LEFT: begin next_state<=(!ground)?GROUND_LEFT:(dig?DIG_LEFT:(bump_left?RIGHT:LEFT));end
                RIGHT: begin next_state<=(!ground)?GROUND_RIGHT:(dig?DIG_RIGHT:(bump_right?LEFT:RIGHT)); end
                GROUND_LEFT:next_state<=ground?LEFT:((time_count == 5'd20)?SPLAT:GROUND_LEFT);
                GROUND_RIGHT:next_state<=ground?RIGHT:((time_count == 5'd20)?SPLAT:GROUND_RIGHT);
                DIG_LEFT:next_state<=(!ground)?GROUND_LEFT:DIG_LEFT;
                DIG_RIGHT:next_state<=(!ground)?GROUND_RIGHT:DIG_RIGHT;
                SPLAT:next_state<=ground?OOPS:SPLAT;
                OOPS:next_state<=OOPS;
                default:next_state<=LEFT;	
        endcase
    end

    // State and timer update
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= LEFT;
			 else
            state <= next_state;
        end
   
    
        always@(posedge clk or posedge areset)
        begin
            if(areset) time_count<=6'd0;
            else if(next_state == GROUND_LEFT || next_state == GROUND_RIGHT) time_count<=time_count+6'd1;
            else time_count<=6'd0;
        end

    // Output logic
assign walk_left  = (state == LEFT) ;
assign walk_right = (state == RIGHT)      ;
assign aaah       = (state == GROUND_LEFT || state == GROUND_RIGHT) || (state == SPLAT);
assign digging    = (state == DIG_LEFT || state == DIG_RIGHT)     ;


endmodule
