# About the Repo
This repo is my continously growing collection of FPGA projects.
Every project is dedicated to an peripheral or topic and implementated on an Xilinx ZYNQ 7000 SOC.


# Where to start ?
I use Xilinx' Vitis IDE for developing PL-PS projects. The current release is V2020.2(, which I'm currently using).
I'm currently using Ubuntu 16.04.07 LTS for development.

## Linux specific installation Steps
**Please use one of Xilinx (officially) supported distributions(https://www.xilinx.com/support/documentation/sw_manuals/xilinx2020_2/ug973-vivado-release-notes-install-license.pdf) . Otherwise you might not be able to export the hardware to Vitis or experience other errors. This will not be solved by changing the distribution string in /etc/os-releases to an official supported distro! I also recommend to use a distro which is also supported by the Yocto Project(https://www.yoctoproject.org/docs/2.0/ref-manual/ref-manual.html#detailed-supported-distros), if you want to follow my further advanced projects!**

After installing Vitis install the cable drivers:
Follow digilents guide to install the necessary drivers:
https://reference.digilentinc.com/reference/programmable-logic/guides/install-cable-drivers

create a working directory : mkdir ~/vivado
For a linux install, the xilinx's enviroment needs to be sourced: source /tools/Xilinx/Vivado/2020.2/settings64.sh
If the command fails try the following steps:
- use bash only ( I tried fish and zsh and ran into errors sourcing the file)
- install ncurses-dev (sudo apt-get install ncurses-dev)
- Change the permission of the install directory: chown 777 /tools/Xilinx

After successfully sourcing the directory from ~ ,type: vivado &. Vivado should now start.
You might want a desktop shortcut to launch the enviroment quick and easy, therefore create an desktop entry:

## Installing board files
For using the digilent boards, install the their boardfiles as described here:
https://reference.digilentinc.com/reference/software/vivado/board-files?redirect=1
(On linux unzip the download and move it to the board file directory: mv digilent_boards_master /tools/Xilinx/Vivado/2020.2/data/boards/board_files)

I recomend to create a simple project(i.e an simple and gate) for validating that Vitis is performing as expected.
After the sucessful install, feel free to visit the subdirectories.

## level 2 projects: 
### Simple beginner projects using the PL
- Buttons
- Static PWM
- Dynamic PWM
- RGB Fader

## level 1 projects:
### PL and PS are used together, but without any operation system ( only superloop with interrupts)
- ZYNQ_AXI_GPIO
- ZYNQ_XADC
- ZYNQ_PL_PS

## level 0 projects:
### Releasing the full power of the ZYNQ Core: Running PL and PS simulatiously aswell as an Yocto project based OS supported by an Freertos Realtime OS
