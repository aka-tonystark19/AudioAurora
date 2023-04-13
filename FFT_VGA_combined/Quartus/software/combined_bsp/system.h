/*
 * system.h - SOPC Builder system and BSP software package information
 *
 * Machine generated for CPU 'nios2_gen2_0' in SOPC Builder design 'vga_system'
 * SOPC Builder design path: ../../vga_system.sopcinfo
 *
 * Generated: Wed Apr 12 17:06:17 PDT 2023
 */

/*
 * DO NOT MODIFY THIS FILE
 *
 * Changing this file will have subtle consequences
 * which will almost certainly lead to a nonfunctioning
 * system. If you do modify this file, be aware that your
 * changes will be overwritten and lost when this file
 * is generated again.
 *
 * DO NOT MODIFY THIS FILE
 */

/*
 * License Agreement
 *
 * Copyright (c) 2008
 * Altera Corporation, San Jose, California, USA.
 * All rights reserved.
 *
 * Permission is hereby granted, free of charge, to any person obtaining a
 * copy of this software and associated documentation files (the "Software"),
 * to deal in the Software without restriction, including without limitation
 * the rights to use, copy, modify, merge, publish, distribute, sublicense,
 * and/or sell copies of the Software, and to permit persons to whom the
 * Software is furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
 * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
 * DEALINGS IN THE SOFTWARE.
 *
 * This agreement shall be governed in all respects by the laws of the State
 * of California and by the laws of the United States of America.
 */

#ifndef __SYSTEM_H_
#define __SYSTEM_H_

/* Include definitions from linker script generator */
#include "linker.h"


/*
 * CPU configuration
 *
 */

#define ALT_CPU_ARCHITECTURE "altera_nios2_gen2"
#define ALT_CPU_BIG_ENDIAN 0
#define ALT_CPU_BREAK_ADDR 0x00000820
#define ALT_CPU_CPU_ARCH_NIOS2_R1
#define ALT_CPU_CPU_FREQ 50000000u
#define ALT_CPU_CPU_ID_SIZE 1
#define ALT_CPU_CPU_ID_VALUE 0x00000000
#define ALT_CPU_CPU_IMPLEMENTATION "tiny"
#define ALT_CPU_DATA_ADDR_WIDTH 0x1c
#define ALT_CPU_DCACHE_LINE_SIZE 0
#define ALT_CPU_DCACHE_LINE_SIZE_LOG2 0
#define ALT_CPU_DCACHE_SIZE 0
#define ALT_CPU_EXCEPTION_ADDR 0x00040020
#define ALT_CPU_FLASH_ACCELERATOR_LINES 0
#define ALT_CPU_FLASH_ACCELERATOR_LINE_SIZE 0
#define ALT_CPU_FLUSHDA_SUPPORTED
#define ALT_CPU_FREQ 50000000
#define ALT_CPU_HARDWARE_DIVIDE_PRESENT 0
#define ALT_CPU_HARDWARE_MULTIPLY_PRESENT 0
#define ALT_CPU_HARDWARE_MULX_PRESENT 0
#define ALT_CPU_HAS_DEBUG_CORE 1
#define ALT_CPU_HAS_DEBUG_STUB
#define ALT_CPU_HAS_ILLEGAL_INSTRUCTION_EXCEPTION
#define ALT_CPU_HAS_JMPI_INSTRUCTION
#define ALT_CPU_ICACHE_LINE_SIZE 0
#define ALT_CPU_ICACHE_LINE_SIZE_LOG2 0
#define ALT_CPU_ICACHE_SIZE 0
#define ALT_CPU_INST_ADDR_WIDTH 0x13
#define ALT_CPU_NAME "nios2_gen2_0"
#define ALT_CPU_OCI_VERSION 1
#define ALT_CPU_RESET_ADDR 0x00040000


/*
 * CPU configuration (with legacy prefix - don't use these anymore)
 *
 */

