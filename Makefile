######################################
# target
######################################
TARGET = gd32vf103cbt6
CFLAGS += -DGD32VF103C_START
#GD32VF103R_START
#GD32VF103C_START
#GD32VF103V_EVAL
#GD32VF103R_START

######################################
# building variables
######################################
# debug build?
DEBUG = 1
# optimization for size
OPT = -Os


#######################################
# paths
#######################################
# Build path
BUILD_DIR = build

######################################
# source
######################################
# C sources
C_SOURCES = \
Firmware/RISCV/stubs/sbrk.c \
Firmware/RISCV/stubs/lseek.c \
Firmware/RISCV/stubs/fstat.c \
Firmware/RISCV/stubs/write.c \
Firmware/RISCV/stubs/close.c \
Firmware/RISCV/stubs/_exit.c \
Firmware/RISCV/stubs/write_hex.c \
Firmware/RISCV/stubs/isatty.c \
Firmware/RISCV/stubs/read.c \
Firmware/RISCV/env_Eclipse/init.c \
Firmware/RISCV/env_Eclipse/handlers.c \
Firmware/RISCV/env_Eclipse/your_printf.c \
Firmware/RISCV/drivers/n200_func.c \
Firmware/GD32VF103_standard_peripheral/Source/gd32vf103_i2c.c \
Firmware/GD32VF103_standard_peripheral/Source/gd32vf103_spi.c \
Firmware/GD32VF103_standard_peripheral/Source/gd32vf103_dbg.c \
Firmware/GD32VF103_standard_peripheral/Source/gd32vf103_dac.c \
Firmware/GD32VF103_standard_peripheral/Source/gd32vf103_pmu.c \
Firmware/GD32VF103_standard_peripheral/Source/gd32vf103_eclic.c \
Firmware/GD32VF103_standard_peripheral/Source/gd32vf103_fmc.c \
Firmware/GD32VF103_standard_peripheral/Source/gd32vf103_adc.c \
Firmware/GD32VF103_standard_peripheral/Source/gd32vf103_dma.c \
Firmware/GD32VF103_standard_peripheral/Source/gd32vf103_crc.c \
Firmware/GD32VF103_standard_peripheral/Source/gd32vf103_can.c \
Firmware/GD32VF103_standard_peripheral/Source/gd32vf103_gpio.c \
Firmware/GD32VF103_standard_peripheral/Source/gd32vf103_exti.c \
Firmware/GD32VF103_standard_peripheral/Source/gd32vf103_bkp.c \
Firmware/GD32VF103_standard_peripheral/Source/gd32vf103_wwdgt.c \
Firmware/GD32VF103_standard_peripheral/Source/gd32vf103_rtc.c \
Firmware/GD32VF103_standard_peripheral/Source/gd32vf103_fwdgt.c \
Firmware/GD32VF103_standard_peripheral/Source/gd32vf103_timer.c \
Firmware/GD32VF103_standard_peripheral/Source/gd32vf103_usart.c \
Firmware/GD32VF103_standard_peripheral/Source/gd32vf103_exmc.c \
Firmware/GD32VF103_standard_peripheral/Source/gd32vf103_rcu.c \
Firmware/GD32VF103_standard_peripheral/system_gd32vf103.c \
User/systick.c \
User/main.c

#Firmware/GD32VF103_usbfs_driver/Source/drv_usbd_int.c \
#Firmware/GD32VF103_usbfs_driver/Source/usbh_enum.c \
#Firmware/GD32VF103_usbfs_driver/Source/usbd_transc.c \
#Firmware/GD32VF103_usbfs_driver/Source/drv_usb_host.c \
#Firmware/GD32VF103_usbfs_driver/Source/usbh_pipe.c \
#Firmware/GD32VF103_usbfs_driver/Source/usbh_transc.c \
#Firmware/GD32VF103_usbfs_driver/Source/usbh_core.c \
#Firmware/GD32VF103_usbfs_driver/Source/drv_usb_core.c \
#Firmware/GD32VF103_usbfs_driver/Source/drv_usb_dev.c \
#Firmware/GD32VF103_usbfs_driver/Source/usbd_core.c \
#Firmware/GD32VF103_usbfs_driver/Source/drv_usbh_int.c \
#Firmware/GD32VF103_usbfs_driver/Source/usbd_enum.c \

# ASM sources
ASM_SOURCES =  \
Firmware/RISCV/env_Eclipse/start.S \
Firmware/RISCV/env_Eclipse/entry.S

