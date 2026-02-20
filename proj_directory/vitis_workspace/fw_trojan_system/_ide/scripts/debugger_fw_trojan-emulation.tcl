# Usage with Vitis IDE:
# In Vitis IDE create a Single Application Debug launch configuration,
# change the debug type to 'Attach to running target' and provide this 
# tcl script in 'Execute Script' option.
# Path of this script: D:\Aghilan\Amrita\Project_phase_2\proj_directory\vitis_workspace\fw_trojan_system\_ide\scripts\debugger_fw_trojan-emulation.tcl
# 
# 
# Usage with xsct:
# To debug using xsct, launch xsct and run below command
# source D:\Aghilan\Amrita\Project_phase_2\proj_directory\vitis_workspace\fw_trojan_system\_ide\scripts\debugger_fw_trojan-emulation.tcl
# 
connect -url tcp:localhost:4354
targets 3
dow D:/Aghilan/Amrita/Project_phase_2/proj_directory/vitis_workspace/fw_trojan/Debug/fw_trojan.elf
targets 3
con
