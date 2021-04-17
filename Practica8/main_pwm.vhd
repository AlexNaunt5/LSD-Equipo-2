library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity main_pwm is  
port (
    clk100m : in std_logic;
    btn_in  : in std_logic;
    pwm_out : out std_logic;
    seg7, an7 : out std_logic_vector(7 downto 0)
);
end main_pwm;

architecture Behavioral of main_pwm is

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

subtype u20 is unsigned(19 downto 0);
signal counter      : u20 := x"00000";

constant clk_freq   : integer := 100_000_000;       -- Clock frequency in Hz (10 ns)
constant pwm_freq   : integer := 50;                -- PWM signal frequency in Hz (20 ms)
constant period     : integer := clk_freq/pwm_freq; -- Clock cycle count per PWM period
signal duty_cycle : integer := 50_000;            -- Clock cycle count per PWM duty cycle

signal pwm_counter  : std_logic := '0';
signal stateHigh    : std_logic := '1';

signal d7s : std_logic_vector (63 downto 0):= "0000100101000000010001110000100011111111000000000000000000000000";
signal grados_un : std_logic_vector (3 downto 0);
signal grados_dec : std_logic_vector (3 downto 0);
signal grados_cen : std_logic_vector (3 downto 0);

signal dc : std_logic := '0';
signal push_button_sig1 : std_logic;
signal push_button_sig2 : std_logic;
signal btn : std_logic := '0';
begin


boton: process(clk100m, btn_in)
begin
 if rising_edge(clk100m) then
   push_button_sig1 <=  btn_in;
   push_button_sig2 <=  push_button_sig1;
end if ;
end process boton;

boton2: process(clk100m, btn_in)
begin
  if rising_edge(clk100m) then
    if  push_button_sig1 = '0' and btn_in = '1' then  --- Rise edge 
        case(duty_cycle) is
            when 50_000 => duty_cycle <= 100_000;
            when 100_000 => duty_cycle <= 150_000;
            when 150_000 => duty_cycle <= 200_000;
            when 200_000 => duty_cycle <= 250_000;
            when others => duty_cycle <= 50_000;
         end case;
    end if;
end if;
end process boton2;


pwm_generator : process(clk100m)
variable cur : u20 := counter;
begin
    if (rising_edge(clk100m) and btn_in = '1') then
        cur := cur + 1;  
        counter <= cur;
        if (cur <= duty_cycle) then
            pwm_counter <= '1'; 
        elsif (cur > duty_cycle) then
            pwm_counter <= '0';
        elsif (cur = period) then
            cur := x"00000";
        end if;  
    end if;
end process pwm_generator;

pwm_out <= pwm_counter;

grados_un <= x"0" when (duty_cycle <= 50_000) else x"5" when (duty_cycle <= 100_000) 
else  x"0" when (duty_cycle <= 150_000) else  x"5" when (duty_cycle <= 200_000) 
else x"0" when (duty_cycle <= 250_000);

grados_dec <= x"0" when (duty_cycle <= 50_000) else x"4" when (duty_cycle <= 100_000) 
else  x"9" when (duty_cycle <= 150_000) else  x"3" when (duty_cycle <= 200_000) 
else x"8" when (duty_cycle <= 250_000);

grados_cen <= x"0" when (duty_cycle <= 50_000) else x"0" when (duty_cycle <= 100_000) 
else  x"0" when (duty_cycle <= 150_000) else  x"1" when (duty_cycle <= 200_000) 
else x"1" when (duty_cycle <= 250_000);

DisUn : decoder7 port map (Clk => clk100m, N1 => grados_un, S82 => d7s(7 downto 0));
DisDec : decoder7 port map (Clk => clk100m, N1 => grados_dec, S82 => d7s(15 downto 8));
DisCen : decoder7 port map (Clk => clk100m, N1 => grados_cen, S82 => d7s(23 downto 16));

DisplaySeg : seg7m port map (ck => clk100m, number => d7s, seg => seg7, an => an7);

end Behavioral;
