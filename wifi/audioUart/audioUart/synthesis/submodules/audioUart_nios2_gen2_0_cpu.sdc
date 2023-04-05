# Legal Notice: (C)2023 Altera Corporation. All rights reserved.  Your
# use of Altera Corporation's design tools, logic functions and other
# software and tools, and its AMPP partner logic functions, and any
# output files any of the foregoing (including device programming or
# simulation files), and any associated documentation or information are
# expressly subject to the terms and conditions of the Altera Program
# License Subscription Agreement or other applicable license agreement,
# including, without limitation, that your use is for the sole purpose
# of programming logic devices manufactured by Altera and sold by Altera
# or its authorized distributors.  Please refer to the applicable
# agreement for further details.

#**************************************************************
# Timequest JTAG clock definition
#   Uncommenting the following lines will define the JTAG
#   clock in TimeQuest Timing Analyzer
#**************************************************************

#create_clock -period 10MHz {altera_reserved_tck}
#set_clock_groups -asynchronous -group {altera_reserved_tck}

#**************************************************************
# Set TCL Path Variables 
#**************************************************************

set 	audioUart_nios2_gen2_0_cpu 	audioUart_nios2_gen2_0_cpu:*
set 	audioUart_nios2_gen2_0_cpu_oci 	audioUart_nios2_gen2_0_cpu_nios2_oci:the_audioUart_nios2_gen2_0_cpu_nios2_oci
set 	audioUart_nios2_gen2_0_cpu_oci_break 	audioUart_nios2_gen2_0_cpu_nios2_oci_break:the_audioUart_nios2_gen2_0_cpu_nios2_oci_break
set 	audioUart_nios2_gen2_0_cpu_ocimem 	audioUart_nios2_gen2_0_cpu_nios2_ocimem:the_audioUart_nios2_gen2_0_cpu_nios2_ocimem
set 	audioUart_nios2_gen2_0_cpu_oci_debug 	audioUart_nios2_gen2_0_cpu_nios2_oci_debug:the_audioUart_nios2_gen2_0_cpu_nios2_oci_debug
set 	audioUart_nios2_gen2_0_cpu_wrapper 	audioUart_nios2_gen2_0_cpu_debug_slave_wrapper:the_audioUart_nios2_gen2_0_cpu_debug_slave_wrapper
set 	audioUart_nios2_gen2_0_cpu_jtag_tck 	audioUart_nios2_gen2_0_cpu_debug_slave_tck:the_audioUart_nios2_gen2_0_cpu_debug_slave_tck
set 	audioUart_nios2_gen2_0_cpu_jtag_sysclk 	audioUart_nios2_gen2_0_cpu_debug_slave_sysclk:the_audioUart_nios2_gen2_0_cpu_debug_slave_sysclk
set 	audioUart_nios2_gen2_0_cpu_oci_path 	 [format "%s|%s" $audioUart_nios2_gen2_0_cpu $audioUart_nios2_gen2_0_cpu_oci]
set 	audioUart_nios2_gen2_0_cpu_oci_break_path 	 [format "%s|%s" $audioUart_nios2_gen2_0_cpu_oci_path $audioUart_nios2_gen2_0_cpu_oci_break]
set 	audioUart_nios2_gen2_0_cpu_ocimem_path 	 [format "%s|%s" $audioUart_nios2_gen2_0_cpu_oci_path $audioUart_nios2_gen2_0_cpu_ocimem]
set 	audioUart_nios2_gen2_0_cpu_oci_debug_path 	 [format "%s|%s" $audioUart_nios2_gen2_0_cpu_oci_path $audioUart_nios2_gen2_0_cpu_oci_debug]
set 	audioUart_nios2_gen2_0_cpu_jtag_tck_path 	 [format "%s|%s|%s" $audioUart_nios2_gen2_0_cpu_oci_path $audioUart_nios2_gen2_0_cpu_wrapper $audioUart_nios2_gen2_0_cpu_jtag_tck]
set 	audioUart_nios2_gen2_0_cpu_jtag_sysclk_path 	 [format "%s|%s|%s" $audioUart_nios2_gen2_0_cpu_oci_path $audioUart_nios2_gen2_0_cpu_wrapper $audioUart_nios2_gen2_0_cpu_jtag_sysclk]
set 	audioUart_nios2_gen2_0_cpu_jtag_sr 	 [format "%s|*sr" $audioUart_nios2_gen2_0_cpu_jtag_tck_path]

#**************************************************************
# Set False Paths
#**************************************************************

set_false_path -from [get_keepers *$audioUart_nios2_gen2_0_cpu_oci_break_path|break_readreg*] -to [get_keepers *$audioUart_nios2_gen2_0_cpu_jtag_sr*]
set_false_path -from [get_keepers *$audioUart_nios2_gen2_0_cpu_oci_debug_path|*resetlatch]     -to [get_keepers *$audioUart_nios2_gen2_0_cpu_jtag_sr[33]]
set_false_path -from [get_keepers *$audioUart_nios2_gen2_0_cpu_oci_debug_path|monitor_ready]  -to [get_keepers *$audioUart_nios2_gen2_0_cpu_jtag_sr[0]]
set_false_path -from [get_keepers *$audioUart_nios2_gen2_0_cpu_oci_debug_path|monitor_error]  -to [get_keepers *$audioUart_nios2_gen2_0_cpu_jtag_sr[34]]
set_false_path -from [get_keepers *$audioUart_nios2_gen2_0_cpu_ocimem_path|*MonDReg*] -to [get_keepers *$audioUart_nios2_gen2_0_cpu_jtag_sr*]
set_false_path -from *$audioUart_nios2_gen2_0_cpu_jtag_sr*    -to *$audioUart_nios2_gen2_0_cpu_jtag_sysclk_path|*jdo*
set_false_path -from sld_hub:*|irf_reg* -to *$audioUart_nios2_gen2_0_cpu_jtag_sysclk_path|ir*
set_false_path -from sld_hub:*|sld_shadow_jsm:shadow_jsm|state[1] -to *$audioUart_nios2_gen2_0_cpu_oci_debug_path|monitor_go
