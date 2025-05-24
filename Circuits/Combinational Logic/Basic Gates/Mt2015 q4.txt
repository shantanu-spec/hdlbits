module top_module (input x, input y, output z);
	wire z1,z2,z3,z4;
    
    assign z1 = (x^y) & x;//A1
    assign z2 = ~(x^y); //B1
    assign z3 = (x^y) & x;//A2
    assign z4 = ~(x^y); //B2
    
    assign z = ((z1|z2)^(z3&z4));
    
endmodule
