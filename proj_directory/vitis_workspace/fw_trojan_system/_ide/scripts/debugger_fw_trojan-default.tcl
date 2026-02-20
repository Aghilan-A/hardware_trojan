# Usage with Vitis IDE:
# In Vitis IDE create a Single Application Debug launch configuration,
# change the debug type to 'Attach to running target' and provide this 
# tcl script in 'Execute Script' option.
# Path of this script: D:\Aghilan\Amrita\Project_phase_2\proj_directory\vitis_workspace\fw_trojan_system\_ide\scripts\debugger_fw_trojan-default.tcl
# 
# 
# Usage with xsct:
# To debug using xsct, launch xsct and run below command
# source D:\Aghilan\Amrita\Project_phase_2\proj_directory\vitis_workspace\fw_trojan_system\_ide\scripts\debugger_fw_trojan-default.tcl
# 
connect -url tcp:127.0.0.1:3121
targets -set -nocase -filter {name =~"APU*"}
rst -system
after 3000
targets -set -filter {jtag_cable_name =~ "Digilent Zed 210248B77C97" && level==0 && jtag_device_ctx=="jsn-Zed-210248B77C97-23727093-0"}
fpga -file D:/Aghilan/Amrita/Project_phase_2/proj_directory/vitis_workspace/fw_trojan/_ide/bitstream/trojan_design_wrapper.bit
targets -set -nocase -filter {name =~"APU*"}
loadhw -hw D:/Aghilan/Amrita/Project_phase_2/proj_directory/vitis_workspace/trojan_demo/export/trojan_demo/hw/trojan_design_wrapper.xsa -mem-ranges [list {0x40000000 0xbfffffff}] -regs
configparams force-mem-access 1
targets -set -nocase -filter {name =~"APU*"}
source D:/Aghilan/Amrita/Project_phase_2/proj_directory/vitis_workspace/fw_trojan/_ide/psinit/ps7_init.tcl
ps7_init
ps7_post_config
targets -set -nocase -filter {name =~ "*A9*#0"}
dow D:/Aghilan/Amrita/Project_phase_2/proj_directory/vitis_workspace/fw_trojan/Debug/fw_trojan.elf
configparams force-mem-access 0
targets -set -nocase -filter {name =~ "*A9*#0"}
con
