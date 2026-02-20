# 
# Usage: To re-create this platform project launch xsct with below options.
# xsct D:\Aghilan\Amrita\Project_phase_2\proj_directory\vitis_workspace\trojan_demo\platform.tcl
# 
# OR launch xsct and run below command.
# source D:\Aghilan\Amrita\Project_phase_2\proj_directory\vitis_workspace\trojan_demo\platform.tcl
# 
# To create the platform in a different location, modify the -out option of "platform create" command.
# -out option specifies the output directory of the platform project.

platform create -name {trojan_demo}\
-hw {D:\Aghilan\Amrita\Project_phase_2\proj_directory\basic_working_firmware_trojan\trojan_design_wrapper.xsa}\
-proc {ps7_cortexa9_0} -os {standalone} -fsbl-target {psu_cortexa53_0} -out {D:/Aghilan/Amrita/Project_phase_2/proj_directory/vitis_workspace}

platform write
platform generate -domains 
platform active {trojan_demo}
bsp reload
platform generate
platform generate
platform active {trojan_demo}
platform generate
