----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/26/2021 10:31:14 PM
-- Design Name: 
-- Module Name: main_VGA - Behavioral
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

entity main is
Port (CLK100MHZ: in std_logic;
      reset: in std_logic;
      
      VS: out std_logic;
      HS: out std_logic;
      rojo: out std_logic_vector(3 downto 0);
      verde: out std_logic_vector(3 downto 0);
      azul: out std_logic_vector(3 downto 0);
      
      draw1, draw2: in std_logic;
      
      vn_in: in std_logic;
      vp_in: in std_logic;
      vauxp2: in std_logic;
      vauxn2: in std_logic;
      vauxp3: in std_logic;
      vauxn3: in std_logic;
      vauxp10: in std_logic;
      vauxn10: in std_logic;
      vauxp11: in std_logic;
      vauxn11: in std_logic;
      
      seg7, an7 : out std_logic_vector(7 downto 0);
      
      LED: out std_logic_vector(15 downto 0)
      
       );
end main;

architecture Behavioral of main is

COMPONENT xadc_wiz_0
  PORT (
    di_in : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
    daddr_in : IN STD_LOGIC_VECTOR(6 DOWNTO 0);
    den_in : IN STD_LOGIC;
    dwe_in : IN STD_LOGIC;
    drdy_out : OUT STD_LOGIC;
    do_out : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
    dclk_in : IN STD_LOGIC;
    reset_in : IN STD_LOGIC;
    vp_in : IN STD_LOGIC;
    vn_in : IN STD_LOGIC;
    vauxp2 : IN STD_LOGIC;
    vauxn2 : IN STD_LOGIC;
    vauxp3 : IN STD_LOGIC;
    vauxn3 : IN STD_LOGIC;
    vauxp10 : IN STD_LOGIC;
    vauxn10 : IN STD_LOGIC;
    vauxp11 : IN STD_LOGIC;
    vauxn11 : IN STD_LOGIC;
    channel_out : OUT STD_LOGIC_VECTOR(4 DOWNTO 0);
    eoc_out : OUT STD_LOGIC;
    alarm_out : OUT STD_LOGIC;
    eos_out : OUT STD_LOGIC;
    busy_out : OUT STD_LOGIC
  );
END COMPONENT;

component seg7m is
       Port(ck : in  std_logic;                          -- 100MHz system clock
			number : in  std_logic_vector (63 downto 0); -- eight digit number to be displayed
			seg : out  std_logic_vector (7 downto 0);    -- display cathodes
			an : out  std_logic_vector (7 downto 0));    -- display anodes (active-low, due to transistor complementing)
end component;
component decoder7 is
Port(
        Clk: in std_logic;
        N1: in std_logic_vector(3 downto 0);
        S82: out std_logic_vector(7 downto 0)
);
end component;


-------------------------------------------------------------------
component Vga1 Port (clk : in STD_LOGIC;
                     Rin, Bin, Gin : in std_logic_vector(3 downto 0);
                     Hsync, Vsync, display, Halfclock : out std_logic;
                     VgaR, VgaB, VgaG : out std_logic_vector(3 downto 0); 
                     pixel_X : out std_logic_vector(10 downto 0);
                     pixel_Y : out std_logic_vector(9 downto 0));
end component;
                         
component char_rom Port (mp1: in std_logic;
                         mp2: in std_logic;
                         mp3: in std_logic; 
                         selectchar11: in integer; 
                         selectchar12: in integer;
                         selectchar21: in integer; 
                         selectchar22: in integer; 
                         selectchar31: in integer; 
                         selectchar32: in integer; 
                         userlevel : in integer;
                         display, Halfclock : in std_logic;
                         Rin, Bin, Gin : out std_logic_vector(3 downto 0); 
                         pixel_X : in std_logic_vector(10 downto 0); 
                         selectedY : in std_logic_vector(8 downto 0); 
                         selectedX : in std_logic_vector(9 downto 0); 
                         pixel_Y : in std_logic_vector(9 downto 0));
end component; 
                         
component bintodec2 Port (reading : in std_logic_vector(11 downto 0); 
                         clk : in STD_LOGIC;
                         mp1: out std_logic;
                         mp2: out std_logic;
                         mp3: out std_logic; 
                         selectchar11: out integer; 
                         selectchar12: out integer; 
                         selectchar21: out integer; 
                         selectchar22: out integer; 
                         selectchar31: out integer; 
                         selectchar32: out integer);
