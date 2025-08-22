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
use IEEE.STD_LOGIC_1164.ALL, IEEE.STD_LOGIC_ARITH.ALL, IEEE.STD_LOGIC_UNSIGNED.ALL;

entity keys_supervisor is
   Generic (debounce: in natural range 0 to 1023);
   Port (clk,en: in std_logic; key1,key2,key3,key4,reset: in std_logic; 
         key_code: out std_logic_vector(3 downto 0); RDY: out std_logic);
end keys_supervisor;

architecture Behavorial of keys_supervisor is
signal key_code_reg: std_logic_vector(3 downto 0):="1111";
signal ready_reg: std_logic:='1';
begin
  key_code<=key_code_reg; RDY<=ready_reg;
  process(clk)
  variable fsm: natural range 0 to 7:= 0;
  variable cnt: natural range 0 to 1023:=0;
  begin
    if rising_edge(clk) and en='1' then
      case fsm is
      when 0 => if (key1='0')or(key2='0')or(key3='0')or(key4='0')or(reset='0') 
                then ready_reg<='0'; cnt:=0; fsm:=1; end if;
      when 1 => if cnt=debounce then fsm:=2; else cnt:=cnt+1; end if;
      when 2 => if key1='0' then key_code_reg<="0001"; end if;
                if key2='0' then key_code_reg<="0010"; end if;
                if key3='0' then key_code_reg<="0011"; end if;
                if key4='0' then key_code_reg<="0100"; end if;
                if reset='0' then key_code_reg<="0111"; end if;
                fsm:=3;
      when 3 => if (key1='1')and(key2='1')and(key3='1')and(key4='1')and(reset='1')
                then cnt:=0; fsm:=4;
                end if;
      when 4 => if cnt=debounce then ready_reg<='1'; fsm:=0; else cnt:=cnt+1; end if;
      when others => null;
      end case;
    end if;
  end process;
end;
