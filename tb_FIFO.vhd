LIBRARY ieee; USE ieee.std_logic_1164.ALL;
 
ENTITY tb_FIFO IS
END tb_FIFO;
 
ARCHITECTURE behavior OF tb_FIFO IS 
    COMPONENT FIFO_top
    Port (SYS_CLK,KEY1,KEY2,KEY3,KEY4,RESET: in STD_LOGIC;
          LED1,LED2,LED3,LED4: out STD_LOGIC;
          SMG_DATA : out  STD_LOGIC_VECTOR (7 downto 0);
          SCAN_SIG : out  STD_LOGIC_VECTOR (5 downto 0));
    END COMPONENT;
   --Inputs
   signal SYS_CLK : std_logic := '0';
   signal KEY1,KEY2,KEY3,KEY4,RESET : std_logic := '1';
 	--Outputs
   signal LED1,LED2,LED3,LED4 : std_logic;
   signal SMG_DATA : std_logic_vector(7 downto 0);
   signal SCAN_SIG : std_logic_vector(5 downto 0);
   -- Clock period definitions
   constant SYS_CLK_period : time := 20 ns;
   -- others
   signal clk_cnt: natural:=0;
BEGIN
   uut: FIFO_top PORT MAP (SYS_CLK,KEY1,KEY2,KEY3,KEY4,RESET,LED1,LED2,LED3,LED4,SMG_DATA,SCAN_SIG);
   -- Clock process definitions
   SYS_CLK_process :process
   begin
		SYS_CLK <= '0';
		wait for SYS_CLK_period/2;
		SYS_CLK <= '1';
		wait for SYS_CLK_period/2;
      clk_cnt<=clk_cnt+1;
   end process;
   -- Stimulus process
   stim_proc: process
   begin		
      wait for SYS_CLK_period;
      if clk_cnt=100000 then key2<='0'; end if;
      if clk_cnt=500000 then key2<='1'; end if;
      if clk_cnt=1000000 then key3<='0'; end if;
      if clk_cnt=1500000 then key3<='1'; end if;
      if clk_cnt=2000000 then key1<='0'; end if;
      if clk_cnt=2500000 then key1<='1'; end if;
      if clk_cnt=3000000 then RESET<='0'; end if;
      if clk_cnt=3500000 then RESET<='1'; end if;
      if clk_cnt=5000000 then wait; end if;
   end process;
END;