
all: clean pre_build osvvm compile

pre_build:
	ghdl --clean --workdir=work
	ghdl --clean --workdir=osvvm
	ghdl --remove --workdir=work

osvvm:
	@mkdir -p osvvm
	ghdl -a --std=08 --work=osvvm --workdir=osvvm --ieee=standard $(OSVVM_DIR)/NamePkg.vhd
	ghdl -a --std=08 --work=osvvm --workdir=osvvm --ieee=standard $(OSVVM_DIR)/OsvvmGlobalPkg.vhd
	ghdl -a --std=08 --work=osvvm --workdir=osvvm --ieee=standard $(OSVVM_DIR)/TranscriptPkg.vhd
	ghdl -a --std=08 --work=osvvm --workdir=osvvm --ieee=standard $(OSVVM_DIR)/TextUtilPkg.vhd
	ghdl -a --std=08 --work=osvvm --workdir=osvvm --ieee=standard $(OSVVM_DIR)/AlertLogPkg.vhd
	ghdl -a --std=08 --work=osvvm --workdir=osvvm --ieee=standard $(OSVVM_DIR)/SortListPkg_int.vhd
	ghdl -a --std=08 --work=osvvm --workdir=osvvm --ieee=standard $(OSVVM_DIR)/RandomBasePkg.vhd
	ghdl -a --std=08 --work=osvvm --workdir=osvvm --ieee=standard $(OSVVM_DIR)/RandomPkg.vhd
	ghdl -a --std=08 --work=osvvm --workdir=osvvm --ieee=standard $(OSVVM_DIR)/MessagePkg.vhd
	ghdl -a --std=08 --work=osvvm --workdir=osvvm --ieee=standard $(OSVVM_DIR)/CoveragePkg.vhd
	ghdl -a --std=08 --work=osvvm --workdir=osvvm --ieee=standard $(OSVVM_DIR)/MemoryPkg.vhd
	ghdl -a --std=08 --work=osvvm --workdir=osvvm --ieee=standard $(OSVVM_DIR)/OsvvmContext.vhd
	#ghdl -a --std=08 --work=osvvm --workdir=osvvm --ieee=standard $(OSVVM_DIR)/TbUtilPkg.vhd

compile:
	@mkdir -p work
	ghdl -c --workdir=work --std=08 --ieee=standard -Posvvm *.vhd -e shift_reg_tb

run:
	ghdl -r shift_reg_tb

wave:
	mkdir -p work
	ghdl -r shift_reg_tb --vcd=work/shift_reg.vcd --stop-time=3000ns
	gtkwave work/shift_reg.vcd 2> /dev/null

clean:
	rm -rf work osvvm *.o shift_reg_tb
