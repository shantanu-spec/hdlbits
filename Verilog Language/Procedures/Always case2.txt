// synthesis verilog_input_version verilog_2001
module top_module (
    input [3:0] in,
    output reg [1:0] pos  );

    always@(*)begin
        case(in)
            4'd0: pos = 2'b00; 	//0000->0
            4'd1: pos = 2'b00; 	//00001->0
			4'd2: pos = 2'b01;  //0010->1
            4'd3: pos = 2'b00;	//0011->0
            4'd4: pos = 2'b10;	//0100->2
            4'd5: pos = 2'b00;	//0101->0
            4'd6: pos = 2'b01;	//0110->1
            4'd7: pos = 2'b00;	//0111->0
            4'd8: pos = 2'b11; 	//1000->3
            4'd9: pos = 2'b00;	//1001->0
            4'd10: pos = 2'b01;	//1010->1
            4'd11: pos = 2'b00; //1011->0
            4'd12: pos = 2'b10; //1100->2
            4'd13: pos = 2'b00;	//1101->0
            4'd14: pos = 2'b01;	//1110->1
            4'd16: pos = 2'b11; //1111->0
            default: pos = 2'b00;
        endcase
        end
endmodule
