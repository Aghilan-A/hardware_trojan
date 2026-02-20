#include <stdio.h>
#include "platform.h"
#include "xil_printf.h"
#include "xuartps.h"
#include <string.h> // Added for memcmp function

#define NUM_OF_BYTE 4

XUartPs_Config *Config_1;
XUartPs Uart_PS_1;


const unsigned char elf_string[] = {0x7f, 0x45, 0x4C, 0x46};
char hacked_string[] = "Hacked";

int main()
{
    init_platform();
    int Status;
    u8 BufferPtr_rx[NUM_OF_BYTE]; // Changed to an array of bytes
    u8 check[NUM_OF_BYTE] = {0};

    /*************************
     * UART 1 initialization *
     *************************/
    Config_1 = XUartPs_LookupConfig(XPAR_PS7_UART_1_DEVICE_ID);
    if (NULL == Config_1) {
        return XST_FAILURE;
    }
    Status = XUartPs_CfgInitialize(&Uart_PS_1, Config_1, Config_1->BaseAddress);
    if (Status != XST_SUCCESS) {
        return XST_FAILURE;
    }
    while(1) {
        // Sending the check array over UART
        XUartPs_Send(&Uart_PS_1, check, (NUM_OF_BYTE));

        Status = 0;
        while (Status < NUM_OF_BYTE) {
            // Receiving data byte by byte
            Status += XUartPs_Recv(&Uart_PS_1, &BufferPtr_rx[Status], 1);
        }

        // Comparing received bytes with elf_string
        if (memcmp(BufferPtr_rx, elf_string, NUM_OF_BYTE) == 0) {
            // If condition met, sending "Hacked" over UART
            XUartPs_Send(&Uart_PS_1, hacked_string, strlen(hacked_string));
            xil_printf("Success!!");
        } else {
        	xil_printf("BufferPtr_rx:");
        	xil_printf("\n");
            xil_printf(BufferPtr_rx);
        }
    }
    cleanup_platform();
    return 0;
}
