`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    
// Design Name: 
// Module Name:   
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//1.	A brief road and two traffic lights with round lights can be seen, which is more like a real situation.
//2.	Two brief cars appear, and they can be controlled by software, since the value of reg_9_colour, reg_10_colour
//      reg_3_colour and reg_5_colour are utilized.
//////////////////////////////////////////////////////////////////////////////////
module VGAControl(
    clk,
    reset,
    colour_out,
    hs,
    vs,
    reg_0_colour,
    reg_1_colour,
    reg_2_colour,
    reg_3_colour,
    reg_4_colour,
    reg_5_colour,
    reg_6_colour,
    reg_7_colour,
    reg_8_colour,
    reg_9_colour,
    reg_10_colour,
    reg_11_colour
    );

    input clk;
    input reset;
    output [11:0] colour_out;
    output hs;
    output vs;
    input [11:0] reg_0_colour;
    input [11:0] reg_1_colour;
    input [11:0] reg_2_colour;
    input [11:0] reg_3_colour;
    input [11:0] reg_4_colour;
    input [11:0] reg_5_colour;
    input [11:0] reg_6_colour;
    input [11:0] reg_7_colour;
    input [11:0] reg_8_colour;
    input [11:0] reg_9_colour;
    input [11:0] reg_10_colour;
    input [11:0] reg_11_colour;
    
    wire reset;
            
    wire [9:0] addrh;
    wire [8:0] addrv;
    wire [9:0] X;
    wire [8:0] Y;
    wire [7:0] X_Car;
    wire [6:0] Y_Car;
    wire [9:0] X2;
    wire [8:0] Y2;
    wire [7:0] X_Car2;
    wire [6:0] Y_Car2;
    wire [11:0]Snake_COLOR;
    wire [14:0] Car_Address;
    reg  [11:0] colour;
    
    parameter Radius = 45*45;
    parameter Width = 107;
    parameter BLACK = 12'h000;
    parameter BLUE = 12'h00F;
    parameter YELLOW = 12'hFF0;
    parameter WHITE = 12'hFFF;

    
    assign X_Car=(reg_9_colour+50)/4;
    assign Y_Car=(reg_10_colour+25)/4;
    assign Car_Address = {Y_Car,X_Car};

    VGAInterface VGAInterface_instance (
        .CLK(clk), 
        .C_IN(colour), 
        .C_OUT(colour_out), 
        .HS(hs), 
        .VS(vs),
        .ADR_X(addrh),
        .ADR_Y(addrv)
    );
    Soft_Snake_Control Snake(
         .CLK(clk),
         .RESET(reset),    
         .X(addrh),
         .Y(addrv),
         .Random_Target_Address(Car_Address),
         .COLOR(Snake_COLOR)
        );
    
    assign Y2 = addrh - reg_3_colour;   //let the car2 move horizontally by reg_3_colour and then rotate by 90 degrees
    assign X2 = addrv - reg_5_colour;   //let the car2 move vertically by reg_5_colour and then rotate by 90 degrees
    //to be noticed, the order of "Y2" and "X2" is differnt with "X"and"Y". This is done to rotate the car by 90 degrees.
    
    assign X = addrh - reg_9_colour;    //let the car1 move horizontally by reg_9_colour
    assign Y = addrv - reg_10_colour;   //let the car1 move vertically by reg_10_colour

    always @(posedge clk) begin
        if (((addrv == 58)&&(addrh <= 320)) || ((addrv <= 160)&&(addrv>=58)&&(addrh==106))
            || ((addrv <= 160)&&(addrv>=58)&&(addrh==214))) //draw lines of roads
            colour <= BLACK;
        else if (((addrv <= 400)&&(addrv>=80)&&(addrh==587)) || ((addrh <= 587)&&(addrh>=480)&&(addrv==80))
            || ((addrh <= 587)&&(addrh>=480)&&(addrv==186)) || ((addrh <= 587)&&(addrh>=480)&&(addrv==292))
             || ((addrh <= 587)&&(addrh>=480)&&(addrv==400)))   //draw lines of traffic lights
            colour <= BLACK;
        else if((addrh-53)*(addrh-53)+(addrv-107)*(addrv-107)<Radius)   //round taffic lights
            colour <= reg_2_colour;
        else if((addrh-160)*(addrh-160)+(addrv-107)*(addrv-107)<Radius)
            colour <= reg_1_colour;
        else if((addrh-267)*(addrh-267)+(addrv-107)*(addrv-107)<Radius)
            colour <= reg_0_colour;
        else if((addrh-534)*(addrh-534)+(addrv-133)*(addrv-133)<Radius)
            colour <= reg_6_colour;
        else if((addrh-534)*(addrh-534)+(addrv-239)*(addrv-239)<Radius)
            colour <= reg_7_colour;
        else if((addrh-534)*(addrh-534)+(addrv-346)*(addrv-346)<Radius)
            colour <= reg_8_colour;

        else if ((addrh > 214) && (addrh < 320) && (addrv > 58) && (addrv < 160))   //quadrate backgrounds of traffic lights
            colour <= BLACK;
        else if ((addrh > 106) && (addrh < 214) && (addrv > 58) && (addrv < 160))
            colour <= BLACK;
        else if ((addrh > 0) && (addrh < 106) && (addrv > 58) && (addrv < 160))
            colour <= BLACK;
        else if ((addrh > 214) && (addrh < 320) && (addrv > 320) && (addrv < 427))
            colour <= reg_4_colour;
        else if ((addrh > 480) && (addrh < 587) && (addrv > 80) && (addrv < 186))
            colour <= BLACK;
        else if ((addrh > 480) && (addrh < 587) && (addrv > 186) && (addrv < 292))
            colour <= BLACK;
        else if ((addrh > 480) && (addrh < 587) && (addrv > 292) && (addrv < 400))
            colour <= BLACK;
            
        else if (   (Y >= (2*X-140)) &&  (Y <= 20))     //display the car1 by "X" and "Y" 
                colour <= reg_11_colour;
        else if (   ((Y >= ((-2)*X+60))&&  (Y <= 20)) )
                colour <= reg_11_colour;
        else if (   (Y >= 0) &&  (Y <= 20) && (X <= 70) &&  (X >= 30)) 
                colour <= reg_11_colour;
        else if (   ((X >= 0) && (X <= 100) && (Y >= 20) && (Y < 35)) ||
                    ((X >= 20) && (X <= 35) && (Y > 35) && (Y < 50)) ||
                    ((X >= 65) && (X <= 80) && (Y > 35) && (Y < 50)) )
            colour <= reg_11_colour;
            
        else if (   (Y2 >= (2*X2-140)) &&  (Y2 <= 20))   //display the car2 by "X2" and "Y2" 
                colour <= BLACK;
        else if (   ((Y2 >= ((-2)*X2+60))&&  (Y2 <= 20)) )
                colour <= BLACK;
        else if (   (Y2 >= 0) &&  (Y2 <= 20) && (X2 <= 70) &&  (X2 >= 30)) 
                colour <= BLACK;
        else if (   ((X2 >= 0) && (X2 <= 100) && (Y2 >= 20) && (Y2 < 35)) ||
                    ((X2 >= 20) && (X2 <= 35) && (Y2 > 35) && (Y2 < 50)) ||
                    ((X2 >= 65) && (X2 <= 80) && (Y2 > 35) && (Y2 < 50)) )
                colour <= BLACK;
                
        else if ((addrh > 30) && (addrh < 130) && (addrv > 235) && (addrv < 245))   //dashes on the roads
            colour <= WHITE;
        else if ((addrh > 180) && (addrh < 280) && (addrv > 235) && (addrv < 245))
            colour <= WHITE;
        else if ((addrh > 395) && (addrh < 405) && (addrv > 15) && (addrv < 115))
            colour <= WHITE;
        else if ((addrh > 395) && (addrh < 405) && (addrv > 365) && (addrv < 465))
            colour <= WHITE;

        else if ((addrh > 0) && (addrh < 290) && (addrv > 160) && (addrv < 320))    //two gray roads
            colour <= 12'b1110_1110_1110;
        else if ((addrh > 320) && (addrh < 480) && (addrv > 0) && (addrv < 130))
            colour <= 12'b1110_1110_1110;
        else if ((addrh > 320) && (addrh < 480) && (addrv > 350) && (addrv < 480))
            colour <= 12'b1110_1110_1110;        

        else if ((addrh > 290) && (addrh < 320) && (addrv > 160) && (addrv < 320))  //3 yellow redestrian roads
            colour <= YELLOW;
        else if ((addrh > 320) && (addrh < 480) && (addrv > 130) && (addrv < 160))
            colour <= YELLOW;
        else if ((addrh > 320) && (addrh < 480) && (addrv > 320) && (addrv < 350))
            colour <= YELLOW;
        else if ((addrh == 320) || (addrh == 480) || ((addrv == 160)&&(addrh<=480))
        || ((addrv == 320))&&(addrh<=480))
            colour <= 12'b1110_1110_1110;
            
        else if ((addrh > 320) && (addrh < 480) && (addrv < (addrh-158)) && (addrv > (addrh-162)))  //two crossed lines on the centre
            colour <= 12'hEE0;
        else if ((addrh > 320) && (addrh < 480) && (addrv > (-addrh+638)) && (addrv < (-addrh+642)))
            colour <= 12'hEE0;

        else
            colour <= Snake_COLOR;//let a snake chase the car1, just for fun:)
//            colour <= 12'b1111_1111_1111;
    end
  
endmodule
