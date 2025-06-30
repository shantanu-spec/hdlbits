module top_module( 
    input [2:0] in,
    output [1:0] out );

    reg[1:0] count ;
    always@(*)begin
    count = 2'b0;
        for (int i = 0; i < 3; i++)
        begin
            if(in[i]==1'b1)
                count++;
            else 
				count = count;
        end
    end
    
    assign out = count;
endmodule
