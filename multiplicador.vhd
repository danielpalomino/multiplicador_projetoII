LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY multiplicador IS
	PORT (clk, reset, start: IN STD_LOGIC;
			op_0, op_1: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
			produto: OUT STD_LOGIC_VECTOR(15 DOWNTO 0)			
		);
END multiplicador;

ARCHITECTURE comportamento OF multiplicador IS

COMPONENT controle IS
	PORT (
		clk, reset, start: IN STD_LOGIC;
		clear: OUT STD_LOGIC;
		op1: IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		enable: OUT STD_LOGIC
		);
END COMPONENT;

COMPONENT data_path IS
	PORT (
		clk, reset, enable: IN STD_LOGIC;
		op0: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
		produto: OUT STD_LOGIC_VECTOR (15 DOWNTO 0)		
		);
END COMPONENT;

SIGNAL enable, clear: STD_LOGIC;

BEGIN

INSTANCIA_CONTROLE: controle PORT MAP (
clk => clk,
reset => reset,
start => start,
clear => clear,
op1 => op_1,
enable => enable
);

INSTANCIA_DATA_PATH: data_path PORT MAP (
clk => clk,
reset => clear,
enable => enable,
op0 => op_0,
produto => produto
);
	
END comportamento;