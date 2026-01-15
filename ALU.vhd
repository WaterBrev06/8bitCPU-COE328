library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.all;
use IEEE.NUMERIC_STD.all;

entity ALU is
	port (Clock : in  STD_LOGIC ;
			A,B : in UNSIGNED(7 DOWNTO 0);
			student_id : in unsigned (3 DOWNTO 0);
			OP : in UNSIGNED (15 DOWNTO 0);
			Neg : out STD_LOGIC;  --is result negative? set -ve bit output
			R1 : out UNSIGNED (3 DOWNTO 0);
			R2 : out UNSIGNED (3 DOWNTO 0);
			fsmTest : out UNSIGNED (3 DOWNTO 0); 
			fsmTestTwo : out UNSIGNED (3 DOWNTO 0)) ; 
end ALU;

ARCHITECTURE calculation of ALU is --temporary signal declarations
	Signal Reg1, Reg2, Result : UNSIGNED (7 DOWNTO 0) := (others =>'0');
	Signal Reg4 : UNSIGNED (7 DOWNTO 0);
	BEGIN
		Reg1 <= A;
		Reg2 <= B; --temporarily store A and B in local vars reg1 and reg2
		PROCESS (Clock, OP)
		BEGIN
			--IF (rising_edge(Clock)) THEN 
				case OP is
					WHEN "0000000000000001" => 
						Neg <= '0';
						--Result <= Reg1 + Reg2; --Do addition Reg1 Reg 2
						Result <= rotate_right(Reg1, 4); --0101 0001
						
					WHEN "0000000000000010" => --Do subtraction, "Neg" bit set if required | Diff(a,b)= a-b
						--IF (Reg1 >= Reg2) THEN --A =15 B = 16
							--Neg <= '0';
							--Result <= Reg1 - Reg2;
						--ELSE 
							--Neg <= '1';
							--Result <= Reg2 - Reg1;
						--end if;
						Neg <= '0';
						Result <=  Reg2 (3 DOWNTO 0) & Reg2 (7 DOWNTO 4) ; --0110 0001
					WHEN "0000000000000100" => 
						Neg <='0';
						Result <= NOT Reg1; -- Do Inverse (not gate)
					WHEN "0000000000001000" => 
					Neg <='0';
					Result <= NOT(Reg1 AND Reg2); -- Do boolean NAND
					WHEN "0000000000010000" => 
					Neg <='0';
					Result <= NOT(Reg1 OR Reg2); -- Boolean NOR
					WHEN "0000000000100000" => 
					Neg <='0';
					Result <= Reg1 AND Reg2; -- Boolean AND
					WHEN "0000000001000000" =>
					Neg <='0';
					Result <= Reg1 XOR Reg2; -- Boolean XOR
					WHEN "0000000010000000" =>
					Neg <='0';
					Result <= Reg1 OR Reg2; -- Boolean OR
					WHEN "0000000100000000" =>
					Neg <='0';
					Result <= NOT (Reg1 XOR Reg2); -- Boolean XNOR
					WHEN OTHERS => 
					Neg <='0';
					Result <= Result; -- Dont care, do nothing
			end case;
			IF ((student_id = Reg1(7 DOWNTO 4)) OR (student_id = Reg1(3 DOWNTO 0))) THEN
				fsmTest <= "0001";
			ELSE
				fsmTest <= "0000";
			end if;
			
			IF((student_id > Reg2(7 DOWNTO 4)) OR (student_id > Reg2(3 DOWNTO 0))) THEN
				fsmTestTwo <= "0001";
			ELSE
				fsmTestTwo <= "0000";
			end if;
			
		--end if;
	end process;	
	R1 <= Result(3 DOWNTO 0);
	R2 <= Result(7 DOWNTO 4);
	end calculation;
				
					