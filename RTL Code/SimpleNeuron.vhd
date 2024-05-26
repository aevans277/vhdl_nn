library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL; 

entity SimpleNeuron is
    Port ( input1 : in  STD_LOGIC_VECTOR(7 downto 0); 
           input2 : in  STD_LOGIC_VECTOR(7 downto 0); 
           input3 : in  STD_LOGIC_VECTOR(7 downto 0); 
           output : out STD_LOGIC); 
end SimpleNeuron;

architecture Behavioral of SimpleNeuron is
    constant weight1 : integer := 1;
    constant weight2 : integer := 2;
    constant weight3 : integer := 3;
    constant threshold : integer := 20;
begin
    process(input1, input2, input3)
        variable weighted_sum : integer;
    begin
        weighted_sum := to_integer(signed(input1)) * weight1 +
                        to_integer(signed(input2)) * weight2 +
                        to_integer(signed(input3)) * weight3;
                        
        if weighted_sum > threshold then
            output <= '1'; 
        else
            output <= '0'; 
        end if;
    end process;
end Behavioral;
