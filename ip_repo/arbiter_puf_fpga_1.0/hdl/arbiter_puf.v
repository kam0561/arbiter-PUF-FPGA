`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04.07.2025 15:09:51
// Design Name: 
// Module Name: arbiter_puf
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
module arbiter_puf(
    input a,b,
    input [63:0] c,
    output [63:0] response
    );
    
    genvar i;
    generate
    for(i=0;i<64;i=i+1)
    begin
        arbiter arbiterinst( .a(a), .b(b), .c(c), .z(response[i]));
    end
    endgenerate
    
endmodule
