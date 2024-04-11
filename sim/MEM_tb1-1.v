/***************************************************************************
***                                                                      ***
*** EE 526 L Experiment #8                 Steven Hernandez, Fall, 2023  ***
***                                                                      ***
*** Experiment #8 Register File Models		                               ***
***                                                                      ***
****************************************************************************
*** Filename: MEM_tb1.v       Created by Steven Hernandez, 11/10/23      ***
***                                                                      ***
****************************************************************************
*** This module is a testbench for my register which will:               ***
*** write ti abd read from every memory location, have both enable and   ***
***disable states, have individualy and block read, show that there are 32 ***
***locations in memory, and have a show that all output bits are capable of ***
***operating dependently                                                  ***
****************************************************************************/

`timescale 1 ns / 1 ns
`define MONITOR_STR_1  "%d: Address = %b, Data = %b, OE = %b, CS = %b, WS = %b" 
module RAM_TB;
  reg clk;
  integer i;
  reg OE; // Output Enable
  reg WS; // Write Strobe
  reg CS; // Chip Select
  reg [7:0] DATA; // Data Bus
  reg [4:0] ADDR; // Address Bus
  wire [7:0] DATA_OUT; // Data output from RAM

  // Instantiate the RAM module
  RAM R1 (.OE(OE),.WS(WS),.CS(CS),.DATA(DATA_OUT),.ADDR(ADDR));
   //assign  DATA = (!CS & !OE) ? DATA_OUT : 8'bz;
  
  	initial begin
    $monitor(`MONITOR_STR_1, $time, ADDR, DATA, OE, CS, WS);
end // monitoring from main code
 
  initial begin 
	$vcdpluson;
 
  //initialization
    OE = 0;
    WS = 0;
    CS = 0;

    // Write to and read from every memory location
     for (i = 0; i < 32; i = i + 1) begin
      ADDR=i;
      DATA = i; 
      CS=0;
      WS = 0;
      #2
       WS = 1;
    end

    // Block read
    $display("Block Read:");
    for(i=0; i<4; i=i+1) begin
    ADDR=i;
    #2 WS = 0;
    #2 CS = 0;
    #2 OE = 1;
    $display(`MONITOR_STR_1, $time, ADDR, DATA, OE, CS, WS);
end
    
    // Individual read
    $display("individual Read:");
    for(i=0; i<4; i=i+1) begin
    ADDR=i;
    DATA=i;
    #2 OE = 1;
    #2 CS = 0;
    #2 WS = 1;
     DATA = DATA<<1;
    $display(`MONITOR_STR_1, $time, ADDR, DATA, OE, CS, WS);
end

    // disabled state
    $display("Disabled state:");
     OE = 1;
    #2 WS = 0;
    #2 CS = 1;
    ADDR=1;
    #2 $display(`MONITOR_STR_1, $time, ADDR, DATA, OE, CS, WS);
    
    //Enable state
    $display("Enable state:");
    #2 WS = 1;
    #2 CS = 0;
    #2 OE = 1;
    ADDR = 2;
    DATA = 8'b00000010;
    #2 $display(`MONITOR_STR_1, $time, ADDR, DATA, OE, CS, WS);

    // High impedance state
    #2 CS=1;
    #2 OE=1;
    #2 WS=1;
    #2 $display("High Impedance State: Data = %b", DATA_OUT);
    
    // Walking Ones 
    for (i=0; i<32; i=i+1) begin
      ADDR=i;
      DATA=i;
      WS = 1;
      CS = 0;
      OE = 0;
      #1 OE=0;
      //#1 WS=0;
      #1 DATA = 8'b1 <<1;
    end
    
     $finish;
  end
endmodule