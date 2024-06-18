`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 24.11.2023 10:47:29
// Design Name: 
// Module Name: traffic_controller
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


module traffic_controller(north_light,west_light,south_light,east_light,clk,reset);
output reg [2:0] north_light,west_light,south_light,east_light;
input clk;
input reset;
reg [2:0] state;
parameter [2:0] north=3'b000, north_yellow=3'b001, west=3'b010, west_yellow=3'b011,
east=3'b100, east_yellow=3'b101,south=3'b110, south_yellow=3'b111;
reg [3:0] count;
always @(posedge clk, posedge reset)
    begin
        if(reset)
            begin
                state=north;
                count=3'b0000;
            end
        else
            begin
                case(state)
                north :
                    begin
                        if (count==4'b1111)
                            begin
                            count=4'b0000;
                            state=north_yellow;
                            end
                        else
                            begin
                            count=count+4'b0001;
                            state=north;
                            end
                     end
                 north_yellow :
                    begin 
                        if(count==4'b0011)
                            begin
                            count=4'b0000;
                            state=west;
                            end
                        else
                            begin
                            count=count+4'b0001;
                            state=north_yellow;
                        end
                     end
                 west :
                    begin
                        if (count==4'b1111)
                            begin
                            count=4'b0000;
                            state=west_yellow;
                            end
                        else
                            begin
                            count=count+4'b0001;
                            state=west;
                            end
                     end
                 west_yellow :
                    begin 
                        if(count==4'b0011)
                            begin
                            count=4'b0000;
                            state=south;
                            end
                        else
                            begin
                            count=count+4'b0001;
                            state=west_yellow;
                        end
                     end
                 south :
                    begin
                        if (count==4'b1111)
                            begin
                            count=4'b0000;
                            state=south_yellow;
                            end
                        else
                            begin
                            count=count+4'b0001;
                            state=south;
                            end
                     end
                 south_yellow :
                    begin 
                        if(count==4'b0011)
                            begin
                            count=4'b0000;
                            state=east;
                            end
                        else
                            begin
                            count=count+4'b0001;
                            state=south_yellow;
                        end
                     end
                 east :
                    begin
                        if (count==4'b1111)
                            begin
                            count=4'b0000;
                            state=north_yellow;
                            end
                        else
                            begin
                            count=count+4'b0001;
                            state=east;
                            end
                     end
                 east_yellow :
                    begin 
                        if(count==4'b0011)
                            begin
                            count=4'b0000;
                            state=north;
                            end
                        else
                            begin
                            count=count+4'b0001;
                            state=east_yellow;
                        end
                     end
                   endcase
                  end
                 end
always @(state)
    begin
        case(state)
            north :
                begin
                    north_light=3'b001;
                    south_light =3'b100;
                    east_light=3'b100;
                  
                    west_light =3'b100;
                end
             north_yellow :
                begin
                    north_light=3'b100;
                    south_light =3'b100;
                    east_light=3'b100;
                    west_light =3'b100;
                end
            south :
                begin
                    north_light=3'b100;
                    south_light =3'b001;
                    east_light=3'b100;
                    west_light =3'b100;
                end
             south_yellow :
                begin
                    north_light=3'b100;
                    south_light =3'b010;
                    east_light=3'b100;
                    west_light =3'b100;
                end
             west :
                begin
                    north_light=3'b100;
                    south_light =3'b100;
                    east_light=3'b100;
                    west_light =3'b001;
                end
             west_yellow :
                begin
                    north_light=3'b100;
                 
                    south_light =3'b100;
                    east_light=3'b100;
                    west_light =3'b010;
                end
             east :
                begin
                   north_light=3'b100;
                    south_light =3'b100;
                    east_light=3'b100;
                    west_light =3'b100;
                end
             east_yellow :
                begin
                    north_light=3'b100;
                    south_light =3'b100;
                    east_light=3'b100;
                    west_light =3'b100;
                end
               endcase
               end
             
               
                                          
                            
                            
                         
                            
                          
        
   


 
   
endmodule
