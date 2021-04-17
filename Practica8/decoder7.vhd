library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_1164;


entity decoder7 is
Port(
        Clk: in std_logic;
        N1: in std_logic_vector(3 downto 0);
        S82: out std_logic_vector(7 downto 0)
);
end decoder7;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_1164;

architecture Behavioral of decoder7 is

begin
Process(Clk)
begin
 
-- pasa valor de 4 bits a su equivalente para display de 7 segmentos
case (N1) is
                    when "0000" => S82 <= "11000000";
                    when "0001" => S82 <= "11111001";
                    when "0010" => S82 <= "10100100";
                    when "0011" => S82 <= "10110000";
                    when "0100" => S82 <= "10011001";
                    when "0101" => S82 <= "10010010";
                    when "0110" => S82 <= "10000010";
                    when "0111" => S82 <= "11111000";
                    when "1000" => S82 <= "10000000";
                    when "1001" => S82 <= "10010000";
                    when others => S82 <= "11111111";
                    end case;
end process;
end Behavioral;
