----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 26.04.2025 17:43:10
-- Design Name: 
-- Module Name: afisor_7_sD - aff
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity afisor_7_sD is
port (clk: in std_logic;
an:out std_logic_vector(3 downto 0);
cat :out std_logic_vector(6 downto 0));
end afisor_7_sD;

architecture aff of afisor_7_sD is
signal clk1KHZ:std_logic;
begin
div1: entity  work.Divizor_frecventa port map(clk_100=>clk,clk_out=>clk1KHZ);
process(clk)

end process;
end aff;
