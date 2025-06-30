module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output [1:0] state
);
    parameter SNT = 2'd0,WNT = 2'd1, WT = 2'd2, ST = 2'd3;
    reg[1:0] next_state;
    
    always@(posedge clk or posedge areset)
        begin
            if(areset)
                state <= WNT;
            else
                state <= next_state;
        end
    
    always@(*)
        begin
            case(state)
                SNT: 
                    begin 
                        if(train_valid)
                            begin
                                if(train_taken)
                                    begin
                                    next_state = WNT;
                                    end
                                else
                                    begin
                                    next_state = SNT;
                                    end
                            end
                        else 
                            next_state = SNT;
                    end
                WNT: 
                        begin 
                        if(train_valid)
                            begin
                                if(train_taken)
                                    begin
                                    next_state = WT;
                                    end
                                else
                                    begin
                                    next_state = SNT;
                                    end
                            end
                        else 
                            next_state = WNT;
                    end
                WT: 
                        begin 
                        if(train_valid)
                            begin
                                if(train_taken)
                                    begin
                                    next_state = ST;
                                    end
                                else
                                    begin
                                    next_state = WNT;
                                    end
                            end
                        else 
                            next_state = WT;
                    end
                ST: 
                        begin 
                        if(train_valid)
                            begin
                                if(train_taken)
                                    begin
                                    next_state = ST;
                                    end
                                else
                                    begin
                                    next_state = WT;
                                    end
                            end
                        else 
                            next_state = ST;
                    end
                default : next_state = WNT;
            endcase
        end

endmodule