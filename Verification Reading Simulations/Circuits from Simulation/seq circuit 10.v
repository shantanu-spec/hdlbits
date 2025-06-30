module top_module (
    input clk,
    input a,
    input b,
    output q,
    output state  );

    always@(posedge clk)
        begin
            if(~a&~b) state <= 1'b0;
            else if(a&b) state <= 1'b1;
        end
    
    always@(*)
        begin
            case(state)
            0: q = a^b;
            1: q = ~(a^b);
            endcase
        end
    
endmodule
