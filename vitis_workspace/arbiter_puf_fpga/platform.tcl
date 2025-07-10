# 
# Usage: To re-create this platform project launch xsct with below options.
# xsct C:\AB\xilinxvivado\projects\arbiter-PUF-FPGA\vitis_workspace\arbiter_puf_fpga\platform.tcl
# 
# OR launch xsct and run below command.
# source C:\AB\xilinxvivado\projects\arbiter-PUF-FPGA\vitis_workspace\arbiter_puf_fpga\platform.tcl
# 
# To create the platform in a different location, modify the -out option of "platform create" command.
# -out option specifies the output directory of the platform project.

platform create -name {arbiter_puf_fpga}\
-hw {C:\AB\xilinxvivado\projects\arbiter-PUF-FPGA\Arbiter-PUF-FPGA\design_2_wrapper.xsa}\
-proc {ps7_cortexa9_0} -os {standalone} -fsbl-target {psu_cortexa53_0} -out {C:/AB/xilinxvivado/projects/arbiter-PUF-FPGA/vitis_workspace}

platform write
platform generate -domains 
platform active {arbiter_puf_fpga}
