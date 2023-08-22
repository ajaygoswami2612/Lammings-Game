`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 22.08.2023 23:57:57
// Design Name: 
// Module Name: lemmings_fall
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


module lemmings_fall(
    input clk,
    input areset,    // Freshly brainwashed Lemmings walk left.
    input bump_left,
    input bump_right,
    input ground,
    output walk_left,
    output walk_right,
    output aaah

    );
    parameter L=0,R=1,F_L=2,F_R=3;
    reg[1:0] state,next_state;
    always@(*)
        begin
        case(state)
            L:begin
                if(~ground) next_state=F_L;
                else if(bump_left) next_state=R;
                else next_state=L;
              end
              
            R:begin
                if(~ground) next_state=F_R;
                else if(bump_right) next_state=L;
                else next_state=R;
               end
            F_L:next_state=(ground)?L:F_L;
            F_R: next_state=(ground)?R:F_R;
        endcase
    end
    always@(posedge clk,posedge areset)
        begin
            if(areset) state<=L;
            else state<=next_state;
            
        end
    assign walk_left=(state==L)?1'b1:1'b0;
    assign walk_right=(state==R)?1'b1:1'b0;
    assign aaah=((state==F_L)|(state==F_R))?1'b1:1'b0;
endmodule
