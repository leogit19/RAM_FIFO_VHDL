----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 25.04.2025 11:01:27
-- Design Name: 
-- Module Name: Debouncer - DEBO
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Debouncer is
generic (
CLK_FREQ :integer := 100_000_000;-- frecv ceasului
DEBOUNCE_MS : integer := 5 --5 ms perioada pentru debounce
);
port(
clk:in std_logic;
buton:in std_logic;
rezultat: out std_logic);

end Debouncer;

architecture DEBO of Debouncer is
constant TIMP_MAX : integer :=(CLK_FREQ /1000) * DEBOUNCE_MS;
signal timp : integer range 0 to TIMP_MAX :=0;
signal button_sync :std_logic_vector( 1 downto 0):="00";
signal iesire : std_logic:='0';
begin
process(clk)
begin
    if rising_edge(clk) then
    button_sync<= button_sync(0) & buton;

    if button_sync(1) /= iesire then
    if timp <TIMP_MAX then 
    timp <= timp +1;
    else
    iesire<= button_sync(1);
    timp<=0;
    end if;
    else
    timp <= 0;
    end if;
    end if;
    end process;
    rezultat<= iesire;
end DEBO;
