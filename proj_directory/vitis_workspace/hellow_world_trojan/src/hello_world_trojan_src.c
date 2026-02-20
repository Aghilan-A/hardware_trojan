#include <stdio.h>
#include "platform.h"
#include "xil_printf.h"
#include "xuartps.h"

#define NUM_OF_BYTE 5

XUartPs_Config *Config_0;
XUartPs Uart_PS_0;
XUartPs_Config *Config_1;
XUartPs Uart_PS_1;

char test[] = "Hello";
char hacked_string[] = "Hacked";
int main()
{
    init_platform();
    int Status;
    u8 BufferPtr_rx;
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
    while(1){
        XUartPs_Send(&Uart_PS_1, check, (NUM_OF_BYTE));
        Status = -1;
        while (Status < NUM_OF_BYTE) {
            Status += XUartPs_Recv(&Uart_PS_1, BufferPtr_rx, 1);
            if(BufferPtr_rx != '\n'){
                            check[Status] = BufferPtr_rx;
            }
        }

        for(int i =0;i<NUM_OF_BYTE;i++)
        {
            xil_printf("check : %c",check[i]);
        }

        if(memcmp(check,test,NUM_OF_BYTE) == 0 ){
            xil_printf("Success!!");
            XUartPs_Send(&Uart_PS_1, hacked_string, 7);
                }
        else
        {
            printf("What?!");
        }

    }
    cleanup_platform();
    return 0;
}
