// synthesis verilog_input_version verilog_2001
module top_module(
    input a,
    input b,
    input sel_b1,
    input sel_b2,
    output wire out_assign,
    output reg out_always   ); 

 
            
            always@(*)
                begin
             		if(!sel_b1)
                      begin
        				if(!sel_b2) 
                        begin
        	 				out_always = a;
        				end
        			else 
                        begin
        	 				out_always = a;
        				end
    				 end
                	else 
                    begin
                 		if(!sel_b2) 
                        begin
        				 out_always = a;
        		  		end
        				else 
                        begin
        				 out_always = b;
        		  		end
                	end
            	end
    
    assign out_assign = (sel_b1 & sel_b2) ? b : a;
	
endmodule
