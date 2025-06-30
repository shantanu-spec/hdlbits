module top_module (
    input clk,
    input reset,
    input [31:0] in,
    output [31:0] out
);
    reg [31:0] temp_in;
    wire [31:0] rising_edge;
    
    always @(posedge clk)
        begin
        	temp_in<= in;
        end
    
    
        
    always @(posedge clk)
        begin
            if(reset)
                out <= 0;
            else
                begin
                    for (int i = 0; i<32;i++)
                        begin
                            if(rising_edge[i] == 1'b1)
                                begin
                               out[i] <= 1'b1;
                                end
                        end
                end
                         
        end
                
                
    assign rising_edge = temp_in &~in;
endmodule
