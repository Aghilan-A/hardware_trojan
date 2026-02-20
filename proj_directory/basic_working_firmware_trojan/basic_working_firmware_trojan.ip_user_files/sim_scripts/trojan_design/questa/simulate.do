onbreak {quit -f}
onerror {quit -f}

vsim -lib xil_defaultlib trojan_design_opt

do {wave.do}

view wave
view structure
view signals

do {trojan_design.udo}

run -all

quit -force
