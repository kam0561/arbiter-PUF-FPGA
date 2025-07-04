`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04.07.2025 14:48:29
// Design Name: 
// Module Name: arbiter
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module arbiter(
    input a,b,
    input [63:0] c,
    output z
    );
    
    wire [64:0] w1,w2;
    assign w1[0]= a;
    assign w2[0]= b;
    
    genvar i;
    generate 
    for(i=0;i<64;i=i+1)
    begin
        arbel arbelinst( .a(w1[i]), .b(w2[i]), .s(c[i]), .o1(w1[i+1]), .o2(w2[i+1]));
    end
    endgenerate
    
    dff d0( .clk(w2[64]), .d(w1[64]), .q(z));
        
endmodule
