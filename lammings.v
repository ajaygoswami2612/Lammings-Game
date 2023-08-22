`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 22.08.2023 22:17:55
// Design Name: 
// Module Name: lammings
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


module lammings( input clk,
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
    parameter L=0;
    parameter R=1;
    parameter F_L=2;
    parameter F_R=3;
    parameter D_L=4;
    parameter D_R=5;
    parameter SP=6;
             // L: walk left, R:walk right  F_L: fall left, F_R: fall right, D_L: dig on left side,
            // D_R : dig on right side, SP: splat;
    reg [2:0] state,next_state;
    integer i;
     always@(*)
        begin
            case(state)
                L:
                  begin
                    if(~ground) next_state=F_L;
                    else
                        begin
                            if(dig) next_state=D_L;
                            else
                                begin
                                    if(bump_left) next_state=R;
                                    else next_state=L;
                                end
                        end
                    end
                          //next_state=ground?(dig?D_L:(bump_left?R:L)):F_L;
                   // if(~ground) next_state=F_l;
                   // else if(dig) next_state=D_L;
                   // else if(bump_left) next_state=R;
                   // else next_state=L;
                R:
                  begin
                        if(~ground) next_state=F_R;
                        else
                            begin
                                if(dig) next_state=D_R;
                                else
                                    begin
                                        if(bump_right) next_state=L;
                                        else next_state=R;
                                    end
                            end
                   end
                    //next_state=ground?(dig?D_R:(bump_right?L:R)):F_R;             
                    /*begin
                    if(~ground) next_state=F_R;
                    else if(dig) next_state=D_R;
                    else if(bump_right) next_state=L;
                    else next_state=R;
                end
                */
                
                F_L: begin
                    if(ground)
                       begin
                       if(i>20) next_state=SP;
                       else     next_state=L;
                       end
                    else next_state=F_L;
                    end
                       // next_state=(ground==1)?((i>20)?SP:L):F_L;
                       
                F_R:  begin
                    if(ground)
                       begin
                       if(i>20) next_state=SP;
                       else     next_state=R;
                       end
                    else next_state=F_R;
                    end 
                     // next_state=(ground==1)?((i>20)?SP:R):F_R; 
                     
               D_L:begin
                    if(~ground) next_state=F_L;
                    else next_state=D_L;
                end
                D_R: begin
                    if(~ground) next_state=F_R;
                    else next_state=D_R;
                end
                SP: next_state=SP;
                default:next_state=L;
            endcase
        end
        
        
     always@(posedge clk,posedge areset)
                    begin
                        if(areset) begin
                        state<=L;
                        end
                        else
                            state<=next_state;
                    end
                
    always@(posedge clk,posedge areset)
                   begin
                       if(areset)  i<=0;
                       else
                          begin
                             if(~ground) i<=i+1;
                             else i<=0;
                          end
                    end
                    
   assign walk_left=(state==SP)?1'b0:(state==L);
   assign walk_right=(state==SP)?1'b0:(state==R);
   assign aaah=(state==SP)?1'b0:((state==F_L)|(state==F_R));
   assign digging=(state==SP)?1'b0:((state==D_L)|(state==D_R));
endmodule
