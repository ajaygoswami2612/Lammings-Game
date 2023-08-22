`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.08.2023 00:00:32
// Design Name: 
// Module Name: lemmings_digging
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


module lemmings_digging(
 input clk,
    input areset,    // Freshly brainwashed Lemmings walk left.
    input bump_left,
    input bump_right,
    input ground,
    input dig,
    output walk_left,
    output walk_right,
    output aaah,
    output digging

    );
       parameter L=0,R=1,F_L=2,F_R=3,D_L=4,D_R=5;
    reg [2:0] state,next_state;
    always@(*)
        begin
        case(state)
            L:begin
                if(~ground) next_state=F_L;
                else if(dig) next_state=D_L;
                else if(bump_left) next_state=R;
                else next_state=L;
            end
            R: begin
                if(~ground) next_state=F_R;
                else if(dig) next_state=D_R;
                else if(bump_right) next_state=L;
                else next_state=R;
            end
            F_L: next_state=(ground)?L:F_L;
            F_R: next_state=(ground)?R:F_R;
            D_L: begin
                if(~ground) next_state=F_L;
                else next_state=D_L;
            end
            D_R:begin 
                if(~ground) next_state=F_R;
                else next_state=D_R;
            end
        endcase
    end
    always@(posedge clk,posedge areset)
        begin
        if(areset) state<=L;
        else state<=next_state;
        end
    assign walk_left=(state==L)?1'b1:1'b0;
    assign walk_right=(state==R)?1'b1:1'b0;
    assign digging=((state==D_L)|(state==D_R))?1'b1:1'b0;
    assign aaah=((state==F_L)|(state==F_R))?1'b1:1'b0;
endmodule
