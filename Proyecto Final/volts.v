`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/12/2015 03:26:51 PM
// Design Name: 
// Module Name: // Project Name: 
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
 

module volts(
   input CLK100MHZ,
   input [15:0] data,
   
   output reg [3:0] dig0,
   output reg [3:0] dig1,
   output reg [3:0] dig2,
   output reg [3:0] dig3,
   output reg [3:0] dig4,
   output reg [3:0] dig5,
   output reg [3:0] dig6
 );
   wire enable;
   wire ready;
   //wire [15:0] data;
   
   reg [32:0] decimal;
   reg [6:0] Address;
   

//   wire test;
   
     reg [32:0] count; 
      always @ (posedge(CLK100MHZ))
      begin
      
        if(count == 20000000)begin
        
        decimal = data >> 4;
        //looks nicer if our max value is 1V instead of .999755
        if(decimal >= 4093)
        begin
            dig0 = 0;
            dig1 = 0;
            dig2 = 0;
            dig3 = 0;
            dig4 = 0;
            dig5 = 0;
            dig6 = 1;
            count = 0;
        end
        else 
        begin
            decimal = decimal * 250000;
            decimal = decimal >> 10;
            
            
            dig0 = decimal % 10;
            decimal = decimal / 10;
            
            dig1 = decimal % 10;
            decimal = decimal / 10;
                   
            dig2 = decimal % 10;
            decimal = decimal / 10;
            
            dig3 = decimal % 10;
            decimal = decimal / 10;
            
            dig4 = decimal % 10;
            decimal = decimal / 10;
                   
            dig5 = decimal % 10;
            decimal = decimal / 10; 
            
            dig6 = decimal % 10;
            decimal = decimal / 10; 
            
            count = 0;
        end
       end
       
      count = count + 1;
               
      end
      
endmodule