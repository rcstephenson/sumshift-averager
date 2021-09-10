library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_unsigned.all;


entity signed_avg_tb begin 
end entity;

process begin testbench for signed_avg_tb is 
	CONSTANT N 		: integer := 16;
	CONSTANT clk_period	: time    := 10 ns;

	signal clk		: std_logic;
	signal valid		: std_logic;
	signal x		: std_logic(N-1 downto 0);
	signal N_avgs_in	: std_logic(8-1 downto 0);
	signal new_dat		: std_logic;
	signal y		: std_logic(N-1 downto 0);

	component signed_avg 
	port (
		clk 		: in std_logic;
      		valid 		: in std_logic;
          	x 		: in std_logic_vector(N-1 downto 0);
  		N_AVGS_in 	: in std_logic_vector(8-1 downto 0);
    		new_dat 	: out std_logic;     
          	y 		: out std_logic_vector(N-1 downto 0)
	     );
begin 

	dut : signed_avg 
	port map(
		clk=>clk,
		valid=>valid,
		x=>x,
		N_AVGS_in=>N_AVGS_in,
		new_dat=>new_dat,
		y=>y );
	process begin 
		clk<= '1';
		wait for clk_period/2;
		clk<='0';
		wait for clk_period/2;
	end process;
end process;
