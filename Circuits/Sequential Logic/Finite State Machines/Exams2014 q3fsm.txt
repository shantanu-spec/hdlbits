module top_module (
    input clk,
    input reset,   // Synchronous reset
    input s,
    input w,
    output z
);

    typedef enum logic[2:0] {A,B,C} state_t;
    state_t state, next_state;
   reg [1:0] count,j;
    
    always@(posedge clk)
        begin
            if(reset) state <= A;
            else state <= next_state;
        end
    
    always@(*)
        begin
            case(state)
        A : next_state = s ? B: A;
        B : next_state = B;
        default: next_state = A;
            endcase
        end
    
  always@(posedge clk)
        begin
            if(reset) count<=2'd0;
            else begin
            case(state)
                A: count<=2'd0;
                B: begin if(count<2'd2) count = count+2'd1;
                    else count<=2'd0;
                end
                default:count<=2'd0;
             endcase
            end
        end
    always@(posedge clk)
        begin
            if(reset) j<=2'd0; 
            else begin
            case(count)
                0: begin if(w) j<=2'd1; else j<=2'd0; end
                1: begin if(w) j<=j+2'd1; else j<=j; end
                2: begin if(w) j<=j+2'd1; else j<=j; end
                default:j<=2'd0;
            endcase
            end
        end
    
        assign z = ((j==2'd2)&&(count==2'd0))?1'b1:1'b0;
endmodule
