`timescale 10ms / 1ms

module seven_seg_disp(clk,current_floor,disp);
    input clk;
    input [1:0] current_floor;
    output reg [7:0] disp;

    //to display on 7 seg
    always@(current_floor)
    begin
        case(current_floor)
            0 : disp = 8'b01111111;//0
            1 : disp = 8'b00000110;//1  
            2 : disp = 8'b01011011;//2  
            3 : disp = 8'b01001111;//3  
            default : disp = 8'b10000000;
        endcase
    end
endmodule
