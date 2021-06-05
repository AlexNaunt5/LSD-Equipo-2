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

entity display is
Port (
    enable_vga: in std_logic;
    col: in std_logic_vector(9 downto 0);
    r: in std_logic_vector(9 downto 0);

    draw1, draw2: in std_logic;
    rojo: out std_logic_vector(3 downto 0);
    verde: out std_logic_vector(3 downto 0);
    azul: out std_logic_vector(3 downto 0)
 );
end display;

architecture Behavioral of display is
--signal column, row: integer:= 0;
begin

-- <=  to_integer(unsigned(col));
--row <= to_integer(unsigned(r));

process(enable_vga, col, r, draw1, draw2)
begin
    if(draw1 = '1' AND draw2 = '0') then 
        if(enable_vga = '1') then
            if(r <= 48 OR (r >= 432 and r <= 480)) then 
                azul <= (OTHERS => '0');
                rojo <= (OTHERS => '1');
                verde <= (OTHERS => '0');
            elsif(r > 48 AND r < 432) then 
                if(r >= 216 and r <= 264) then
                    azul <= (OTHERS => '0');
                    rojo <= (OTHERS => '1');
                    verde <= (OTHERS => '0');
                else
                    if(col <= 48 OR (col >= 592 AND col <= 640)) then
                        azul <= (OTHERS => '0');
                        rojo <= (OTHERS => '1');
                        verde <= (OTHERS => '0');
                    elsif(col >= 296 AND col <= 344) then
                        azul <= (OTHERS => '0');
                        rojo <= (OTHERS => '1');
                        verde <= (OTHERS => '0');
                    else
                        azul <= (OTHERS => '1');
                        rojo <= (OTHERS => '0');
                        verde <= (OTHERS => '0');
                    end if;
                end if;
            end if;    
       else
           azul <= (OTHERS => '0');
           rojo <= (OTHERS => '0');
           verde <= (OTHERS => '0');
        end if;
        
    elsif(draw1='0' AND draw2='1') then
        if(enable_vga = '1') then
            if(col <= 79) then
                azul <= (OTHERS => '1');
                rojo <= (OTHERS => '1');
                verde <= (OTHERS => '1');
            elsif(col >= 80 AND col <= 159) then
                azul <= (OTHERS => '0');
                rojo <= (OTHERS => '1');
                verde <= (OTHERS => '1'); 
            elsif(col >= 160 AND col <= 239) then
                azul <= (OTHERS => '1');
                rojo <= (OTHERS => '0');
                verde <= (OTHERS => '1'); 
            elsif(col >= 240 AND col <= 319) then
                azul <= (OTHERS => '0');
                rojo <= (OTHERS => '0');
                verde <= (OTHERS => '1'); 
            elsif(col >= 320 AND col <= 399) then
                azul <= (OTHERS => '1');
                rojo <= (OTHERS => '1');
                verde <= (OTHERS => '0'); 
            elsif(col >= 400 AND col <= 479) then
                azul <= (OTHERS => '0');
                rojo <= (OTHERS => '1');
                verde <= (OTHERS => '0'); 
            elsif(col >= 480 AND col <= 559) then
                azul <= (OTHERS => '1');
                rojo <= (OTHERS => '0');
                verde <= (OTHERS => '0');  
            else
                azul <= (OTHERS => '0');
                rojo <= (OTHERS => '0');
                verde <= (OTHERS => '0');                    
            end if;            
        end if;
    else
        azul <= (OTHERS => '0');
        rojo <= (OTHERS => '0');
        verde <= (OTHERS => '0');      
    end if;    
end process;

end Behavioral;

