module top_module (
    input [3:0] SW,
    input [3:0] KEY,
    output [3:0] LEDR
); //

    MUXDFF m4(KEY[0],KEY[3],SW[3],KEY[1],KEY[2],LEDR[3] );
    MUXDFF m3(KEY[0],LEDR[3],SW[2],KEY[1],KEY[2],LEDR[2] );
    MUXDFF m2(KEY[0],LEDR[2],SW[1],KEY[1],KEY[2],LEDR[1] );
    MUXDFF m1(KEY[0],LEDR[1],SW[0],KEY[1],KEY[2],LEDR[0] );
endmodule



module MUXDFF (
    input clk,
    input w, R, E, L,
    output Q
);
    
    always @(posedge clk)
        begin
            Q <= L ? R : (E?w:Q);
        end

endmodule
