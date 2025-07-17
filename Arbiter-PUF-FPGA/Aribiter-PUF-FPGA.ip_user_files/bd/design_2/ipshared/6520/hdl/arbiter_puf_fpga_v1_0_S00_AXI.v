`timescale 1 ns / 1 ps

module arbiter_puf_fpga_v1_0_S00_AXI #
(
    parameter integer C_S_AXI_DATA_WIDTH = 32,
    parameter integer C_S_AXI_ADDR_WIDTH = 6
)
(
    input wire  S_AXI_ACLK,
    input wire  S_AXI_ARESETN,
    input wire [C_S_AXI_ADDR_WIDTH-1:0] S_AXI_AWADDR,
    input wire [2:0] S_AXI_AWPROT,
    input wire  S_AXI_AWVALID,
    output wire  S_AXI_AWREADY,
    input wire [C_S_AXI_DATA_WIDTH-1:0] S_AXI_WDATA,
    input wire [(C_S_AXI_DATA_WIDTH/8)-1:0] S_AXI_WSTRB,
    input wire  S_AXI_WVALID,
    output wire  S_AXI_WREADY,
    output wire [1:0] S_AXI_BRESP,
    output wire  S_AXI_BVALID,
    input wire  S_AXI_BREADY,
    input wire [C_S_AXI_ADDR_WIDTH-1:0] S_AXI_ARADDR,
    input wire [2:0] S_AXI_ARPROT,
    input wire  S_AXI_ARVALID,
    output wire  S_AXI_ARREADY,
    output wire [C_S_AXI_DATA_WIDTH-1:0] S_AXI_RDATA,
    output wire [1:0] S_AXI_RRESP,
    output wire  S_AXI_RVALID,
    input wire  S_AXI_RREADY
);

    // AXI4LITE signals
    reg [C_S_AXI_ADDR_WIDTH-1:0] axi_awaddr;
    reg axi_awready;
    reg axi_wready;
    reg [1:0] axi_bresp;
    reg axi_bvalid;
    reg [C_S_AXI_ADDR_WIDTH-1:0] axi_araddr;
    reg axi_arready;
    reg [C_S_AXI_DATA_WIDTH-1:0] axi_rdata;
    reg [1:0] axi_rresp;
    reg axi_rvalid;

    // User registers
    reg [C_S_AXI_DATA_WIDTH-1:0] slv_reg0;
    reg [C_S_AXI_DATA_WIDTH-1:0] slv_reg1;
    reg [C_S_AXI_DATA_WIDTH-1:0] slv_reg2;
    reg [C_S_AXI_DATA_WIDTH-1:0] slv_reg3;
    reg [C_S_AXI_DATA_WIDTH-1:0] slv_reg4;
    reg [C_S_AXI_DATA_WIDTH-1:0] slv_reg5;  // Read-only done flag
    reg [C_S_AXI_DATA_WIDTH-1:0] slv_reg6;
    reg [C_S_AXI_DATA_WIDTH-1:0] slv_reg7;
    reg [C_S_AXI_DATA_WIDTH-1:0] slv_reg8;
    reg [C_S_AXI_DATA_WIDTH-1:0] slv_reg9;
    reg [C_S_AXI_DATA_WIDTH-1:0] slv_reg10;
    reg [C_S_AXI_DATA_WIDTH-1:0] slv_reg11;
    reg [C_S_AXI_DATA_WIDTH-1:0] slv_reg12;
    reg [C_S_AXI_DATA_WIDTH-1:0] slv_reg13;
    reg [C_S_AXI_DATA_WIDTH-1:0] slv_reg14;
    reg [C_S_AXI_DATA_WIDTH-1:0] slv_reg15;

    wire slv_reg_rden;
    wire slv_reg_wren;
    reg [C_S_AXI_DATA_WIDTH-1:0] reg_data_out;
    integer byte_index;
    reg aw_en;

    // AXI write logic (removed slv_reg5 write)
    always @(posedge S_AXI_ACLK) begin
        if (slv_reg_wren) begin
            case (axi_awaddr[5:2])
                4'h0, 4'h1, 4'h2, 4'h3, 4'h4, 
                4'h6, 4'h7, 4'h8, 4'h9, 4'hA,
                4'hB, 4'hC, 4'hD, 4'hE, 4'hF: begin
                    for (byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1)
                        if (S_AXI_WSTRB[byte_index])
                            case (axi_awaddr[5:2])
                                4'h0: slv_reg0[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
                                4'h1: slv_reg1[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
                                // ... other registers ...
                                4'h5: ;  // Explicitly do nothing for slv_reg5 (read-only)
                                default: ; // Handle other cases
                            endcase
                end
            endcase
        end
    end

    // PUF Interface
    wire [63:0] challenge_input = {slv_reg1, slv_reg0};
    wire [63:0] puf_response;

    reg challenge_updated;
    always @(posedge S_AXI_ACLK) begin
        challenge_updated <= !S_AXI_ARESETN ? 0 : 
            (slv_reg_wren && (axi_awaddr[5:2] == 0 || axi_awaddr[5:2] == 1));
    end

    reg start_pulse;
    always @(posedge S_AXI_ACLK)
        start_pulse <= challenge_updated;

    arbiter_puf u_puf (
        .a(start_pulse),
        .b(1'b0),
        .c(challenge_input),
        .response(puf_response)
    );

    reg [1:0] response_delay;
    always @(posedge S_AXI_ACLK) begin
        response_delay <= !S_AXI_ARESETN ? 0 : {response_delay[0], challenge_updated};
    end

    // Single driver for slv_reg5
    always @(posedge S_AXI_ACLK) begin
        if (!S_AXI_ARESETN) begin
            slv_reg3 <= 0;
            slv_reg4 <= 0;
            slv_reg5 <= 0;
        end else if (response_delay[1]) begin
            slv_reg3 <= puf_response[31:0];
            slv_reg4 <= puf_response[63:32];
            slv_reg5 <= 32'h1;  // Set done flag
        end else if (challenge_updated) begin
            slv_reg5 <= 0;      // Clear done flag on new challenge
        end
    end

    // AXI read logic (slv_reg5 remains readable)
    always @(*) begin
        case (axi_araddr[5:2])
            4'h5: reg_data_out = slv_reg5;  // Read-only access
            // ... other read cases ...
        endcase
    end

    // ... (Rest of your AXI interface code remains unchanged) ...

endmodule