#include <stdio.h>
#include "platform.h"
#include "xil_printf.h"
#include "xparameters.h"
#include "xil_io.h"
#include "xil_types.h" // Use the recommended xil_types.h instead of the deprecated xbasic_types.h

int main() {
    u32 data_out;
    u32 A_data_out;
    u32 B_data_out;
    u32 chal3, chal2, chal1, chal0;

    // NOTE: For this to work, you must place input.txt and allow writing of output.txt
    // on the SD card or filesystem the Zynq board will be using.
    FILE *inputFile = fopen("input.txt", "r");
    FILE *outputFile = fopen("output.txt", "w");

    if (inputFile == NULL) {
        xil_printf("Error: Could not open input file.\n");
        return 1;
    }

    if (outputFile == NULL) {
        xil_printf("Error: Could not open output file.\n");
        fclose(inputFile);
        return 1;
    }

    xil_printf("Start of IP PUF 64 bit test\n\n\r");

    // Read challenges from the input file.
    // Use %lx for u32 (long unsigned int) to fix compiler warnings.
    while (fscanf(inputFile, "%lx %lx %lx %lx", &chal3, &chal2, &chal1, &chal0) == 4) {

        // --- FIX 1: Replaced old, undeclared IP names with the correct one from xparameters.h ---
        // It's assumed that the single 'arbiter_puf_fpga' IP now handles all registers.
        // The offsets for challenge registers might need to be verified in your IP's documentation.
        Xil_Out32(XPAR_ARBITER_PUF_FPGA_0_S00_AXI_BASEADDR + 0x10, chal3);
        Xil_Out32(XPAR_ARBITER_PUF_FPGA_0_S00_AXI_BASEADDR + 0xc, chal2);
        Xil_Out32(XPAR_ARBITER_PUF_FPGA_0_S00_AXI_BASEADDR + 0x8, chal1);
        Xil_Out32(XPAR_ARBITER_PUF_FPGA_0_S00_AXI_BASEADDR + 0x4, chal0);

        // --- FIX 2: Replaced old arbiter IP name with the one suggested by the compiler. ---
        // Reset and activate the PUF system
        Xil_Out32(XPAR_ARBITER_PUF_FPGA_0_S00_AXI_BASEADDR, 0x0);

        // Simple delay loop
        for (int i = 0; i < 1000; i++);

        Xil_Out32(XPAR_ARBITER_PUF_FPGA_0_S00_AXI_BASEADDR, 0x1);

        // Read outputs from the AXI registers
        A_data_out = Xil_In32(XPAR_ARBITER_PUF_FPGA_0_S00_AXI_BASEADDR + 0x14);
        B_data_out = Xil_In32(XPAR_ARBITER_PUF_FPGA_0_S00_AXI_BASEADDR + 0x18);
        data_out = Xil_In32(XPAR_ARBITER_PUF_FPGA_0_S00_AXI_BASEADDR + 0x1c);

        // Print the results to the serial console
        // Use %lx for u32 to fix compiler warnings.
        xil_printf("Input Challenge Data = %0lx %0lx %0lx %0lx; response_data_out= %0lx \n\r", chal3, chal2, chal1, chal0, data_out);
        xil_printf("A_data_out= %0lx \n\r", A_data_out);
        xil_printf("B_data_out= %0lx \n\r", B_data_out);

        // Write results to the output file
        // Use %lx for u32 to fix compiler warnings.
        fprintf(outputFile, "Input: %0lx %0lx %0lx %0lx, Output: %0lx, A_data_out: %0lx, B_data_out: %0lx\n",
                chal3, chal2, chal1, chal0, data_out, A_data_out, B_data_out);
    }

    fclose(inputFile);
    fclose(outputFile);

    xil_printf("Processing completed. Results saved to output.txt\n");

    return 0;
}