#define NIOS2_BIG_ENDIAN 0
#define NIOS2_BREAK_ADDR 0x00000820
#define NIOS2_CPU_ARCH_NIOS2_R1
#define NIOS2_CPU_FREQ 50000000u
#define NIOS2_CPU_ID_SIZE 1
#define NIOS2_CPU_ID_VALUE 0x00000000
#define NIOS2_CPU_IMPLEMENTATION "tiny"
#define NIOS2_DATA_ADDR_WIDTH 0x1c
#define NIOS2_DCACHE_LINE_SIZE 0
#define NIOS2_DCACHE_LINE_SIZE_LOG2 0
#define NIOS2_DCACHE_SIZE 0
#define NIOS2_EXCEPTION_ADDR 0x00040020
#define NIOS2_FLASH_ACCELERATOR_LINES 0
#define NIOS2_FLASH_ACCELERATOR_LINE_SIZE 0
#define NIOS2_FLUSHDA_SUPPORTED
#define NIOS2_HARDWARE_DIVIDE_PRESENT 0
#define NIOS2_HARDWARE_MULTIPLY_PRESENT 0
#define NIOS2_HARDWARE_MULX_PRESENT 0
#define NIOS2_HAS_DEBUG_CORE 1
#define NIOS2_HAS_DEBUG_STUB
#define NIOS2_HAS_ILLEGAL_INSTRUCTION_EXCEPTION
#define NIOS2_HAS_JMPI_INSTRUCTION
#define NIOS2_ICACHE_LINE_SIZE 0
#define NIOS2_ICACHE_LINE_SIZE_LOG2 0
#define NIOS2_ICACHE_SIZE 0
#define NIOS2_INST_ADDR_WIDTH 0x13
#define NIOS2_OCI_VERSION 1
#define NIOS2_RESET_ADDR 0x00040000


/*
 * Define for each module class mastered by the CPU
 *
 */

#define __ALTERA_AVALON_JTAG_UART
#define __ALTERA_AVALON_NEW_SDRAM_CONTROLLER
#define __ALTERA_AVALON_ONCHIP_MEMORY2
#define __ALTERA_AVALON_TIMER
#define __ALTERA_NIOS2_GEN2
#define __ALTERA_UP_AVALON_RS232
#define __FFT_ACCEL
#define __VGA_INTEGRATE


/*
 * System configuration
 *
 */

#define ALT_DEVICE_FAMILY "Cyclone V"
#define ALT_IRQ_BASE NULL
#define ALT_LEGACY_INTERRUPT_API_PRESENT
#define ALT_LOG_PORT "/dev/null"
#define ALT_LOG_PORT_BASE 0x0
#define ALT_LOG_PORT_DEV null
#define ALT_LOG_PORT_TYPE ""
#define ALT_NUM_EXTERNAL_INTERRUPT_CONTROLLERS 0
#define ALT_NUM_INTERNAL_INTERRUPT_CONTROLLERS 1
#define ALT_NUM_INTERRUPT_CONTROLLERS 1
#define ALT_STDERR "/dev/jtag_uart_0"
#define ALT_STDERR_BASE 0x1020
#define ALT_STDERR_DEV jtag_uart_0
#define ALT_STDERR_IS_JTAG_UART
#define ALT_STDERR_PRESENT
#define ALT_STDERR_TYPE "altera_avalon_jtag_uart"
#define ALT_STDIN "/dev/jtag_uart_0"
#define ALT_STDIN_BASE 0x1020
#define ALT_STDIN_DEV jtag_uart_0
#define ALT_STDIN_IS_JTAG_UART
#define ALT_STDIN_PRESENT
#define ALT_STDIN_TYPE "altera_avalon_jtag_uart"
#define ALT_STDOUT "/dev/jtag_uart_0"
#define ALT_STDOUT_BASE 0x1020
#define ALT_STDOUT_DEV jtag_uart_0
#define ALT_STDOUT_IS_JTAG_UART
#define ALT_STDOUT_PRESENT
#define ALT_STDOUT_TYPE "altera_avalon_jtag_uart"
#define ALT_SYSTEM_NAME "vga_system"


/*
 * fft_accel_0 configuration
 *
 */

#define ALT_MODULE_CLASS_fft_accel_0 fft_accel
#define FFT_ACCEL_0_BASE 0x0
#define FFT_ACCEL_0_IRQ -1
#define FFT_ACCEL_0_IRQ_INTERRUPT_CONTROLLER_ID -1
#define FFT_ACCEL_0_NAME "/dev/fft_accel_0"
#define FFT_ACCEL_0_SPAN 64
#define FFT_ACCEL_0_TYPE "fft_accel"


/*
 * hal configuration
 *
 */

#define ALT_INCLUDE_INSTRUCTION_RELATED_EXCEPTION_API
#define ALT_MAX_FD 4
#define ALT_SYS_CLK none
#define ALT_TIMESTAMP_CLK none


/*
 * jtag_uart_0 configuration
 *
 */

