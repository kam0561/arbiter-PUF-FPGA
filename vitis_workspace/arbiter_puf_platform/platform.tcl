# 
# Usage: To re-create this platform project launch xsct with below options.
# xsct C:\AB\xilinxvivado\projects\arbiter-PUF-FPGA\vitis_workspace\arbiter_puf_platform\platform.tcl
# 
# OR launch xsct and run below command.
# source C:\AB\xilinxvivado\projects\arbiter-PUF-FPGA\vitis_workspace\arbiter_puf_platform\platform.tcl
# 
# To create the platform in a different location, modify the -out option of "platform create" command.
# -out option specifies the output directory of the platform project.

platform create -name {arbiter_puf_platform}\
-hw {C:\AB\xilinxvivado\projects\arbiter-PUF-FPGA\design_2_wrapper.xsa}\
-proc {ps7_cortexa9_0} -os {standalone} -fsbl-target {psu_cortexa53_0} -out {C:/AB/xilinxvivado/projects/arbiter-PUF-FPGA/vitis_workspace}

platform write
platform generate -domains 
platform active {arbiter_puf_platform}
domain active {zynq_fsbl}
bsp reload
bsp removelib -name xilffs
bsp removelib -name xilrsa
bsp write
bsp reload
catch {bsp regenerate}
bsp setlib -name xilffs -ver 4.4
bsp write
bsp reload
catch {bsp regenerate}
platform clean
bsp reload
platform clean
platform clean
platform clean
platform generate
platform active {arbiter_puf_platform}
platform config -updatehw {C:/AB/xilinxvivado/projects/arbiter-PUF-FPGA/Arbiter-PUF-FPGA/design_2_wrapper_new.xsa}
platform generate -domains 
platform active {arbiter_puf_platform}
platform active {arbiter_puf_platform}
platform generate
platform generate
platform active {arbiter_puf_platform}
platform config -updatehw {C:/AB/xilinxvivado/projects/arbiter-PUF-FPGA/Arbiter-PUF-FPGA/design_2_wrapper_final_0.xsa}
platform generate -domains 
domain active {standalone_domain}
bsp reload
bsp config stdin "ps7_coresight_comp_0"
bsp config stdout "ps7_coresight_comp_0"
bsp config stdin "ps7_coresight_comp_0"
bsp config stdout "ps7_coresight_comp_0"
bsp reload
platform active {arbiter_puf_platform}
platform config -updatehw {C:/AB/xilinxvivado/projects/arbiter-PUF-FPGA/Arbiter-PUF-FPGA/design_2_wrapper_final_2.xsa}
platform config -updatehw {C:/AB/xilinxvivado/projects/arbiter-PUF-FPGA/Arbiter-PUF-FPGA/design_2_wrapper_final_0.xsa}
