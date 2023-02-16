#!/bin/bash

PART_LIST="./gd32vf103-parts-list.txt"

# if no arg,
if [ $# -ne 1 ]; then
  echo "Usage: ./setpart.sh <part>"
  echo "Please specify a gd32vf103 part:"
  while IFS= read -r line
  do
    part=$(echo "$line"|awk -F ' ' '{print $1}'| tr '[:upper:]' '[:lower:]')
    echo "$part"
  done < "$PART_LIST"
  exit
fi

# iterate the part list to found part info.
PART=$1
FLASH_SIZE=
RAM_SIZE=
LINKER_SCRIPT=

FOUND="f"

while IFS= read -r line
do
  cur_part=$(echo "$line"|awk -F ' ' '{print $1}'| tr '[:upper:]' '[:lower:]')
  FLASH_SIZE=$(echo "$line"|awk -F ' ' '{print $2}')
  RAM_SIZE=$(echo "$line"|awk -F ' ' '{print $3}')
  LINKER_SCRIPT=$(echo "$line"|awk -F ' ' '{print $4}')
  if [ "$cur_part""x" == "$PART""x" ]; then
    FOUND="t"
    break;
  fi
done < "$PART_LIST"

#if not found
if [ "$FOUND""x" == "f""x" ];then
  echo "Your part is not supported."
  exit
fi

# found
# set targetname
sed -i "s/^TARGET = .*/TARGET = $PART/g" Makefile

# set cflags
if [[ $PART = gd32vf103c* ]]; then
  sed -i "s/^CFLAGS += -DGD32VF103.*/CFLAGS += -DGD32VF103C_START/g" Makefile
fi
if [[ $PART = gd32vf103r* ]]; then
  sed -i "s/^CFLAGS += -DGD32VF103.*/CFLAGS += -DGD32VF103R_START/g" Makefile
fi
if [[ $PART = gd32vf103v* ]]; then
  sed -i "s/^CFLAGS += -DGD32VF103.*/CFLAGS += -DGD32VF103V_EVAL/g" Makefile
fi
if [[ $PART = gd32vf103r* ]]; then
  sed -i "s/^CFLAGS += -DGD32VF103.*/CFLAGS += -DGD32VF103R_START/g" Makefile
fi

# change linker script
sed -i "s/^LDSCRIPT = .\/Firmware\/RISCV\/.*/LDSCRIPT = .\/Firmware\/RISCV\/env_Eclipse\/$LINKER_SCRIPT/g" Makefile