#define ALT_MODULE_CLASS_jtag_uart_0 altera_avalon_jtag_uart
#define JTAG_UART_0_BASE 0x1020
#define JTAG_UART_0_IRQ 2
#define JTAG_UART_0_IRQ_INTERRUPT_CONTROLLER_ID 0
#define JTAG_UART_0_NAME "/dev/jtag_uart_0"
#define JTAG_UART_0_READ_DEPTH 64
#define JTAG_UART_0_READ_THRESHOLD 8
#define JTAG_UART_0_SPAN 8
#define JTAG_UART_0_TYPE "altera_avalon_jtag_uart"
#define JTAG_UART_0_WRITE_DEPTH 64
#define JTAG_UART_0_WRITE_THRESHOLD 8


/*
 * new_sdram_controller_0 configuration
 *
 */

#define ALT_MODULE_CLASS_new_sdram_controller_0 altera_avalon_new_sdram_controller
#define NEW_SDRAM_CONTROLLER_0_BASE 0x8000000
#define NEW_SDRAM_CONTROLLER_0_CAS_LATENCY 3
#define NEW_SDRAM_CONTROLLER_0_CONTENTS_INFO
#define NEW_SDRAM_CONTROLLER_0_INIT_NOP_DELAY 0.0
#define NEW_SDRAM_CONTROLLER_0_INIT_REFRESH_COMMANDS 2
#define NEW_SDRAM_CONTROLLER_0_IRQ -1
#define NEW_SDRAM_CONTROLLER_0_IRQ_INTERRUPT_CONTROLLER_ID -1
#define NEW_SDRAM_CONTROLLER_0_IS_INITIALIZED 1
#define NEW_SDRAM_CONTROLLER_0_NAME "/dev/new_sdram_controller_0"
#define NEW_SDRAM_CONTROLLER_0_POWERUP_DELAY 100.0
#define NEW_SDRAM_CONTROLLER_0_REFRESH_PERIOD 7.1825
#define NEW_SDRAM_CONTROLLER_0_REGISTER_DATA_IN 1
#define NEW_SDRAM_CONTROLLER_0_SDRAM_ADDR_WIDTH 0x19
#define NEW_SDRAM_CONTROLLER_0_SDRAM_BANK_WIDTH 2
#define NEW_SDRAM_CONTROLLER_0_SDRAM_COL_WIDTH 10
#define NEW_SDRAM_CONTROLLER_0_SDRAM_DATA_WIDTH 16
#define NEW_SDRAM_CONTROLLER_0_SDRAM_NUM_BANKS 4
#define NEW_SDRAM_CONTROLLER_0_SDRAM_NUM_CHIPSELECTS 1
#define NEW_SDRAM_CONTROLLER_0_SDRAM_ROW_WIDTH 13
#define NEW_SDRAM_CONTROLLER_0_SHARED_DATA 0
#define NEW_SDRAM_CONTROLLER_0_SIM_MODEL_BASE 1
#define NEW_SDRAM_CONTROLLER_0_SPAN 67108864
#define NEW_SDRAM_CONTROLLER_0_STARVATION_INDICATOR 0
#define NEW_SDRAM_CONTROLLER_0_TRISTATE_BRIDGE_SLAVE ""
#define NEW_SDRAM_CONTROLLER_0_TYPE "altera_avalon_new_sdram_controller"
#define NEW_SDRAM_CONTROLLER_0_T_AC 5.4
#define NEW_SDRAM_CONTROLLER_0_T_MRD 3
#define NEW_SDRAM_CONTROLLER_0_T_RCD 15.0
#define NEW_SDRAM_CONTROLLER_0_T_RFC 70.0
#define NEW_SDRAM_CONTROLLER_0_T_RP 15.0
#define NEW_SDRAM_CONTROLLER_0_T_WR 14.0


/*
 * ram_1 configuration
 *
 */

#define ALT_MODULE_CLASS_ram_1 altera_avalon_onchip_memory2
#define RAM_1_ALLOW_IN_SYSTEM_MEMORY_CONTENT_EDITOR 0
#define RAM_1_ALLOW_MRAM_SIM_CONTENTS_ONLY_FILE 0
#define RAM_1_BASE 0x7000
#define RAM_1_CONTENTS_INFO ""
#define RAM_1_DUAL_PORT 0
#define RAM_1_GUI_RAM_BLOCK_TYPE "AUTO"
#define RAM_1_INIT_CONTENTS_FILE "vga_system_ram_1"
#define RAM_1_INIT_MEM_CONTENT 1
#define RAM_1_INSTANCE_ID "NONE"
#define RAM_1_IRQ -1
#define RAM_1_IRQ_INTERRUPT_CONTROLLER_ID -1
#define RAM_1_NAME "/dev/ram_1"
#define RAM_1_NON_DEFAULT_INIT_FILE_ENABLED 0
#define RAM_1_RAM_BLOCK_TYPE "AUTO"
#define RAM_1_READ_DURING_WRITE_MODE "DONT_CARE"
#define RAM_1_SINGLE_CLOCK_OP 0
#define RAM_1_SIZE_MULTIPLE 1
#define RAM_1_SIZE_VALUE 4096
#define RAM_1_SPAN 4096
#define RAM_1_TYPE "altera_avalon_onchip_memory2"
#define RAM_1_WRITABLE 1


