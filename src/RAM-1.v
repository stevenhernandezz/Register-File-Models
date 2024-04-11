/***************************************************************************
***                                                                      ***
*** EE 526 L Experiment #8                 Steven Hernandez, Fall, 2023 ***
***                                                                      ***
*** Experiment #8 Register File Models		                               ***
***                                                                      ***
****************************************************************************
*** Filename: RAM.v       Created by Steven Hernandez, 10/29/23          ***
***                                                                      ***
****************************************************************************
*** This module is for a register file which will act like RAM:           ***
*** This file will have a bi-directional data bus, and will be able to   ***
*** read and write data to memory                                       ***
****************************************************************************/

`timescale 1 ns / 1 ns
module RAM( DATA, ADDR, OE, WS, CS);
   //Param for width and depth
  parameter DATA_WIDTH=8;
  parameter ADDR_WIDTH=5;
  parameter MEMSIZE = (1<<ADDR_WIDTH);  //size of memory= 2**5
  
    //8 bit bi-directional data bus
  inout [DATA_WIDTH-1:0] DATA;
  
  //inputs 
      //input clk;
      input wire OE;
      input wire WS;
      input wire CS;
      input [ADDR_WIDTH -1:0] ADDR;
      reg [DATA_WIDTH-1:0] DATA_OUT;
      
  reg [DATA_WIDTH-1:0] RAM_MEM [0:MEMSIZE-1]; //mem declaration 
  
    always @(posedge WS) begin    // processesing posedge ws
        if(!CS) begin        // active low chip select
          RAM_MEM[ADDR] <= DATA; // write data to memory
          end
          else if(OE) begin    // output enabled low then
                DATA_OUT<= RAM_MEM[ADDR]; // read
        end
  end
        assign DATA = (!CS & OE) ? RAM_MEM[ADDR] : 8'bz; //assign for data inout
endmodule
        
