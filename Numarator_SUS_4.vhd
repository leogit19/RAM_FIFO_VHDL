----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 25.04.2025 10:59:09
-- Design Name: 
-- Module Name: Numarator_SUS_4 - Behavioral
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
--use work.bistabil_D.vhdl;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Numarator_SUS_4 is
Port (CE_OP: in std_logic;
RESET1:in std_logic;
CLK:in std_logic;
ADRESA_OP:out std_logic_vector(3 downto 0));
end Numarator_SUS_4;

architecture Behavioral of Numarator_SUS_4 is
signal D3,D2,D1,D0 : STD_LOGIC:='0';
SIGNAL Q3,Q2,Q1,Q0:STD_LOGIC;
begin
D0<= NOT Q0 WHEN CE_OP='1' else Q0;
D1 <= Q0 XOR Q1 WHEN CE_OP='1' else Q1;
D2<= (Q0 AND Q1) XOR Q2 WHEN CE_OP='1' else Q2;
D3 <=(Q0 AND Q1 AND Q2) XOR Q3 WHEN CE_OP='1' else Q3;
BISTD1: ENTITY work.bistabil_D(B_D)
port map(
D=> D0,
CLK=>CLK,
RST=>RESET1,
Q=>Q0);
BISTD2: ENTITY work.bistabil_D(B_D)
port map(
D=> D1,
CLK=>CLK,
RST=>RESET1,
Q=>Q1);
BISTD3: ENTITY work.bistabil_D(B_D)
port map(
D=> D2,
CLK=>CLK,
RST=>RESET1,
Q=>Q2);
BISTD4: ENTITY work.bistabil_D(B_D)
port map(
D=> D3,
CLK=>CLK,
RST=>RESET1,
Q=>Q3);
ADRESA_OP<= Q3 & Q2 & Q1 & Q0;
end Behavioral;
