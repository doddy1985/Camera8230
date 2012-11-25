library IEEE;
use IEEE.std_logic_1164.all;

-- Serial in parallel out shift reg
-- with async reset to '0'
-- and async parellel output load.
-- Presidence given to reset.
ENTITY shift_reg IS
	PORT (s_in, clk, reset, strobe : IN STD_LOGIC;
			q : OUT STD_LOGIC_VECTOR (3 DOWNTO 0));
END shift_reg;
	
ARCHITECTURE behavioral OF shift_reg IS
	SIGNAL reg : STD_LOGIC_VECTOR (3 DOWNTO 0);
	--VARIABLE var: ARRAY(4 DOWNTO 0);
BEGIN
q(3 DOWNTO 0) <= reg(3 DOWNTO 0);

	-- Serial in latch to parallel out
	-- Uses strobe line to hold/allow data flow
	PROCESS (clk, reset, strobe)
	BEGIN
		-- Async reset
		IF reset = '1' THEN
			reg <= (OTHERS => '0' );
		-- Sync serial in
		ELSIF clk' EVENT AND clk = '0' AND strobe = '1' THEN
				--Shift right
				reg(0) <= reg(1);
				reg(1) <= reg(2);
				reg(2) <= reg(3);
				reg(3) <= s_in;
				
				--Shift left
				--reg(0) <= s_in;
				--reg(3 DOWNTO 1) <= reg(2 DOWNTO 0);
				
		END IF;
		--q(3 DOWNTO 0) <= reg(3 DOWNTO 0);
	END PROCESS;
END behavioral;