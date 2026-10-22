library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Numarator_SUS_JOS_4 is
    Port(
        CE_WR    : in std_logic;
        CE_RD    : in std_logic;
        CLK      : in std_logic;
        RESET   : in std_logic;
        Q : out std_logic_vector(3 downto 0)
    );
end Numarator_SUS_JOS_4;

architecture NUM_S_J of Numarator_SUS_JOS_4 is
    signal counter : unsigned(3 downto 0) := "0000";
begin
    process(CLK, RESET)
    begin
        if RESET = '1' then
            counter <= "0000";
        elsif rising_edge(CLK) then
            if CE_WR = '1' then
                counter <= counter + 1;  -- Count up
            elsif CE_RD = '1' then
                counter <= counter - 1;  -- Count down
            end if;
        end if;
    end process;

    Q <= std_logic_vector(counter);
end NUM_S_J;