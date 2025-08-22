set_property CFGBVS VCCO [current_design]
set_property CONFIG_VOLTAGE 3.3 [current_design]

set_property BITSTREAM.CONFIG.SPI_BUSWIDTH 4 [current_design] 
set_property CONFIG_MODE SPIx4 [current_design] 
set_property BITSTREAM.CONFIG.CONFIGRATE 50 [current_design] 

create_clock -period 20 [get_ports SYS_CLK]
set_property IOSTANDARD LVCMOS33 [get_ports {SYS_CLK}]
set_property PACKAGE_PIN Y18 [get_ports {SYS_CLK}]

set_property IOSTANDARD LVCMOS33 [get_ports {KEY*}]
set_property PACKAGE_PIN M13 [get_ports {KEY1}]
set_property PACKAGE_PIN K14 [get_ports {KEY2}]
set_property PACKAGE_PIN K13 [get_ports {KEY3}]
set_property PACKAGE_PIN L13 [get_ports {KEY4}]

set_property PACKAGE_PIN F20 [get_ports {RESET}]
set_property IOSTANDARD LVCMOS33 [get_ports {RESET}]

set_property IOSTANDARD LVCMOS33 [get_ports {LED*}]
set_property PACKAGE_PIN F19 [get_ports {LED1}]
set_property PACKAGE_PIN E21 [get_ports {LED2}]
set_property PACKAGE_PIN D20 [get_ports {LED3}]
set_property PACKAGE_PIN C20 [get_ports {LED4}]

set_property PACKAGE_PIN J5 [get_ports {SMG_DATA[0]}]
set_property PACKAGE_PIN M3 [get_ports {SMG_DATA[1]}]
set_property PACKAGE_PIN J6 [get_ports {SMG_DATA[2]}]
set_property PACKAGE_PIN H5 [get_ports {SMG_DATA[3]}]
set_property PACKAGE_PIN G4 [get_ports {SMG_DATA[4]}]
set_property PACKAGE_PIN K6  [get_ports {SMG_DATA[5]}]
set_property PACKAGE_PIN K3 [get_ports {SMG_DATA[6]}]
set_property PACKAGE_PIN H4 [get_ports {SMG_DATA[7]}]

set_property PACKAGE_PIN M2 [get_ports {SCAN_SIG[0]}]
set_property PACKAGE_PIN N4 [get_ports {SCAN_SIG[1]}]
set_property PACKAGE_PIN L5 [get_ports {SCAN_SIG[2]}]
set_property PACKAGE_PIN L4 [get_ports {SCAN_SIG[3]}]
set_property PACKAGE_PIN M16 [get_ports {SCAN_SIG[4]}]
set_property PACKAGE_PIN M17 [get_ports {SCAN_SIG[5]}]

set_property IOSTANDARD LVCMOS33 [get_ports {SMG_DATA[*]}]
set_property IOSTANDARD LVCMOS33 [get_ports {SCAN_SIG[*]}]