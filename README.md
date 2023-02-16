# gd32vf103 firmware library with gcc and makefile support

This is pre-converted gd32vf103 firmware library with gcc and makefile support from GigaDevice official 'GD32VF103_Firmware_Library_V1.1.5.rar'. 

For more information about how to use this library, refer to [this tutorial](https://github.com/cjacker/opensource-toolchain-gd32vf103).

This firmware library support below gd32vf103 risc-v parts from GigaDevice:

- gd32vf103c4t6
- gd32vf103c6t6
- gd32vf103c8t6
- gd32vf103cbt6
- gd32vf103r4t6
- gd32vf103r6t6
- gd32vf103r8t6
- gd32vf103rbt6
- gd32vf103t4u6
- gd32vf103t6u6
- gd32vf103t8u6
- gd32vf103tbu6
- gd32vf103v8t6
- gd32vf103vbt6

The default part is set to 'gd32vf103cbt6' for longan nano board, you can change it with `./setpart.sh <part>`.

The default 'User' codes is blinking the LED connect to PC13 for longan nano board.

To build the project, type `make`.

