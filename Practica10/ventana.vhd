----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/26/2021 09:55:34 PM
-- Design Name: 
-- Module Name: ventana - Behavioral
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
use IEEE.std_logic_unsigned.all;
use IEEE.std_logic_arith.all;
use ieee.numeric_std.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ventana is
Port (
    visible: in std_logic;
    col: in std_logic_vector(9 downto 0);
    fila: in std_logic_vector(9 downto 0);
    
    rojo: out std_logic_vector(3 downto 0);
    verde: out std_logic_vector(3 downto 0);
    azul: out std_logic_vector(3 downto 0)
 );
end ventana;

architecture Behavioral of ventana is

begin

pantalla1: process(col, fila, visible)
begin
if visible = '1' then
    if (col < 10) OR (col > 629) OR ((col > 315) AND (col < 325)) OR      -- esto es para hacer el marco de color rojo
       (fila < 10) OR (fila > 469) OR ((fila > 235) AND (fila < 245)) then
       rojo <= "1111";
       verde <= "0000";
       azul <= "0000";
    else
        rojo <= "0000";
        verde <= "0000";
        azul <= "1111";
    end if;
 end if;
end process pantalla1;

end Behavioral;