end component;

--------------------------------------------------------------------


component sinc_vga is
Port (clk: in std_logic;
      rst: in std_logic;
      col, fila: out std_logic_vector(9 downto 0);
      visible,hsinc,vsinc: out std_logic
       );
end component;

component ventana is
Port (
    visible: in std_logic;
    col: in std_logic_vector(9 downto 0);
    fila: in std_logic_vector(9 downto 0);
    
    rojo: out std_logic_vector(3 downto 0);
    verde: out std_logic_vector(3 downto 0);
    azul: out std_logic_vector(3 downto 0)
 );
end component;

component volts is
Port(
   CLK100MHZ: in std_logic;
   data: in std_logic_vector(15 downto 0);
   dig0,dig1,dig2,dig3,dig4,dig5,dig6: out std_logic_vector(3 downto 0)
 );
 end component;

signal d7s : std_logic_vector (63 downto 0):= "0000100101000000010001110000100011111111000000000000000000000000";
signal led_s: std_logic_vector(15 downto 0);
signal do_out: std_logic_vector(15 downto 0);
signal enable, write_enable, alarm, end_sequence, is_busy, data_ready: std_logic;
signal channel: std_logic_vector(4 downto 0);
signal daddr_aux: std_logic_vector(6 downto 0);
signal voltaje: std_logic_vector(11 downto 0);
signal dig0,dig1,dig2,dig3,dig4,dig5,dig6: std_logic_vector(3 downto 0):="0000";
--signal column, row: integer:= 0;
signal colAux, filaAux: std_logic_vector(9 downto 0);
signal visibleAux: std_logic;
signal C: std_logic_vector(2 downto 0):= "000";


------------------------------------------------------------------------------------
signal selectchar11 : integer; signal selectchar12 : integer; signal selectchar21 : integer; signal selectchar22 : integer; signal selectchar31 : integer; signal selectchar32 : integer; signal userlevell : integer;
signal mp1: std_logic; signal mp2: std_logic; signal mp3: std_logic;
signal reading: std_logic_vector(11 downto 0); signal Halfclock : std_logic; signal displayy : std_logic;
signal Rin, Bin, Gin : std_logic_vector(3 downto 0); signal pixel_X : std_logic_vector(10 downto 0); signal pixel_Y : std_logic_vector(9 downto 0); signal eoc: std_logic:= '1';
signal triggered: std_logic; signal clk_signal: std_logic; 
signal write_add: std_logic_vector(11 downto 0);
signal dataout : std_logic_vector(8 downto 0); -- y axis pixel value
signal trig_level : integer:=0; signal read_add: std_logic_vector(11 downto 0);
signal selectpixY : std_logic_vector(8 downto 0);
signal selectpixX : std_logic_vector(9 downto 0);
signal ylevel : std_logic_vector(8 downto 0);
signal xlevel : std_logic_vector(9 downto 0);
------------------------------------------------------------------------------------


begin

voltaje <= do_out(15 downto 4);

LED <= led_s;
daddr_aux <= "00"& channel;
clk_signal <= CLK100MHZ;

