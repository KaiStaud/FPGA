/******************************************************************************
*
* Copyright (C) 2009 - 2014 Xilinx, Inc.  All rights reserved.
*
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files (the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions:
*
* The above copyright notice and this permission notice shall be included in
* all copies or substantial portions of the Software.
*
* Use of the Software is limited solely to applications:
* (a) running on a Xilinx device, or
* (b) that interact with a Xilinx device through a bus or interconnect.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
* XILINX  BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
* WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF
* OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
* SOFTWARE.
*
* Except as contained in this notice, the name of the Xilinx shall not be used
* in advertising or otherwise to promote the sale, use or other dealings in
* this Software without prior written authorization from Xilinx.
*
******************************************************************************/

/*
 * helloworld.c: simple test application
 *
 * This application configures UART 16550 to baud rate 9600.
 * PS7 UART (Zynq) is not initialized by this application, since
 * bootrom/bsp configures it to baud rate 115200
 *
 * ------------------------------------------------
 * | UART TYPE   BAUD RATE                        |
 * ------------------------------------------------
 *   uartns550   9600
 *   uartlite    Configurable only in HW design
 *   ps7_uart    115200 (configured by bootrom/bsp)
 */

#include <stdio.h>
#include "platform.h"
#include "xil_printf.h"
#include "xgpio.h"
#include "xparameters.h"

int main()
{
	XGpio AXI_Input, AXI_Output_0, AXI_Output_1, AXI_LED;
	// Initialize AXI GPIO Blocks
	init_platform();
	XGpio_Initialize(&AXI_Input, XPAR_AXI_GPIO_2_DEVICE_ID); // Output of AND Gate

	XGpio_Initialize(&AXI_Output_0, XPAR_AXI_GPIO_0_DEVICE_ID); // Input 0 of AND Gate
	XGpio_Initialize(&AXI_Output_1, XPAR_AXI_GPIO_1_DEVICE_ID); // Input 2 of AND Gate
	XGpio_Initialize(&AXI_LED, XPAR_AXI_GPIO_3_DEVICE_ID); // LED

	XGpio_SetDataDirection(&AXI_Input, 1, 1);
	XGpio_SetDataDirection(&AXI_LED, 1, 0);
	XGpio_SetDataDirection(&AXI_Output_0, 1,1);
	XGpio_SetDataDirection(&AXI_Output_1, 1,1);


    print("Hello World\n\r");
    print("Successfully ran Hello World application");
    // Run Application:
    while(TRUE)
    {
    // Read input of PL AND Gate
    int pl_and_output = XGpio_DiscreteRead(&AXI_Input, 1);
    // Invert and write to LED
	XGpio_DiscreteWrite(&AXI_LED, 1, ~pl_and_output);

    // Write to PL AND Gate
    for(int and_input_a = 0x00; and_input_a <= 0x07;and_input_a++)
    {
    	for(int and_input_b = 0x00; and_input_b <= 0x07;and_input_b++)
    	{
    		//Write both inputs
    		XGpio_DiscreteWrite(&AXI_Output_0, 1, and_input_a);
    		XGpio_DiscreteWrite(&AXI_Output_1, 1, and_input_b);
    		sleep(1);

    	}
    }

    }
    cleanup_platform();
    return 0;
}
