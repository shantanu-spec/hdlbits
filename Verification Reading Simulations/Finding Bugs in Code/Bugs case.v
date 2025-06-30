module top_module (
    input [7:0] code,
    output reg [3:0] out,
    output reg valid );//

    always @(*) begin
         out = 0;
         valid = 1;
        case (code)
            8'h45: begin out = 0;  end
            8'h16: begin out = 1;  end
            8'h1e: begin out = 2;  end
            8'h26: begin out = 3;  end
            8'h25: begin out = 4;  end
            8'h2e: begin out = 5; end
            8'h36: begin out = 6;  end
            8'h3d: begin out = 7;  end
            8'h3e: begin out = 8;  end
            8'h46: begin out = 9; end
            default: valid = 0;
        endcase
    end
endmodule
