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

entity main_VGA is
Port (clk: in std_logic;
      rst: in std_logic;
      
      VS: out std_logic;
      HS: out std_logic;
      rojo: out std_logic_vector(3 downto 0);
      verde: out std_logic_vector(3 downto 0);
      azul: out std_logic_vector(3 downto 0)
       );
end main_VGA;

architecture Behavioral of main_VGA is

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
begin

Sinc: sinc_vga port map(clk => clk, rst => rst, col => colAux, fila => filaAux, visible => visibleAux, hsinc => HS, vsinc => VS);
Imagen1: ventana port map(visible => visibleAux, col => colAux, fila =>filaAux, rojo => rojo, verde => verde, azul => azul);
--Imagen2: barras_colores port map(visible => visibleAux, col => colAux, fila =>filaAux, rojo => rojo, verde => verde, azul => azul);
end Behavioral;
