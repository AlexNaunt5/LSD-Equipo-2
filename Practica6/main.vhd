----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/18/2021 04:48:44 PM
-- Design Name: 
-- Module Name: main - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity main is
Port (clock : in std_logic; 
      opA, opB : in std_logic_vector(3 downto 0);
      opselect : in std_logic_vector(2 downto 0);
      sign : out std_logic;
      seg7d, an7d : out std_logic_vector(7 downto 0)
      );
      
end main;

architecture Behavioral of main is
--senales
signal suma, resta, mult : std_logic_vector(3 downto 0);
begin

Selector: process(opselect, opA, opB)
begin

end process;

end Behavioral;
