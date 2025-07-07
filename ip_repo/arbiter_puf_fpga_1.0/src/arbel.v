`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04.07.2025 14:38:40
// Design Name: 
// Module Name: arbel
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

(* dont_touch = "true" *)
module arbel(
    input a,b,s,
    output o1,o2
    );
    
    wire w1,w2;
    mux m1( .i0(a), .i1(b), .s(s), .o(w1));
    mux m2( .i0(a), .i1(b), .s(s), .o(w2));
    
    assign o1= ~w1;
    assign o2= ~w2;
    
endmodule
