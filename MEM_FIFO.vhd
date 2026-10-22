----------------------------------------------------------------------------------
-- Memorie FIFO cu debouncer ,divizor de frecventa si afisaj pe 7SD 
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity FIFO_Controller is
    Port (
        clk_100MHz : in  STD_LOGIC;
        reset      : in  STD_LOGIC;
        btn_write  : in  STD_LOGIC;   -- Physical button (active-low)
        btn_read   : in  STD_LOGIC;   -- Physical button (active-low)
        OK1        : in  STD_LOGIC;   -- Physical button (active-low)
        data_in    : in  STD_LOGIC_VECTOR(15 downto 0);
        --data_out   : out STD_LOGIC_VECTOR(15 downto 0);
        an         : out STD_LOGIC_VECTOR(3 downto 0);
        cat        : out STD_LOGIC_VECTOR(6 downto 0);
        empty: out std_logic ;
        full: out  std_logic;
        last :out std_logic
    );
end FIFO_Controller;

architecture Behavioral of FIFO_Controller is
    component Debouncer is
        generic (DEBOUNCE_MS : integer := 5);
        port (
            clk      : in  STD_LOGIC;
            buton    : in  STD_LOGIC;
            rezultat : out STD_LOGIC
        );
    end component;
component MPG is
Port (btn : in STD_LOGIC;
           clk : in STD_LOGIC;
           en : out STD_LOGIC );
end component;
    component Numarator_SUS_JOS_4 is
        Port (
            CE_WR : in  STD_LOGIC;
            CE_RD : in  STD_LOGIC;
            CLK   : in  STD_LOGIC;
            RESET : in  STD_LOGIC;
            Q     : out STD_LOGIC_VECTOR(3 downto 0)
        );
    end component;

    component ram is
        port (
            CE_WR   : in  STD_LOGIC;
            CLK     : in  STD_LOGIC;
            Val     : in  STD_LOGIC_VECTOR(15 downto 0);
            Adresa  : in  STD_LOGIC_VECTOR(3 downto 0);
            Val_out : out STD_LOGIC_VECTOR(15 downto 0)
        );
    end component;

    component bistabil_D is
        Port (
            D   : in  STD_LOGIC;
            CLK : in  STD_LOGIC;
            RST : in  STD_LOGIC;
            Q   : out STD_LOGIC
        );
    end component;

    -- Internal Signals
    type memorie is array (0 to 15) of std_logic_vector(15 downto 0);
    signal matrice:memorie:=(others=>(others=>'0'));
    signal btn_write_db, btn_read_db, ok_db : STD_LOGIC;
    signal  data_latched : STD_LOGIC_VECTOR(15 downto 0);
    signal write_ptr, read_ptr, ram_address : STD_LOGIC_VECTOR(3 downto 0);
    signal ram_data_out : STD_LOGIC_VECTOR(15 downto 0);
    signal fifo_count : integer range 0 to 15 := 0;
    signal write_enable, read_enable : STD_LOGIC;
    signal part1,part2,part3,part4:std_logic_vector(3 downto 0);
    signal data_out: STD_LOGIC_VECTOR(15 downto 0);
    signal   digit:std_logic_vector(3 downto 0);
    signal decision:std_logic_vector(1 downto 0); 
   signal counter1 : STD_LOGIC_VECTOR(17 downto 0):="000000000000000000";
   signal empty_internal : std_logic;
   signal full_internal  : std_logic;
   signal last_internal  : std_logic;
    signal valoare: std_logic_vector(15 downto 0):=(others=>'0');
signal valoare_displayed : std_logic_vector(15 downto 0);
  begin
   
