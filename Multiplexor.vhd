----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 25.04.2025 20:45:32
-- Design Name: 
-- Module Name: Multiplexor - MUXlB
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

entity Multiplexor is
port ( WR_OP1:in std_logic;
ADR_SC:in std_logic_vector(3 downto 0);
ADR_CIT:in std_logic_vector(3 downto 0);
ADR_OUT:out std_logic_vector(3 downto 0));
end Multiplexor;

architecture MUXlB of Multiplexor is

begin
ADR_OUT<= ADR_SC when WR_OP1='1' else
ADR_CIT;
end MUXlB;
