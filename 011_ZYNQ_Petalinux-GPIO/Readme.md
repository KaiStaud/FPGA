Minimal project on generating petalinux to program the PL.
The PL-Design is copied from AXI_GPIO project, and the bitstream generated accordingly.

To build a petalinux distribution, get the installer from the Xilinx download page and run the final installer:
./final-installer /opt/pkg/petalinux
source /opt/pkg/petalinux/Petalinux/2024.1/bin/settings.sh

Then create a new project directory inside the environment and generate a petalinux project 

petalinux-create project --template zynq  -n axi-gpio
petalinux-config --get-hw-description /opt/pkg/petalinux/FPGA/ZYNQ_AXI_GPIO/

Configure the Linux Kernel Boot Args to use the rfs on /dev/mmcblk0p1 ( SD-Card)

petalinux-config

-> Image Packaging Configuration -> Root filesystem type : Select SD

petalinux-build will fail because this ZYNQ Board only contains one CPU Core. 
To accomodate for this property, copy system-user.dtsi to <project-dir>/project-spec/meta-user/recipes-bsp/device-tree/files.

device-tree.bbappend will override the default device-tree and delete the nodes of CPU1 and dependend nodes.
``` 
FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

SRC_URI:append = " file://system-user.dtsi"

require ${@'device-tree-sdt.inc' if d.getVar('SYSTEM_DTFILE') != '' else ''}
```

After the initial config, build the image with "petalinux-build"

After bitbake finishes, package the Bootloader and create a .wic sdcard-image:

petalinux-package boot --force --fsbl images/linux/zynq_fsbl.elf  --u-boot images/linux/u-boot.elf  -f <path-to-repository>/FPGA/011_Petalinux-GPIO/design_1_wrapper.bit
petalinux-package wic

Then flash the image to an sdcard ( minimum 6GB Size).
For a faster flash progress, use bmaptool to skip empty blocks.  
