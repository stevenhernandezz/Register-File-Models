/***************************************************************************
***                                                                      ***
*** EE 526 L Experiment #8                 Steven Hernandez, Fall, 2023 ***
***                                                                      ***
*** Experiment #8 Register File Models		                               ***
***                                                                      ***
****************************************************************************
*** Filename: MEM_tb2.v       Created by Steven Hernandez, 11/10/23          ***
***                                                                      ***
****************************************************************************
*** This module is a testbench for my register which will:               ***
*** initialize memory from a seperate file, demonstrate that the memory  ***
*** has been successfuly initialized, show the unspecified locations,    ***
***read specific locations, scramble each bye, and write the new byte    ***
****************************************************************************/

`timescale 1 ns / 1 ns
`define MONITOR_STR_1  "%d: Address = %h, Data = %b, OE = %b, CS = %b" 
module MEM_tb2;
    parameter MEMSIZE=32;
     reg OE; //output enable 
     reg CS; //chip select
     wire  [7:0] DATA;
     reg [7:0] DATA_TEMP, DATA_TEMP2;
     reg [4:0] ADDR;
     reg [31:0] ROM_MEM;
    integer i;
    reg clk;
    
    //instant.
    ROM R1(.OE(OE), .CS(CS), .DATA(DATA), .ADDR(ADDR));
  
    
    initial begin
    $monitor(`MONITOR_STR_1, $time, ADDR, DATA, OE, CS);
end // monitoring from main code
 
   initial begin 
	$vcdpluson;
 
 	$readmemh("test.mem", R1.ROM_MEM);    //readmemb
    ADDR=0; OE=0; CS=1;
    

    // All memory initialized
    $display("All memory successfully initialized");
    for(i=0; i<32; i=i+1) begin
        ADDR=i; 
        OE=1; 
        CS=0;
        #2;
    end
    
    //Unspecified locations
  $display("Unspecified Locations");
  $display("Address %h, DATA %b", 5'h00, R1.ROM_MEM[0]);
  $display("Address %h, DATA %b", 5'h01, R1.ROM_MEM[1]);
  $display("Address %h, DATA %b", 5'h02, R1.ROM_MEM[2]);
  $display("Address %h, DATA %b", 5'h03, R1.ROM_MEM[3]);
  $display("Address %h, DATA %b", 5'h18, R1.ROM_MEM[24]);
  $display("Address %h, DATA %b", 5'h19, R1.ROM_MEM[25]);
  $display("Address %h, DATA %b", 5'h1a, R1.ROM_MEM[26]);
  $display("Address %h, DATA %b", 5'h1b, R1.ROM_MEM[27]);
  $display("Address %h, DATA %b", 5'h1f, R1.ROM_MEM[31]);
  
    //scramble 
   $display("Scramble Data");
    for(i = 16; i < 23; i=i+1) begin
      ADDR = i;
      DATA_TEMP2 = R1.ROM_MEM[i];
      DATA_TEMP2 = {DATA_TEMP2[0], DATA_TEMP2[7], DATA_TEMP2[1], DATA_TEMP2[6], DATA_TEMP2[2], DATA_TEMP2[5], DATA_TEMP2[3], DATA_TEMP2[4]};
      DATA_TEMP = DATA_TEMP2;
      CS = 0;
      OE = 1;
      R1.ROM_MEM[i] = DATA_TEMP;
      #1 $display(`MONITOR_STR_1, $time, ADDR, DATA, OE, CS);
   end
     
   //printing contents of all memory locations 
   // read from rom
    $display("All contents of all memory locations");
    for(i=0; i<32; i=i+1) begin
        ADDR=i; 
        OE=1; 
        CS=0;
        #2;
    end
    end
endmodule