TOPLEVEL_LANG = vhdl

PWD = $(shell pwd)

SOURCEDIR := $(PWD)/../hdl/

VHDL_SOURCES := $(shell find $(SOURCEDIR) -name '*.vhd')

TOPLEVEL := modfs4 #name of entity top
MODULE := test
SIM := GHDL

$(shell mkdir -p ./waveforms)
SIM_ARGS+=--vcd=./waveforms/modfs4.vcd #name of the file gtkwave

include $(shell cocotb-config --makefiles)/Makefile.sim