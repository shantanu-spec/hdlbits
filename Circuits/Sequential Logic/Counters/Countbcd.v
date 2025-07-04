module top_module (
    input clk,
    input reset,   // Synchronous active-high reset
    output [3:1] ena,
    output [15:0] q);

    
    decade_counter ones(clk,reset,1'b1,q[3:0]);
    decade_counter tens(clk,reset,ena[1],q[7:4]);
    decade_counter hundreds(clk,reset,ena[2],q[11:8]);
    decade_counter thousands(clk,reset,ena[3],q[15:12]);
    
    
    assign ena[1] = (q[3:0]==4'd9);
    assign ena[2] = ena[1] && (q[7:4]==4'd9);
    assign ena[3] = ena[2] && (q[11:8]==4'd9);
    
    
endmodule

module decade_counter (
    input clk,
    input reset,        // Synchronous active-high reset
    input enable,
    output [3:0] q);

    always@(posedge clk)
        begin
            if(reset)
                begin
                	q <= 0;
                end
            else
                if (enable)
                begin
                    if(q>8)
                    q<=0;
                    else
                        q <=q+1;
                        
                end
                end
endmodule