process(clk_100Mhz)
begin
if rising_edge(clk_100Mhz) then
counter1<=std_logic_vector(unsigned(counter1)+1);--divizor de frecventa
decision<=std_logic_vector(counter1(10 downto 9));--divizor de frecventa
end if;
    end process;
    
  
    debounce_write: MPG
        port map(clk=>clk_100Mhz,   btn=> btn_write, en=>btn_write_db); 
 
    debounce_read: MPG
        port map(clk=>clk_100Mhz, btn=> btn_read,en=> btn_read_db);   
    debounce_ok: MPG
        port map(clk=>clk_100Mhz, btn=> OK1,en=> ok_db);             


  
   data_latched<=data_in;
  write_enable <= btn_write_db and not full_internal;
  read_enable  <= btn_read_db and not empty_internal;
    wr_counter: Numarator_SUS_JOS_4
        port map(CE_WR => write_enable, CE_RD => '0', 
                CLK => clk_100MHz, RESET => reset, Q => write_ptr);

    rd_counter: Numarator_SUS_JOS_4
        port map(CE_WR => read_enable, CE_RD =>'0' , 
                CLK => clk_100MHz, RESET => reset, Q => read_ptr);

    ram_address <= write_ptr when write_enable = '1' else read_ptr;

 

    -- FIFO RAM
    fifo_status: process(clk_100MHz)
     variable valo1:std_logic_vector(15 downto 0):=(others=>'0');
  variable fifo_count1:integer range 0 to 16;
    begin
        if rising_edge(clk_100MHz) then
            if reset = '1' then
                fifo_count <= 0;
              
                data_out<=x"0000";
                valoare<=(others=>'0');
                for i in 0 to 15 loop
                matrice(i) <= (others => '0'); 
            end loop;
            
               
        else
        fifo_count1:=fifo_count;
        valo1:=valoare;
  if  write_enable = '1' and full_internal='0' and fifo_count1 <15 then
      matrice(to_integer(unsigned(write_ptr))) <= data_in;
      fifo_count1:= fifo_count +1;
      valo1:=data_in;
    end if;
               if read_enable = '1' and empty_internal='0' and fifo_count1>0 then
   -- data_out <= matrice(to_integer(unsigned(read_ptr)));
    valo1:= matrice(to_integer(unsigned(read_ptr)));
    matrice(to_integer(unsigned(read_ptr)))<=(others =>'0');
      fifo_count1:= fifo_count1 -1;
end if;
fifo_count<=fifo_count1;
valoare<=valo1;
            end if;
        end if;
    end process;

 valoare_displayed <= data_in when OK1='1' else valoare;
    
   full_internal  <= '1' when fifo_count = 15 else '0';
    last_internal  <= '1' when fifo_count = 14    else '0';
   empty_internal <= '1' when fifo_count = 0 else '0';
   full<=full_internal;
   empty<=empty_internal;
   last<=last_internal;
 
  --  part1<=valoare(3 downto 0);
  --part2<=valoare(7 downto 4);
  --part3<=valoare(11 downto 8);
 -- part4<=valoare(15 downto 12);
part1<=valoare_displayed(3 downto 0);
part2<=valoare_displayed(7 downto 4);
part3<=valoare_displayed(11 downto 8);
part4<=valoare_displayed(15 downto 12);
  process(clk_100MHz)
begin
if rising_edge(clk_100MHz) then
    case decision is
        when "00" =>
            digit <= part1;
            an <= "1110";
        when "01" => 
            digit <= part2;
            an <= "1101";
        when "10" =>
            digit <= part3;
            an <= "1011";
        when others =>
            digit <= part4;
            an <= "0111";
    end case;
    end if;
end process;
  
  process(digit)
  begin
  case  digit is
   when "0000" => cat <= "1000000"; -- 0
        when "0001" => cat <= "1111001"; -- 1
        when "0010" => cat <= "0100100"; -- 2
        when "0011" => cat <= "0110000"; -- 3
        when "0100" => cat <= "0011001"; -- 4
        when "0101" => cat <= "0010010"; -- 5
        when "0110" => cat <= "0000010"; -- 6
        when "0111" => cat <= "1111000"; -- 7
        when "1000" => cat <= "0000000"; -- 8
        when "1001" => cat <= "0010000"; -- 9
        when "1010" => cat <= "0001000"; -- A
        when "1011" => cat <= "0000011"; -- b
        when "1100" => cat <= "1000110"; -- C
        when "1101" => cat <= "0100001"; -- d
        when "1110" => cat <= "0000110"; -- E
        when "1111" => cat <= "0001110"; -- F
        when others => cat <= "1111111";-- dezactivat
        end case;
  end process;
end Behavioral;


