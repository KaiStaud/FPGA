# About the Repo
This repo is my continously growing collection of FPGA projects.
Every project is dedicated to an peripheral or topic and implementated on an Xilinx ZYNQ 7000 SOC.


# Where to start ?
I use Xilinx' Vitis IDE for developing PL-PS projects. The current release is V2020.2(, which I'm currently using).
My development takes place on a windows host, but there shouldn't be any different steps between a my and an linux setup.
After installing Vitis (linux users: don't forget to source the IDE before starting and installing the cable drivers) download 
the necessary board files. If you are using a digilent board for development, its file can be found here along with an extensive description:
https://reference.digilentinc.com/reference/software/vivado/board-files?redirect=1

I recomend to create a simple project(i.e an simple and gate) for validating that Vitis is performing as expected.
After the sucessful install, feel free to visit the subdirectories.

## level 2 projects: 
###Simple beginner projects using the PL
- Buttons
- Static PWM
- Dynamic PWM
- RGB Fader

## level 1 projects:
###PL and PS are used together, but without any operation system ( only superloop with interrupts)
- ZYNQ_AXI_GPIO
- ZYNQ_XADC
- ZYNQ_PL_PS

## level 0 projects:
###Releasing the full power of the ZYNQ Core: Running PL and PS simulatiously aswell as an Yocto project based OS supported by an Freertos Realtime OS
