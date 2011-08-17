LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.all;
USE ieee.numeric_std.ALL;
 
ENTITY tb IS
END tb;
 
ARCHITECTURE behavior OF tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT multiplicador
    PORT(
         clk : IN  std_logic;
         reset : IN  std_logic;
         start : IN  std_logic;
         op_0 : IN  std_logic_vector(7 downto 0);
         op_1 : IN  std_logic_vector(7 downto 0);
         produto : OUT  std_logic_vector(15 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal reset : std_logic := '0';
   signal start : std_logic := '0';
   signal op_0 : std_logic_vector(7 downto 0) := (others => '0');
   signal op_1 : std_logic_vector(7 downto 0) := (others => '0');

 	--Outputs
   signal produto : std_logic_vector(15 downto 0);

   -- Clock period definitions
   constant clk_period : time := 20ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: multiplicador PORT MAP (
          clk => clk,
          reset => reset,
          start => start,
          op_0 => op_0,
          op_1 => op_1,
          produto => produto
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100ms.
		reset <= '1';
      wait for 40ns;
		reset <= '0';
		start <= '1';
		op_0 <= "00000010";
		op_1 <= "00001110";
		wait for 20ns;
		start <= '0';
		wait for 600ns;
		start <= '1';
		op_0 <= "00000010";
		op_1 <= "00000101";
		wait for 20ns;
		start <= '0';

      -- insert stimulus here 

      wait;
   end process;

END;
