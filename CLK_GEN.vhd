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

entity CLK_GEN is
  Generic (TICKS_PER_SIGNAL: natural);
  Port (CLK_IN,EN,RESET: in STD_LOGIC; CLK_OUT : out  STD_LOGIC);
end CLK_GEN;

architecture Behavioral of CLK_GEN is
signal reg_out: std_logic:='0';
begin
   CLK_OUT<=reg_out and EN;
   process(CLK_IN)
   variable cnt: natural;
   begin
      if rising_edge(CLK_IN) then
         cnt:=cnt+1;
         if RESET='1' then reg_out<='0'; cnt:=0; end if;
         if (reg_out='0') and (cnt=TICKS_PER_SIGNAL/2) then reg_out<='1'; cnt:=0; end if;
         if (reg_out='1') and (cnt=TICKS_PER_SIGNAL/2) then reg_out<='0'; cnt:=0; end if;
      end if;
   end process;
end Behavioral;
