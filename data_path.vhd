LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY data_path IS
	PORT (
		clk, reset, enable: IN STD_LOGIC;
		op0: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
		produto: OUT STD_LOGIC_VECTOR (15 DOWNTO 0)		
		);
END data_path;

ARCHITECTURE comportamento OF data_path IS

SIGNAL reg_op0: STD_LOGIC_VECTOR (7 DOWNTO 0);
SIGNAL parcial, reg_produto: STD_LOGIC_VECTOR (15 DOWNTO 0);

BEGIN

	PROCESS (clk, reset)
	BEGIN
		IF(reset = '1') THEN
			reg_op0 <= (OTHERS=>'0');
			reg_produto <= (OTHERS=>'0');
		ELSIF(clk'EVENT AND clk = '1') THEN
			reg_op0 <= op0;
			IF (enable = '1') THEN
				reg_produto <= parcial;
			END IF;
		END IF;
	END PROCESS;
	
	parcial <= reg_produto + (reg_op0(7) & reg_op0(7) & reg_op0(7) & reg_op0(7) & reg_op0(7) & reg_op0(7) & reg_op0(7) & reg_op0(7) & reg_op0);
	produto <= reg_produto;

	
END comportamento;