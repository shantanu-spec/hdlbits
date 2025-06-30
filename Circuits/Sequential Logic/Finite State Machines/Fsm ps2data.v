module top_module(
    input clk,
    input [7:0] in,
    input reset,    // Synchronous reset
    output [23:0] out_bytes,
    output done); //

    // FSM from fsm_ps2


    
        parameter BYTE1 = 2'd0,BYTE2 = 2'd1, BYTE3 = 2'd2, DONE = 2'd3;
    reg[1:0] state, next_state;
    // State transition logic (combinational)
    always@(*)
        begin
            case(state)
                BYTE1:
                    begin 
                    if(in[3]) next_state = BYTE2;
                else next_state = BYTE1;
                        
                    end
                BYTE2: next_state = BYTE3;
                BYTE3: next_state = DONE;
                DONE:      begin 
                    if(in[3]) next_state = BYTE2;
                else next_state = BYTE1;
                    end
                default: next_state=BYTE1;
            endcase
        
        end

    // State flip-flops (sequential)
    always@(posedge clk)
        begin
            if(reset)
                begin
                state <= BYTE1;
                end
            else
                state <= next_state;
        end
    // Output logic
    assign done = (state == DONE);

    // New: Datapath to store incoming bytes.
    
    always@(posedge clk)
        begin
            case(state)
                BYTE1: out_bytes[23:16] <= in;
                BYTE2: out_bytes[15:8] 	<= in;
                BYTE3: out_bytes[7:0] 	<= in;
                DONE: out_bytes[23:16] <= in;
                default: out_bytes[23:16] <= in;
                
            endcase
        end
endmodule