#######################################
# binaries
#######################################
PREFIX = riscv-none-embed-

CC = $(PREFIX)gcc
AS = $(PREFIX)gcc -x assembler-with-cpp
CP = $(PREFIX)objcopy
SZ = $(PREFIX)size

HEX = $(CP) -O ihex
BIN = $(CP) -O binary -S

#######################################
# CFLAGS
#######################################
# cpu
CPU = -march=rv32imac -mabi=ilp32 -msmall-data-limit=8 

# For gcc v12 and above
# CPU = -march=rv32imac_zicsr -mabi=ilp32 -msmall-data-limit=8

# mcu
MCU = $(CPU) $(FPU) $(FLOAT-ABI)

# AS includes
AS_INCLUDES = 

# C includes
C_INCLUDES =  \
-IFirmware/RISCV/stubs \
-IFirmware/RISCV/drivers \
-IFirmware/GD32VF103_usbfs_driver/Include \
-IFirmware/GD32VF103_standard_peripheral/Include \
-I./Firmware/GD32VF103_standard_peripheral \
-IUser

# compile gcc flags
ASFLAGS = $(MCU) $(AS_INCLUDES) $(OPT) -Wall -fdata-sections -ffunction-sections

CFLAGS += $(MCU) $(C_INCLUDES) $(OPT) -Wall -fdata-sections -ffunction-sections

ifeq ($(DEBUG), 1)
CFLAGS += -g -gdwarf-2
endif


# Generate dependency information
CFLAGS += -MMD -MP -MF"$(@:%.o=%.d)"


#######################################
# LDFLAGS
#######################################
# link script
LDSCRIPT = ./Firmware/RISCV/env_Eclipse/GD32VF103xB.lds

# libraries
LIBS = -lc -lm -lnosys
LIBDIR = 
LDFLAGS = $(MCU) -mno-save-restore -fmessage-length=0 -fsigned-char -ffunction-sections -fdata-sections -Wunused -Wuninitialized -T $(LDSCRIPT) -nostartfiles -Xlinker --gc-sections -Wl,-Map=$(BUILD_DIR)/$(TARGET).map --specs=nano.specs $(LIBS)

# default action: build all
all: $(BUILD_DIR)/$(TARGET).elf $(BUILD_DIR)/$(TARGET).hex $(BUILD_DIR)/$(TARGET).bin


#######################################
# build the application
#######################################
# list of objects
OBJECTS = $(addprefix $(BUILD_DIR)/,$(notdir $(C_SOURCES:.c=.o)))
vpath %.c $(sort $(dir $(C_SOURCES)))

# list of ASM program objects
OBJECTS += $(addprefix $(BUILD_DIR)/,$(notdir $(ASM_SOURCES:.S=.o)))
vpath %.S $(sort $(dir $(ASM_SOURCES)))

$(BUILD_DIR)/%.o: %.c Makefile | $(BUILD_DIR)
	$(CC) -c $(CFLAGS) -Wa,-a,-ad,-alms=$(BUILD_DIR)/$(notdir $(<:.c=.lst)) $< -o $@

$(BUILD_DIR)/%.o: %.S Makefile | $(BUILD_DIR)
	$(AS) -c $(CFLAGS) $< -o $@
#$(LUAOBJECTS) $(OBJECTS)
$(BUILD_DIR)/$(TARGET).elf: $(OBJECTS) Makefile
	$(CC) $(OBJECTS) $(LDFLAGS) -o $@
	$(SZ) $@

$(BUILD_DIR)/%.hex: $(BUILD_DIR)/%.elf | $(BUILD_DIR)
	$(HEX) $< $@
	
$(BUILD_DIR)/%.bin: $(BUILD_DIR)/%.elf | $(BUILD_DIR)
	$(BIN) $< $@	
	
$(BUILD_DIR):
	mkdir $@		

#######################################
# Program
#######################################
program: $(BUILD_DIR)/$(TARGET).elf 
	sudo wch-openocd -f /usr/share/wch-openocd/openocd/scripts/interface/wch-riscv.cfg -c 'init; halt; program $(BUILD_DIR)/$(TARGET).elf; reset; wlink_reset_resume; exit;'

isp: $(BUILD_DIR)/$(TARGET).bin
	wchisp flash $(BUILD_DIR)/$(TARGET).bin

#######################################
# clean up
#######################################
clean:
	-rm -fR $(BUILD_DIR)
  
#######################################
# dependencies
#######################################
-include $(wildcard $(BUILD_DIR)/*.d)

# *** EOF ***
