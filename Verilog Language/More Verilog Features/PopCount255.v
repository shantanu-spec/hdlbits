module top_module( 
    input [254:0] in,
    output [7:0] out );
 
    wire[7:0] count;
    always @(*) begin
        count = 8'b0;
        for(int i= 0; i <=254; i++)
        if(in[i]==1)begin
        count++;
        end
    out = count;
    end
endmodule