/*
 * ram_2 configuration
 *
 */

#define ALT_MODULE_CLASS_ram_2 altera_avalon_onchip_memory2
#define RAM_2_ALLOW_IN_SYSTEM_MEMORY_CONTENT_EDITOR 0
#define RAM_2_ALLOW_MRAM_SIM_CONTENTS_ONLY_FILE 0
#define RAM_2_BASE 0x6000
#define RAM_2_CONTENTS_INFO ""
#define RAM_2_DUAL_PORT 0
#define RAM_2_GUI_RAM_BLOCK_TYPE "AUTO"
#define RAM_2_INIT_CONTENTS_FILE "vga_system_ram_2"
#define RAM_2_INIT_MEM_CONTENT 1
#define RAM_2_INSTANCE_ID "NONE"
#define RAM_2_IRQ -1
#define RAM_2_IRQ_INTERRUPT_CONTROLLER_ID -1
#define RAM_2_NAME "/dev/ram_2"
#define RAM_2_NON_DEFAULT_INIT_FILE_ENABLED 0
#define RAM_2_RAM_BLOCK_TYPE "AUTO"
#define RAM_2_READ_DURING_WRITE_MODE "DONT_CARE"
#define RAM_2_SINGLE_CLOCK_OP 0
#define RAM_2_SIZE_MULTIPLE 1
#define RAM_2_SIZE_VALUE 4096
#define RAM_2_SPAN 4096
#define RAM_2_TYPE "altera_avalon_onchip_memory2"
#define RAM_2_WRITABLE 1


/*
 * ram_3 configuration
 *
 */

#define ALT_MODULE_CLASS_ram_3 altera_avalon_onchip_memory2
#define RAM_3_ALLOW_IN_SYSTEM_MEMORY_CONTENT_EDITOR 0
#define RAM_3_ALLOW_MRAM_SIM_CONTENTS_ONLY_FILE 0
#define RAM_3_BASE 0x4000
#define RAM_3_CONTENTS_INFO ""
#define RAM_3_DUAL_PORT 0
#define RAM_3_GUI_RAM_BLOCK_TYPE "AUTO"
#define RAM_3_INIT_CONTENTS_FILE "vga_system_ram_3"
#define RAM_3_INIT_MEM_CONTENT 1
#define RAM_3_INSTANCE_ID "NONE"
#define RAM_3_IRQ -1
#define RAM_3_IRQ_INTERRUPT_CONTROLLER_ID -1
#define RAM_3_NAME "/dev/ram_3"
#define RAM_3_NON_DEFAULT_INIT_FILE_ENABLED 0
#define RAM_3_RAM_BLOCK_TYPE "AUTO"
#define RAM_3_READ_DURING_WRITE_MODE "DONT_CARE"
#define RAM_3_SINGLE_CLOCK_OP 0
#define RAM_3_SIZE_MULTIPLE 1
#define RAM_3_SIZE_VALUE 4096
#define RAM_3_SPAN 4096
#define RAM_3_TYPE "altera_avalon_onchip_memory2"
#define RAM_3_WRITABLE 1


/*
 * ram_4 configuration
 *
 */

#define ALT_MODULE_CLASS_ram_4 altera_avalon_onchip_memory2
#define RAM_4_ALLOW_IN_SYSTEM_MEMORY_CONTENT_EDITOR 0
#define RAM_4_ALLOW_MRAM_SIM_CONTENTS_ONLY_FILE 0
#define RAM_4_BASE 0x5000
#define RAM_4_CONTENTS_INFO ""
#define RAM_4_DUAL_PORT 0
#define RAM_4_GUI_RAM_BLOCK_TYPE "AUTO"
#define RAM_4_INIT_CONTENTS_FILE "vga_system_ram_4"
#define RAM_4_INIT_MEM_CONTENT 1
#define RAM_4_INSTANCE_ID "NONE"
#define RAM_4_IRQ -1
#define RAM_4_IRQ_INTERRUPT_CONTROLLER_ID -1
#define RAM_4_NAME "/dev/ram_4"
#define RAM_4_NON_DEFAULT_INIT_FILE_ENABLED 0
#define RAM_4_RAM_BLOCK_TYPE "AUTO"
#define RAM_4_READ_DURING_WRITE_MODE "DONT_CARE"
#define RAM_4_SINGLE_CLOCK_OP 0
#define RAM_4_SIZE_MULTIPLE 1
#define RAM_4_SIZE_VALUE 4096
#define RAM_4_SPAN 4096
#define RAM_4_TYPE "altera_avalon_onchip_memory2"
#define RAM_4_WRITABLE 1


