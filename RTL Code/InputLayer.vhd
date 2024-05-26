library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity InputLayer is
    Port ( inputs : in  STD_LOGIC_VECTOR(23 downto 0);
           outputs : out STD_LOGIC_VECTOR(5 downto 0)); 
end InputLayer;

architecture Behavioral of InputLayer is
    component SimpleNeuron
        Port ( input1 : in  STD_LOGIC_VECTOR(7 downto 0);
               input2 : in  STD_LOGIC_VECTOR(7 downto 0);
               input3 : in  STD_LOGIC_VECTOR(7 downto 0);
               output : out STD_LOGIC);
    end component;
begin
    -- Instantiate 6 neurons 
    -- For demonstration, we're mapping inputs in a simple pattern, reusing inputs across neurons
    neuron1: SimpleNeuron Port map (input1 => inputs(23 downto 16), input2 => inputs(15 downto 8), input3 => inputs(7 downto 0), output => outputs(0));
    neuron2: SimpleNeuron Port map (input1 => inputs(15 downto 8), input2 => inputs(7 downto 0), input3 => inputs(23 downto 16), output => outputs(1));
    neuron3: SimpleNeuron Port map (input1 => inputs(7 downto 0), input2 => inputs(23 downto 16), input3 => inputs(15 downto 8), output => outputs(2));
    -- Repeating the pattern for neurons 4 to 6
    neuron4: SimpleNeuron Port map (input1 => inputs(23 downto 16), input2 => inputs(15 downto 8), input3 => inputs(7 downto 0), output => outputs(3));
    neuron5: SimpleNeuron Port map (input1 => inputs(15 downto 8), input2 => inputs(7 downto 0), input3 => inputs(23 downto 16), output => outputs(4));
    neuron6: SimpleNeuron Port map (input1 => inputs(7 downto 0), input2 => inputs(23 downto 16), input3 => inputs(15 downto 8), output => outputs(5));
end Behavioral;
