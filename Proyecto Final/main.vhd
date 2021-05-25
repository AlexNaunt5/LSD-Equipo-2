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
      rst: in std_logic;
      
      VS: out std_logic;
      HS: out std_logic;
      rojo: out std_logic_vector(3 downto 0);
      verde: out std_logic_vector(3 downto 0);
      azul: out std_logic_vector(3 downto 0);
      
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
      
      LED: out std_logic_vector(15 downto 0)
      
       );
end main;

architecture Behavioral of main is

COMPONENT xadc_wiz_0
  PORT (
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
    vauxn11 : IN STD_LOGIC
  );
END COMPONENT;

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

component barras_colores is
Port (
    visible: in std_logic;
    col: in std_logic_vector(9 downto 0);
    fila: in std_logic_vector(9 downto 0);
    
    rojo: out std_logic_vector(3 downto 0);
    verde: out std_logic_vector(3 downto 0);
    azul: out std_logic_vector(3 downto 0)
 );
end component;

signal colAux, filaAux: std_logic_vector(9 downto 0);
signal visibleAux: std_logic;
signal outADC: std_logic_vector(15 downto 0);
begin

LED <= outADC;


your_instance_name : xadc_wiz_0
  PORT MAP (
    do_out => outADC,
    dclk_in => CLK100MHZ,
    reset_in => rst,
    vp_in => vp_in,
    vn_in => vn_in,
    vauxp2 => vauxp2,
    vauxn2 => vauxn2,
    vauxp3 => vauxp3,
    vauxn3 => vauxn3,
    vauxp10 => vauxp10,
    vauxn10 => vauxn10,
    vauxp11 => vauxp11,
    vauxn11 => vauxn11
  );

Sinc: sinc_vga 
  PORT MAP(
    clk => CLK100MHZ,
    rst => rst, 
    col => colAux,
    fila => filaAux,
    visible => visibleAux,
    hsinc => HS, 
    vsinc => VS
   );
    
--Imagen1: ventana  port map(visible => visibleAux, col => colAux, fila =>filaAux, rojo => rojo, verde => verde, azul => azul);
Imagen2: barras_colores port map(visible => visibleAux, col => colAux, fila =>filaAux, rojo => rojo, verde => verde, azul => azul);
end Behavioral;
