## Introduction
The Projects uses the PS to read the attached Voltages to the Analog Pins of the board.
The sources are addapted from digilents github repo and changed slightly, so that the bitstream can be generated with Vivado 2020.2 .

## How to build the project?
Recreate the following block design:

Create the HDL-Wrapper and generate the bitstream.
Build the Plattform and Application Project, add the supplied .c and .h files.
Launch on Hardware and open the Serial Monitor, the ADCs can be changed by pressing the buttons, the ADC-Voltage will be printed in the terminal