divisor: process(CLK100MHZ)
begin
if (CLK100MHZ ='1') and (CLK100MHZ'event) then
   C <= C + 1;
   else null;
end if;
end process divisor;

leds: process(CLK100MHZ, data_ready, do_out)
begin
 if rising_edge(CLK100MHZ) then
 if(data_ready = '1') then
   if do_out(15 downto 12) = "0001" then
        led_s <= "0000000000000001";
   elsif do_out(15 downto 12) = "0010" then
       led_s <= "0000000000000011";
   elsif do_out(15 downto 12) = "0011" then
       led_s <= "0000000000000111"; 
    elsif do_out(15 downto 12) = "0100" then
        led_s <= "0000000000001111";
   elsif do_out(15 downto 12) = "0101" then
        led_s <= "0000000000011111"; 
    elsif do_out(15 downto 12) = "0110" then
        led_s <= "0000000000111111";    
       elsif do_out(15 downto 12) = "0111" then
        led_s <= "0000000001111111"; 
    elsif do_out(15 downto 12) = "1000" then
        led_s <= "0000000011111111"; 
    elsif do_out(15 downto 12) = "1001" then
        led_s <= "0000000111111111";    
    elsif do_out(15 downto 12) = "1010" then
       led_s <= "0000001111111111";      
    elsif do_out(15 downto 12) = "1011" then
        led_s <= "0000011111111111"; 
    elsif do_out(15 downto 12) = "1100" then
        led_s <= "0000111111111111";     
    elsif do_out(15 downto 12) = "1101" then
        led_s <= "0001111111111111";
    elsif do_out(15 downto 12) = "1110" then
        led_s <= "0011111111111111";
    elsif do_out(15 downto 12) = "1111" then
        led_s <= "0111111111111111";  
    end if;      
   end if ;
 end if;
end process leds;


ADC : xadc_wiz_0
  PORT MAP (
    di_in => (others => '0'),
    daddr_in => daddr_aux,
    den_in => enable,
    dwe_in => '0',
    drdy_out => data_ready,
    do_out => do_out,
    dclk_in => CLK100MHZ,
    reset_in => reset,
    vp_in => vp_in,
    vn_in => vn_in,
    vauxp2 => vauxp2,
    vauxn2 => vauxn2,
    vauxp3 => vauxp3,
    vauxn3 => vauxn3,
    vauxp10 => vauxp10,
    vauxn10 => vauxn10,
    vauxp11 => vauxp11,
    vauxn11 => vauxn11,
    channel_out => channel,
    eoc_out => enable,
    alarm_out => alarm,
    eos_out => open,
    busy_out => open
  );

V: volts port map (CLK100MHZ => CLK100MHZ, data => do_out, dig0 => dig0, dig1 => dig1, dig2 => dig2, dig3 => dig3, dig4 => dig4, dig5 => dig5, dig6 => dig6);

u0 : decoder7 port map (Clk => CLK100MHZ, N1 => dig0, S82 => d7s(7 downto 0));
u1 : decoder7 port map (Clk => CLK100MHZ, N1 => dig1, S82 => d7s(15 downto 8));
u2 : decoder7 port map (Clk => CLK100MHZ, N1 => dig2, S82 => d7s(23 downto 16));
u3 : decoder7 port map (Clk => CLK100MHZ, N1 => dig3, S82 => d7s(31 downto 24));
u4 : decoder7 port map (Clk => CLK100MHZ, N1 => dig4, S82 => d7s(39 downto 32));
u5 : decoder7 port map (Clk => CLK100MHZ, N1 => dig5, S82 => d7s(47 downto 40));


DisplaySeg : seg7m port map (ck => CLK100MHZ, number => d7s, seg => seg7, an => an7);


---------------------------------------------------------------------------------------------
BINDEC: bintodec2 port map (reading => reading, 
                       clk => clk_signal, 
                       mp1 =>mp1,
                       mp2 =>mp2,
                       mp3 =>mp3,
                       selectchar11 => selectchar11, 
                       selectchar12 => selectchar12, 
                       selectchar21 => selectchar21, 
                       selectchar22 => selectchar22, 
                       selectchar31 => selectchar31, 
                       selectchar32 => selectchar32);
                         
VGADISPLAY: Vga1 port map(clk => clk_signal, 
                  Rin => Rin,
                  Bin => Bin, 
                  Gin => Gin,
                  Hsync => HS, 
                  Vsync => VS,
                  display => displayy,
                  Halfclock => Halfclock,
                  VgaR => rojo, VgaB => azul, VgaG => verde, 
                  pixel_X => pixel_X, pixel_Y => pixel_Y);
                         
ROM: char_rom port map(display => displayy,
                      Halfclock => Halfclock,
                      Rin => Rin, Bin => Bin, Gin => Gin,
                      pixel_X => pixel_X, pixel_Y => pixel_Y,
                      selectedY => selectpixY, selectedX => selectpixX,
                      userlevel => userlevell,
                      mp1 =>mp1, mp2 =>mp2, mp3 =>mp3,
                      selectchar11 => selectchar11, selectchar12 => selectchar12, selectchar21 => selectchar21, selectchar22 => selectchar22, selectchar31 => selectchar31, selectchar32 => selectchar32);
---------------------------------------------------------------------------------------------------------------------





--Sinc: sinc_vga port map(clk => CLK100MHZ, rst => reset, col => colAux, fila => filaAux, visible => visibleAux, hsinc => HS, vsinc => VS);
--Imagen1: ventana port map(visible => visibleAux, col => colAux, fila =>filaAux, rojo => rojo, verde => verde, azul => azul);
end Behavioral;
