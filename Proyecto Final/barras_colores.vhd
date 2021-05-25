----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/26/2021 10:22:53 PM
-- Design Name: 
-- Module Name: barras_colores - Behavioral
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

entity barras_colores is
Port (
    visible: in std_logic;
    col: in std_logic_vector(9 downto 0);
    fila: in std_logic_vector(9 downto 0);
    
    rojo: out std_logic_vector(3 downto 0);
    verde: out std_logic_vector(3 downto 0);
    azul: out std_logic_vector(3 downto 0)
 );
end barras_colores;

architecture Behavioral of barras_colores is

begin

pantalla2: process(col, fila, visible)
begin
rojo <= "0000";
verde <= "0000";
azul <= "0000";
if visible = '1' then
    
    if (col >= 0) and (col < 64) then --blanco
        rojo <= "1111";
        verde <= "1111";
        azul <= "1111";
    elsif (col >= 64) and (col < 128) then --amarillo
        rojo <= "1111";
        verde <= "1111";
        azul <= "0000";
    elsif (col >= 128) and (col < 192) then --cyan
        rojo <= "0000";
        verde <= "1111";
        azul <= "1111";
    elsif (col >= 192) and (col < 256) then --verde
        rojo <= "0000";
        verde <= "1111";
        azul <= "0000";
    elsif (col >= 256) and (col < 320) then --magenta
        rojo <= "1111";
        verde <= "0000";
        azul <= "1111";
    elsif (col >= 320) and (col < 384) then --rojo
        rojo <= "1111";
        verde <= "0000";
        azul <= "0000";
    elsif (col >= 384) and (col < 448) then --azul
        rojo <= "0000";
        verde <= "0000";
        azul <= "1111";
    elsif (col >= 448) then --negro
        rojo <= "0000";
        verde <= "0000";
        azul <= "0000";
    else
        rojo <= "0000";
        verde <= "0000";
        azul <= "0000";
    end if;
    
end if;
end process pantalla2;

end Behavioral;
