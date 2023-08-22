`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 22.08.2023 23:54:44
// Design Name: 
// Module Name: lemmings_initial
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


module lemmings_initial(
    input clk,
    input areset,    // Freshly brainwashed Lemmings walk left.
    input bump_left,
    input bump_right,
    output walk_left,
    output walk_right

    );
    parameter L=0, R=1;
    reg state, next_state;

    always @(*)
        begin
            case(state)
                L:next_state=(bump_left)?R:L;
                R:next_state=(bump_right)?L:R;
            endcase
        end

    always @(posedge clk, posedge areset)
        begin
            if(areset) state<=L;
            else state<=next_state;
        end

    assign walk_left=(state==L)?1'b1:1'b0;
    assign walk_right=(state==R)?1'b1:1'b0;
endmodule
