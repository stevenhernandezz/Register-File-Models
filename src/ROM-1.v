/***************************************************************************
***                                                                      ***
*** EE 526 L Experiment #8                 Steven Hernandez, Fall, 2023 ***
***                                                                      ***
*** Experiment #8 Register File Models		                               ***
***                                                                      ***
****************************************************************************
*** Filename: ROM.v       Created by Steven Hernandez, 10/29/23          ***
***                                                                      ***
****************************************************************************
*** This module is for a register file which will act like ROM:           ***
*** This file will have data bus, and will be able to read data           ***
****************************************************************************/

`timescale 1 ns / 1 ns
module ROM(DATA, ADDR, OE, CS);
      parameter ADDR_WIDTH = 5;  //size of addr bus
      parameter DATA_WIDTH = 8;  //width of data
      parameter MEMSIZE = 32;  //size of memory= 2**5
      
      input OE;
      input CS;
      input [ADDR_WIDTH -1:0] ADDR;
      output [DATA_WIDTH-1:0] DATA;
      reg [7:0] ROM_MEM [0:MEMSIZE-1];
     
     //assign for data 
     assign DATA = (!CS & OE) ? ROM_MEM[ADDR] : 8'bz;
endmodule
      
