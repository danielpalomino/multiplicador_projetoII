LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY controle IS
	PORT (
		clk, reset, start: IN STD_LOGIC;
		clear: OUT STD_LOGIC;
		op1: IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		enable: OUT STD_LOGIC
		);
END controle;

ARCHITECTURE comportamento OF controle IS

TYPE state IS (inicio, acumula, fim);

SIGNAL estado, proximo: state;

SIGNAL cont: STD_LOGIC_VECTOR (7 DOWNTO 0);


BEGIN

	PROCESS(clk, reset)
	BEGIN	
		IF(reset = '1') THEN
			estado <= inicio;
		ELSIF(clk'EVENT AND clk = '1') THEN
			estado <= proximo;
		END IF;	
	END PROCESS;
	
	PROCESS(clk, start)
	BEGIN
		IF(start = '1') THEN
			cont <= "00000000";
		ELSIF(clk'EVENT AND clk = '1') THEN
			cont <= cont + 1;
		END IF;	
	END PROCESS;
	
	PROCESS(clk)
	BEGIN
		CASE estado IS
		WHEN inicio =>
			IF (start = '1') THEN
			  clear <= '1';
				enable <= '0';				
				proximo <= acumula;
			ELSE
				proximo <= inicio;
			END IF;
		WHEN acumula =>
		  clear <= '0';
			enable <= '1';
			IF (cont = op1) THEN
				proximo <= fim;
			ELSE
				proximo <= acumula;
			END IF;		
		WHEN OTHERS =>
			enable <= '0';
			clear <= '0';
			IF (start = '1') THEN
				proximo <= acumula;
				clear <= '1';
			ELSE
				proximo <= fim;
			END IF;
		END CASE;
		
	END PROCESS;
	
END comportamento;