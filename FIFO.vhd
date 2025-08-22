--Copyright 2025 Andrey S. Ionisyan (anserion@gmail.com)
--Licensed under the Apache License, Version 2.0 (the "License");
--you may not use this file except in compliance with the License.
--You may obtain a copy of the License at
--    http://www.apache.org/licenses/LICENSE-2.0
--Unless required by applicable law or agreed to in writing, software
--distributed under the License is distributed on an "AS IS" BASIS,
--WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
--See the License for the specific language governing permissions and
--limitations under the License.
------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL, IEEE.STD_LOGIC_ARITH.ALL, ieee.std_logic_unsigned.all;

entity FIFO is
  Generic (FIFO_SIZE: natural range 1 to 1024; DSIZE: natural range 1 to 64);
  Port (CLK, GET_CMD, PUT_CMD: in STD_LOGIC;
        DIN: in std_logic_vector(DSIZE-1 downto 0);
        DOUT: out std_logic_vector(DSIZE-1 downto 0);
        EMPTY,FULL: out std_logic);
end FIFO;

architecture Behavioral of FIFO is
type ram_type is array (FIFO_SIZE-1 downto 0) of std_logic_vector(DSIZE-1 downto 0);
signal RAM: ram_type;
signal cnt: natural range 0 to FIFO_SIZE := 0;
signal head_idx: natural range 0 to FIFO_SIZE-1 := 0;
signal tail_idx: natural range 0 to FIFO_SIZE-1 := FIFO_SIZE-1;
begin
  DOUT<=(others=>'0') when cnt=0 else RAM(head_idx);
  EMPTY<='1' when cnt=0 else '0'; FULL<='1' when cnt=FIFO_SIZE else '0';
  process (CLK)
  begin
     if rising_edge(CLK) then
       if GET_CMD='1' and cnt/=0 then --get
         if head_idx=FIFO_SIZE-1 then head_idx<=0; else head_idx<=head_idx+1; end if;
         cnt<=cnt-1;
       end if;
       if PUT_CMD='1' and cnt/=FIFO_SIZE then --put
         if tail_idx=FIFO_SIZE-1 then RAM(0)<=DIN; tail_idx<=0;
         else RAM(tail_idx+1)<=DIN; tail_idx<=tail_idx+1; end if;
         cnt<=cnt+1;
       end if;
     end if;
  end process;
end Behavioral;
