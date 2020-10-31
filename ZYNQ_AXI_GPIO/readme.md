# Setting up the Project
## Generating the block design using vivado
- open a new project and click 'Create new Block design'
- add the following blocks to the desing: ZYNQ
- Add GPIO to the board by clicking board -> 2 RGB Led, 2 Buttons
![](block_design.png)
- Validate the Design
- Create the HDL Wrapper
- Add the constraint file and generate bitstream
- Export Hardware (File -> Export Hardware) and launch Vitis

## Building C software using Vitis
- Build platform project, including the previously saved xsa file
- Build Application project upon the previously build platform project.
- Select 'helloworld project' and substitute its content with the file in the repo.
- Rebuild the project and select launch on hardware

## Demonstration
When sucessfully launched on board, the hardware can be tested by pressing the user buttons.
The leds should change according to the following gif below:
![](demo.gif)
