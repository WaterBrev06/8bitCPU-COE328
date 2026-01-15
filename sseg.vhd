LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY sseg IS
	PORT( bed: IN STD_LOGIC_VECTOR(3 DOWNTO 0);
			leds : OUT STD_LOGIC_VECTOR(1 TO 7);
			neg : IN STD_LOGIC;
			leds2 : OUT STD_LOGIC_VECTOR(1 TO 7)
			);
END sseg;

ARCHITECTURE Behavior OF sseg IS
BEGIN
	PROCESS(bed)
	BEGIN	
		CASE bed IS					--	abcdefg
			WHEN "0000" => leds <= NOT("1111110");
			WHEN "0001" => leds <= NOT("0110000");
			WHEN "0010" => leds <= NOT("1101101");
			WHEN "0011" => leds <= NOT("1111001");
			WHEN "0100" => leds <= NOT("0110011");
			WHEN "0101" => leds <= NOT("1011011");
			WHEN "0110" => leds <= NOT("1011111");
			WHEN "0111" => leds <= NOT("1110000");
			
			WHEN "1111" => leds <= NOT("1000111"); --15 F
			WHEN "1110" => leds <= NOT("1001111"); --14 E
			WHEN "1101" => leds <= NOT("0111101"); --13 D
			WHEN "1100" => leds <= NOT("1001110"); --12 C
			WHEN "1011" => leds <= NOT("0011111"); --11 B
			WHEN "1010" => leds <= NOT("1110111"); --10 A
			
			WHEN "1000" => leds <= NOT("1111111"); --8
			WHEN "1001" => leds <= NOT("1110011");--9
			
			WHEN OTHERS => leds <= "-------";
		END CASE;
	END PROCESS;
	
	PROCESS(neg)
	BEGIN
		CASE neg IS --negative
		WHEN '1' => leds2 <= NOT("0000001");
		WHEN '0' => leds2 <= NOT("0000000");
		WHEN OTHERS => leds2 <= "-------";
		END CASE;
	END PROCESS;
End Behavior;