/*
 * ram_instr configuration
 *
 */

#define ALT_MODULE_CLASS_ram_instr altera_avalon_onchip_memory2
#define RAM_INSTR_ALLOW_IN_SYSTEM_MEMORY_CONTENT_EDITOR 0
#define RAM_INSTR_ALLOW_MRAM_SIM_CONTENTS_ONLY_FILE 0
#define RAM_INSTR_BASE 0x40000
#define RAM_INSTR_CONTENTS_INFO ""
#define RAM_INSTR_DUAL_PORT 0
#define RAM_INSTR_GUI_RAM_BLOCK_TYPE "AUTO"
#define RAM_INSTR_INIT_CONTENTS_FILE "vga_system_ram_instr"
#define RAM_INSTR_INIT_MEM_CONTENT 1
#define RAM_INSTR_INSTANCE_ID "NONE"
#define RAM_INSTR_IRQ -1
#define RAM_INSTR_IRQ_INTERRUPT_CONTROLLER_ID -1
#define RAM_INSTR_NAME "/dev/ram_instr"
#define RAM_INSTR_NON_DEFAULT_INIT_FILE_ENABLED 0
#define RAM_INSTR_RAM_BLOCK_TYPE "AUTO"
#define RAM_INSTR_READ_DURING_WRITE_MODE "DONT_CARE"
#define RAM_INSTR_SINGLE_CLOCK_OP 0
#define RAM_INSTR_SIZE_MULTIPLE 1
#define RAM_INSTR_SIZE_VALUE 32768
#define RAM_INSTR_SPAN 32768
#define RAM_INSTR_TYPE "altera_avalon_onchip_memory2"
#define RAM_INSTR_WRITABLE 1


/*
 * rs232_0 configuration
 *
 */

#define ALT_MODULE_CLASS_rs232_0 altera_up_avalon_rs232
#define RS232_0_BASE 0x1028
#define RS232_0_IRQ 0
#define RS232_0_IRQ_INTERRUPT_CONTROLLER_ID 0
#define RS232_0_NAME "/dev/rs232_0"
#define RS232_0_SPAN 8
#define RS232_0_TYPE "altera_up_avalon_rs232"


/*
 * timer_0 configuration
 *
 */

#define ALT_MODULE_CLASS_timer_0 altera_avalon_timer
#define TIMER_0_ALWAYS_RUN 0
#define TIMER_0_BASE 0x1000
#define TIMER_0_COUNTER_SIZE 32
#define TIMER_0_FIXED_PERIOD 0
#define TIMER_0_FREQ 50000000
#define TIMER_0_IRQ 1
#define TIMER_0_IRQ_INTERRUPT_CONTROLLER_ID 0
#define TIMER_0_LOAD_VALUE 2499999
#define TIMER_0_MULT 0.001
#define TIMER_0_NAME "/dev/timer_0"
#define TIMER_0_PERIOD 50
#define TIMER_0_PERIOD_UNITS "ms"
#define TIMER_0_RESET_OUTPUT 0
#define TIMER_0_SNAPSHOT 1
#define TIMER_0_SPAN 32
#define TIMER_0_TICKS_PER_SEC 20
#define TIMER_0_TIMEOUT_PULSE_OUTPUT 0
#define TIMER_0_TYPE "altera_avalon_timer"


/*
 * vga_integrate_0 configuration
 *
 */

#define ALT_MODULE_CLASS_vga_integrate_0 vga_integrate
#define VGA_INTEGRATE_0_BASE 0x1040
#define VGA_INTEGRATE_0_IRQ -1
#define VGA_INTEGRATE_0_IRQ_INTERRUPT_CONTROLLER_ID -1
#define VGA_INTEGRATE_0_NAME "/dev/vga_integrate_0"
#define VGA_INTEGRATE_0_SPAN 32
#define VGA_INTEGRATE_0_TYPE "vga_integrate"

#endif /* __SYSTEM_H_ */
