###############################################################################
# Makefile for project 
###############################################################################

## General options
PROJECT = 
MCU = 80C52
COMPILER = "ASEM-51 (Proteus)"
TARGET = Debug
SHELL = C:\windows\system32\cmd.exe

## Tools general options

## Processing Tools
ASM=asem.exe
DDX=ASEMDDX.EXE
#  D:/JOHNDAYTON/IFCE/6 SEMESTRE/MICROCONTROLADOR/Exercício_1/80C52/Debug/Debug.HEX: TOOL=ASM
#  Post: $(DDX) $(DDXFLAGS) Debug.lst
#     D:/JOHNDAYTON/IFCE/6 SEMESTRE/MICROCONTROLADOR/Exercício_1/80C52/main.asm

# Build tree:
all:	Debug

Debug:	Debug.HEX

Debug.HEX:	../main.asm 
	$(ASM) "..\main.asm" "Debug.HEX" Debug.lst $(ASMFLAGS)  /INCLUDES:"C:\Program Files (x86)\Labcenter Electronics\Proteus 8 Professional\VSM Studio\Tools\ASEM51"
	$(DDX) $(DDXFLAGS) Debug.lst

# tidy - delete all temporary files which are not involved in the target generation
tidy:
	rm -rf Debug.lst

# cleanup - delete all generated files
clean:	tidy
	rm -rf Debug.HEX
	rm -rf Debug.SDI

