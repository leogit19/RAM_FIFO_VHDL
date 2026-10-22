----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 25.04.2025 20:57:33
-- Design Name: 
-- Module Name: Divizor_frecventa - FRECUENCY
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

entity Divizor_frecventa is
port (clk_100:in std_logic;
clk_out:out std_logic);
end Divizor_frecventa;

architecture FRECUENCY of Divizor_frecventa is
signal numarator: integer:=0;
constant Freq :integer :=50000;-- acest divizor de frecventa face ca iesirea sa fie de 1Khz 50% duty cycle
signal ceas:std_logic:='0';
begin
process(clk_100)
begin
if rising_edge(clk_100) then
    if numarator = Freq -1 then
    ceas<= not ceas;
    numarator <= 0;
    else
    numarator<= numarator +1;
    end if;
  end if;  
end process;
clk_out<=ceas;
end FRECUENCY;
