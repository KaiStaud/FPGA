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
#include "xparameters.h"
#include  "xgpio.h"

#define R 0x04
#define G 0x02
#define B 0x03

#define R1 0x07
#define G1 0x06
#define B1 0x05


XGpio gpio;

void driverInit() {
	int status;
	status = XGpio_Initialize(&gpio, XPAR_AXI_GPIO_0_DEVICE_ID);
	if (status != XST_SUCCESS) {
		print("Err: Gpio initalization failed\n\r");
	} else {
		print("Info: Gpio Initialization successful\n\r");
	}
}

void configGpio() {
	XGpio_SetDataDirection(&gpio, 1, 0);
	XGpio_SetDataDirection(&gpio, 2, 1);
	XGpio_DiscreteSet(&gpio, 1, 0);
}


void  cycleLeds()
{
	while(1)
	{
		int button = XGpio_DiscreteRead(&gpio, 2);
		//xil_printf("%d: ",button);
		if(button == 1)
		{
			XGpio_DiscreteWrite(&gpio, 1, R);
			sleep(1);
			XGpio_DiscreteWrite(&gpio, 1, G);
			sleep(1);
			XGpio_DiscreteWrite(&gpio, 1, B);
			sleep(1);
			XGpio_DiscreteClear(&gpio, 1, R);
			sleep(1);
			XGpio_DiscreteClear(&gpio, 1, G);
			sleep(1);
			XGpio_DiscreteClear(&gpio, 1, B);
			sleep(1);
		}
		if(button == 2)
		{
			XGpio_DiscreteWrite(&gpio, 1, R1);
			sleep(1);
			XGpio_DiscreteWrite(&gpio, 1, G1);
			sleep(1);
			XGpio_DiscreteWrite(&gpio, 1, B1);
			sleep(1);
			XGpio_DiscreteClear(&gpio, 1, R1);
			sleep(1);
			XGpio_DiscreteClear(&gpio, 1, G1);
			sleep(1);
			XGpio_DiscreteClear(&gpio, 1, B1);
			sleep(1);
		}
	}
}

int main()
{
    init_platform();

    print("Hello World\n\r");
    print("Successfully ran Hello World application");
    driverInit();
    configGpio();
    cycleLeds();
    cleanup_platform();
    return 0;
}
