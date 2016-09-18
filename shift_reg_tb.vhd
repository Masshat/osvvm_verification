library ieee;
use ieee.std_logic_1164.all;
use ieee.Numeric_Std.all;

library osvvm;
use osvvm.OsvvmGlobalPkg.all;
use osvvm.RandomPkg.all;
use osvvm.CoveragePkg.all;

entity shift_reg_tb is
end shift_reg_tb;

architecture tb_env of shift_reg_tb is
signal clk, reset : std_logic:= '0';
signal input, output: std_logic_vector (7 downto 0):= (others => '0');
signal pos : std_logic_vector (2 downto 0):= (others => '0');
--signal hor 	: std_logic;
signal tck	: time:= 10 ns;

signal Stop : boolean;
shared variable is_finish     : covPType;
shared variable cp_pos        : covPType;
shared variable cp_input      : covPType;
shared variable cp_pos_input  : covPType;

begin
ent: entity work.shift_reg
	port map(clk => clk, reset=>reset, pos => pos, input=>input, output=>output);
--horloge : entity work.genhor(simple)
--   port map(tck => tck, hor => hor) ;

ck_process : process
begin
        clk <= '0';
        wait for tck/2;
        clk <= '1';
        wait for tck/2;
end process;
--Random Stimulus
stim : process

variable Rnd_pos   : RandomPType;
variable Rnd_input : RandomPType;
variable pos_int   : natural range 1 to 7;
variable input_int : natural range 0 to 255;
variable nCycles   : natural;
variable allDone   : boolean;

begin
	wait for 100 ns;
	 reset <='1';
	wait for 100 ns;
	 reset <='0';
        wait for 100 ns;
	Rnd_pos.InitSeed(Rnd_pos'instance_name);
	Rnd_input.InitSeed(Rnd_input'instance_name);

	while not allDone loop
		pos <= Rnd_pos.Randslv(1,7,3);
		input <= Rnd_input.Randslv(0,255,8);
		wait for 10 ns;

	allDone := cp_pos_input.isCovered;
	nCycles := nCycles + 1;
	end loop;
	wait for 10 ns;
	report "Number of simulation cycles = " & to_string(nCycles);
	Stop <= TRUE;
	wait;
end process;

InitCoverage : process 
begin
	--7 discrete bins for OP
	cp_pos.AddBins(GenBin(1,7));

	--8 equal bins for input
	cp_input.AddBins(GenBin(0,254,8));

	--Look for every combination of input and pos
	cp_pos_input.AddCross(GenBin(1,7), GenBin(0,254,8));
	
	wait;
end process;

Sample : process
begin
	loop
	wait on input;
	wait for 10 ns; -- wait until all signals stable

	--Sample the simple covernotes
	cp_pos.ICover		(to_integer(unsigned(pos)));
	cp_input.ICover		(to_integer(unsigned(input)));
	cp_pos_input.ICover	((to_integer(unsigned(pos)), to_integer(unsigned(input))));
	end loop;

end process;

CoverReport : process
begin
	wait until Stop;
    	report("pos Coverage details");
    	cp_pos.WriteBin;
    	report("input Coverage details");
    	cp_input.WriteBin;
    	report "pos x input";
    	cp_pos_input.writebin;
    	report "coverage holes " & to_string(cp_pos_input.CountCovHoles);
	assert false report "end of test" severity note;
end process;

end tb_env;
