module top_module(
    input clk,
    input areset,    // Asynchronous reset to state B
    input in,
    output out);//  

    parameter A=1'b0, B=1'b1; 
    reg state, next_state;

    always @(*) begin    // This is a combinational always block
        // State transition logic
        case(state)
            B: 	begin
            	out = 1'b1;
                if(in) next_state = B;
                else next_state = A;
           		end
            A: 	begin
            	out = 1'b0;
                if(in) next_state = A;
                else next_state = B;
            	end
        endcase
        
    end

    always @(posedge clk, posedge areset) begin    // This is a sequential always block
        // State flip-flops with asynchronous reset
        if(areset)
            begin
            	state <= B;
            end
        else
            state <= next_state;
    end
    
    

    // Output logic
    // assign out = (state == ...);

endmodule
