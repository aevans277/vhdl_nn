library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity PositiveLinearActivationNeuron is
    Port (
        input1 : in STD_LOGIC_VECTOR(7 downto 0); 
        input2 : in STD_LOGIC_VECTOR(7 downto 0);
        input3 : in STD_LOGIC_VECTOR(7 downto 0);
        clock : in STD_LOGIC;
        reset : in STD_LOGIC;
        output : out STD_LOGIC
    );
end PositiveLinearActivationNeuron;

architecture Behavioral of PositiveLinearActivationNeuron is
    constant weight1 : integer := -10; 
    constant weight2 : integer := -5; 
    constant weight3 : integer := 30; 
    constant slope : real := 0.5; 
    signal weighted_sum : integer := 0; 
    signal linear_output : real := 0.0; 
begin
    process (clock, reset)
        variable temp_sum : integer;
    begin
        if reset = '1' then
            weighted_sum <= 0; 
        elsif rising_edge(clock) then
            temp_sum := to_integer(signed(input1)) * weight1 +
                        to_integer(signed(input2)) * weight2 +
                        to_integer(signed(input3)) * weight3;
            weighted_sum <= temp_sum;
            
            linear_output <= real(temp_sum) * slope;
                      
           
            if linear_output > 0.0 then
                            output <= '1';
                        else
                            output <= '0';
                        end if;
                        
        end if;
    end process;
end Behavioral;
