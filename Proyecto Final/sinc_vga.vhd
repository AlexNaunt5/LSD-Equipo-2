
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

entity sinc_vga is
Port (clk: in std_logic;
      rst: in std_logic;
      col, fila: out std_logic_vector(9 downto 0);
      visible,hsinc,vsinc: out std_logic
       );
end sinc_vga;

architecture Behavioral of sinc_vga is
signal C: std_logic_vector(2 downto 0):= "000";
signal clk25MHz: std_logic;
signal contador4: std_logic_vector(1 downto 0):="00";
signal cont_pxl, cont_line: std_logic_vector(9 downto 0):= "0000000000";
signal nuevo_pxl, nueva_linea: std_logic:= '0';
signal hsinc_sig, vsinc_sig: std_logic:= '1';
signal visible_pxl, visible_line: std_logic:= '1';

begin

divisor: process(clk)
begin
if (clk ='1') and (clk'event) then
   C <= C + 1;
   else null;
end if;
end process divisor;

cont4: process(clk,rst)
begin
    if rst = '1' then
        contador4 <= "00";
    elsif (clk'event) and (clk = '1') then
        contador4 <= contador4 + "01";
        if (contador4 = "11") then
            contador4 <= "00";
        end if;
    end if;
end process cont4;

ciclosReloj: process(contador4)
begin
    if (contador4 = "11") then
        nuevo_pxl <= '1';
    else nuevo_pxl <= '0';
    end if;
end process ciclosReloj;

cont800: process(clk, rst, nuevo_pxl)
begin
    if rst = '1' then
        cont_pxl <= "0000000000";
    elsif (clk'event) and (clk = '1') and (nuevo_pxl = '1') then
        cont_pxl <= cont_pxl + "0000000001";
        if (cont_pxl = "1100011111") then -- cont_pxl = 799
            cont_pxl <= "0000000000";
        end if;
    end if;
end process cont800;

pixeles: process(cont_pxl,contador4)
begin
    if (cont_pxl = "1100011111") and (contador4 = "11") then --799
        nueva_linea <= '1';
        visible_pxl <= '1';
    elsif (cont_pxl = "1010000000") then  --640
        visible_pxl <= '0';
    elsif (cont_pxl = "1010010000") then  --656
        hsinc_sig <= '0';
    elsif (cont_pxl = "1011110000") then  --752
        hsinc_sig <= '1';
    
    else 
        nueva_linea <= '0';
    end if;
end process pixeles;

cont520: process(clk, rst, nueva_linea)
begin
    if rst = '1' then
        cont_line <= "0000000000";
    elsif (clk'event) and (clk = '1') and (nueva_linea = '1') then
        cont_line <= cont_line + "0000000001";
        if (cont_line = "1000000111") then -- cont_line = 519
            cont_line <= "0000000000";
        end if;
    end if;
end process cont520;

lineas: process(cont_line)
begin
    if (cont_line = "1000000111") then -- cont_line = 519
        visible_line <= '1';
    elsif (cont_line = "0111100000") then -- 480
        visible_line <= '0';
    elsif (cont_line = "0111101001") then -- 489
        vsinc_sig <= '0';
    elsif (cont_line = "0111101011") then -- 491
        vsinc_sig <= '1';
    end if;
end process lineas;

clk25MHz <= C(1);

hsinc <= hsinc_sig;
vsinc <= vsinc_sig;
visible <= visible_pxl and visible_line;
col <= cont_pxl;
fila <= cont_line;

end Behavioral;
