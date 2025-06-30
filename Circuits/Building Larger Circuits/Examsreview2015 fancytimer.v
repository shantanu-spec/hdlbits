module top_module (
    input clk,
    input reset,      // Synchronous reset
    input data,
    output [3:0] count,
    output counting,
    output done,
    input ack );
    
    typedef enum logic[2:0] {S0,S1,S2,S3,S4,S5,S6,S7} state_t;
    state_t state,next_state;
    
    reg [3:0] delay;
    reg [9:0] timer;
    always@(posedge clk)
        begin
            if(reset) begin
                state <= S0;
            	delay<=4'd0; timer<=10'd0;
            end
            else 
                begin 
                    if(state == S3) timer <= 10'd3;
                    else if(state == S4) begin timer <= timer-10'd1; delay <= {delay[2:0],data}; end
                    else if(state == S5) timer <= 10'd999-10'd1;
                    else if(state == S6) begin 
                        if (timer == 10'd0)
                            begin
                            timer <= 10'd999;
                            delay <= delay-4'd1;
                                
                            end
                        else timer <= timer -10'd1;
                    end
                    state <= next_state;
         			
                end
         end
    
    always@(*)
        begin
            case(state)
            S0: next_state = data ? S1: S0;
            S1: next_state = data ? S2: S0;
            S2: next_state = data ? S2: S3;
            S3: next_state = data ? S4: S0;
                S4: next_state = (timer == 10'd0)?S5:S4;
                S5: next_state = S6;
                S6: next_state = (timer == 10'd0 && delay ==4'd0)?S7:S6;
                S7: next_state = ack? S0:S7;
                default: next_state = S0;
            endcase
        end
    
    assign done = (state==S7);
    assign counting = (state==S5 | state == S6);
    assign count = delay;
    
endmodule
// This module implements a state machine that counts the number of clock cycles