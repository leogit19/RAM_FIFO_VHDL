----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 25.04.2025 10:58:24
-- Design Name: 
-- Module Name: bistabil_D - B_D
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

entity bistabil_D is
Port ( D:in std_logic;
CLK: in std_logic;
RST :in std_logic;
Q:out std_logic);
end bistabil_D;

architecture B_D of bistabil_D is
signal D1: std_logic:='0';
--signal clk_div: std_logic;
--signal counter :integer :=1;
--constant NUM2 :integer :=50_000_000;
--signal ceas: std_logic:='0';
signal Q_pro:std_logic:='0';
--variable NUM1: integer:=0;
begin
    process(CLK,RST)
begin
    if RST ='1' then
    Q_pro<='0' ;elsif
     rising_edge(CLK) then -- mai am de lucru la partea asta
    Q_pro<=D;
    end if;
end process;
Q<=Q_pro;
end B_D;
