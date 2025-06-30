module top_module(
    input [31:0] a,
    input [31:0] b,
    output [31:0] sum
);
    wire [15:0] sumout1,sumsel1,sumsel2;
    wire couttemp,cintemp2,cintemp3;
    add16 addermain(a[15:0],b[15:0],0,sumout1,couttemp);
    add16 addersel1(a[31:16],b[31:16],0,sumsel1,cintemp2);
    add16 addersel2(a[31:16],b[31:16],1,sumsel2,cintemp3);
    
    always@(*) begin
        case(couttemp)
            1'b0 :  sum ={sumsel1,sumout1};
            1'b1 :  sum ={sumsel2,sumout1};
            default: sum ={sumsel1,sumout1};
            endcase
    end
endmodule
