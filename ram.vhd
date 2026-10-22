library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ram is
    port (
        CE_WR   : in std_logic;
        CLK     : in std_logic;
        Val     : in std_logic_vector(15 downto 0);
        Adresa  : in std_logic_vector(3 downto 0);
        Val_out : out std_logic_vector(15 downto 0)
    );
end ram;

architecture Beta of ram is
    type memorie is array (0 to 15) of std_logic_vector(15 downto 0);
    signal Valoare : memorie := (others => (others => '0'));
begin
    process(CLK)
    begin
        if rising_edge(CLK) then

            if CE_WR = '1' then
                Valoare(to_integer(unsigned(Adresa))) <= Val;
            end if;
        end if;
    end process;

    --pentru citirea datelor si afisarea lor ulterioara 
    Val_out <= Valoare(to_integer(unsigned(Adresa)));
end Beta;