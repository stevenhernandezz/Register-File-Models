# Register-File-Models
 This Verilog project consists of models for a register file (RAM) and a read-only memory (ROM), along with  testbenches to validate their functionality.
 
## Description 
The register file (RAM) has the following features:
 - An 8-bit bi-directional data bus.
 - A 5-bit address bus.
 - Active high output enable (oe) signal.
 - Active low chip select (cs) signal.
 - Write operation triggered by rising edge of write strobe (ws) if oe is not enabled.
 - Data retrieval from specified address when oe is high.
 - Continuous block read while oe is high.
 - Data bus transitions to high impedance state when oe goes low.
 - cs must be low to enable read or write operations.

The ROM model has the following features:
 - Is designed for read-only access.
 - Features an output-only data port (not bidirectional).
 - Utilizes Verilog system tasks $readmemb and/or $readmemh for initializing memory contents.

The testbench for the register file must:
 - Write to and read from every memory location sequentially.
 - Demonstrate both individual and block read operations.
 - Verify both enabled and disabled states of the memory.
 - Confirm high impedance state of the data bus.
 - Validate that the memory has 32 locations with unique values.
 - Implement a Walking Ones pattern to test independent operation of output bits.
 - Initializes memory with specified hexadecimal values using $readmemh.
 - Validates successful initialization of memory contents.
 - Demonstrates that unspecified memory locations remain undefined.
 - Scrambles bytes in specific memory locations and writes back the modified values.
 - Prints the contents of all memory locations for verification, including detailed waveform printouts.



## Dependencies
### Software
* https://mobaxterm.mobatek.net/

### Author
* Steven Hernandez
  - www.linkedin.com/in/steven-hernandez-a55a11300
  - https://github.com/stevenhernandezz
