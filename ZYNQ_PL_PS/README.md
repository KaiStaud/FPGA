## Project Overview
The Project shows how to write PL data to the PS via the AXI Interface.
The onboard userbuttons are used as an input to an and gate, and the resolving output is 
then written to the PS via the AXI Interface and displayed using one LED.
The PS then switches the onboard LED according to the truth table of an inverter gate.

## How to build this project?
1. Recreate the following block design and add the provided master.xdc 
![Reference Block Design](https://github.com/KaiStaud/FPGA/edit/master/ZYNQ_PL_PS/BlockDesign.png)
1.1. Customize the AXI Blocks: AXI Block 0 is used as 1-Bit input the Block 1 is used as 1-Bit Output)
2. Create the HDL-Wrapper and generate the Bitstream
3. Export the Hardware and start Vitis IDE
4. Build Platform and Application Project ( change the helloworld.c as in this repo)
5. Program FPGA

## Possible Errors, when building Bitstream
- Too many whitespaces in contstraints. Use only one space betweeen characters
- External Connections from AXI Block to Board Pins are not assigned as Bus [x:y], make shure the Bus is at least one bit wide.
