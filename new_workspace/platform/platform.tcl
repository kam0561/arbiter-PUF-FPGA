# 
# Usage: To re-create this platform project launch xsct with below options.
# xsct C:\AB\xilinxvivado\projects\arbiter-PUF-FPGA\new_workspace\platform\platform.tcl
# 
# OR launch xsct and run below command.
# source C:\AB\xilinxvivado\projects\arbiter-PUF-FPGA\new_workspace\platform\platform.tcl
# 
# To create the platform in a different location, modify the -out option of "platform create" command.
# -out option specifies the output directory of the platform project.

platform create -name {platform}\
-hw {C:\AB\xilinxvivado\projects\arbiter-PUF-FPGA\Arbiter-PUF-FPGA\design_2_wrapper_final_2.xsa}\
-proc {ps7_cortexa9_0} -os {standalone} -fsbl-target {psu_cortexa53_0} -out {C:/AB/xilinxvivado/projects/arbiter-PUF-FPGA/new_workspace}

platform write
platform generate -domains 
platform active {platform}
platform clean
platform clean
platform generate
platform clean
platform generate
