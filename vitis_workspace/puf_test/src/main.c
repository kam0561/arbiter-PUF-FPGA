#include <stdio.h>
#include "xparameters.h"
#include "xil_io.h"
#include "sleep.h"  // For usleep()

#define PUF_BASE_ADDR XPAR_ARBITER_PUF_FPGA_0_S00_AXI_BASEADDR

int main() {
    u32 challenge_low = 0xDEADBEEF;
    u32 challenge_high = 0xCAFEBABE;

    // Write challenge
    Xil_Out32(PUF_BASE_ADDR + 0x00, challenge_low);  // slv_reg0
    Xil_Out32(PUF_BASE_ADDR + 0x04, challenge_high); // slv_reg1

    // Wait for PUF response (with timeout)
    u32 timeout = 1000000;
    while (!(Xil_In32(PUF_BASE_ADDR + 0x14) & 0x1) && timeout--) {
        usleep(1);  // Optional delay to reduce CPU load
    }

    if (timeout == 0) {
        printf("Error: PUF did not respond!\n");
        return -1;
    }

    // Read response
    u32 resp_lo = Xil_In32(PUF_BASE_ADDR + 0x0C);  // slv_reg3
    u32 resp_hi = Xil_In32(PUF_BASE_ADDR + 0x10);  // slv_reg4

    printf("PUF Response: %08X%08X\n", resp_hi, resp_lo);
    return 0;
}
