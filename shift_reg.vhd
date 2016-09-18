library ieee;
use ieee.std_logic_1164.all;

entity shift_reg is
	port(   clk	: in std_logic;
		reset	: in std_logic;
		pos	: in std_logic_vector(2 downto 0);
		input	: in std_logic_vector (7 downto 0);
		output	: out std_logic_vector (7 downto 0));
end shift_reg ;

architecture rtl of shift_reg is
signal tmp : std_logic_vector(7 downto 0);
begin

process(pos)
begin
		case pos is
		when "001" => tmp <= input(6 downto 0) & '1';
		when "010" => tmp <= input(5 downto 0) & "10";
		when "011" => tmp <= input(4 downto 0) & "100";
		when "100" => tmp <= input(3 downto 0) & "1000";
		when "101" => tmp <= input(2 downto 0) & "10000";
		when "110" => tmp <= input(1 downto 0) & "100000";
		when "111" => tmp <= "10000000";
		when others => tmp <= input;
		end case;
end process;
process (clk)
begin
	if (reset = '1') then
		output <= (others => '0');
	elsif(rising_edge(clk)) then
		output <= tmp;
	end if;
end process;
end rtl;
