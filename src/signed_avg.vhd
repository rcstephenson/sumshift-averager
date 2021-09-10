library ieee; 
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- TODO : CHANGED TO SIGNED

entity growing_avg_signed is 
    generic(         N : integer := 16;
                --N_AVGS : integer := 8;  -- Total Averages = 2^N_AVGS -1
             SUM_WIDTH : integer := 128  -- Upper limit for possible number of averages (= S_W^2 - N)
    );
    port(
        clk : in std_logic;
      valid : in std_logic;
          x : in std_logic_vector(N-1 downto 0);
  N_AVGS_in : in std_logic_vector(7 downto 0);
    new_dat : out std_logic;     
          y : out std_logic_vector(N-1 downto 0)
    );
end growing_avg_signed;

architecture behv of growing_avg_signed is 
    signal sum          : signed(SUM_WIDTH-1 downto 0) := (others=>'0'); 
    signal first_val    : signed(SUM_WIDTH-1 downto 0) := (others=>'0');
    signal adds         : unsigned(SUM_WIDTH-1 downto 0); -- number of additons performed
    signal avg_length   : integer;
begin 
    avg_length<=to_integer(unsigned(N_AVGS_in))
    acc : process(clk, valid, N_AVGS_in) --accumulation
    begin 
        if arst_n
        elsif rising_edge(clk) then  
            new_dat <='0'; 
            y <= (others => '0'); -- only output new data when new data is valid   
            if (valid='1') then
                if (adds < 2**(avg_length)-1) then -- continue accumulation until max average # is reached
                    sum <= sum + resize(signed(x),SUM_WIDTH); -- sum = sum + x
                    adds <= adds + 1;   
                else    
                    adds <= (others => '0'); -- (0 => '1', others =>'0')
                    sum <= resize(signed(x),SUM_WIDTH);
                    new_dat <= '1';
                    -- output --
                    y <= std_logic_vector(resize(shift_right(sum, avg_length),N));
                end if;
            end if;
        end if;   
    end process;
end behv;