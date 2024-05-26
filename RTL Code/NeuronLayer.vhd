library IEEE;                       
use IEEE.STD_LOGIC_1164.ALL;        


entity NeuronLayer is
    Port ( inputs : in  STD_LOGIC_VECTOR(23 downto 0); 
           outputs : out STD_LOGIC_VECTOR(2 downto 0));
end NeuronLayer;

architecture Behavioral of NeuronLayer is
    component SimpleNeuron
        Port ( input1 : in  STD_LOGIC_VECTOR(7 downto 0);
               input2 : in  STD_LOGIC_VECTOR(7 downto 0);
               input3 : in  STD_LOGIC_VECTOR(7 downto 0);
               output : out STD_LOGIC);
    end component;
begin
    neuron1: SimpleNeuron
        Port map (input1 => inputs(23 downto 16), 
                  input2 => inputs(15 downto 8), 
                  input3 => inputs(7 downto 0),   
                  output => outputs(0));

    neuron2: SimpleNeuron
        Port map (input1 => inputs(15 downto 8),  
                  input2 => inputs(7 downto 0),   
                  input3 => inputs(23 downto 16), 
                  output => outputs(1));

    neuron3: SimpleNeuron
        Port map (input1 => inputs(7 downto 0),   
                  input2 => inputs(23 downto 16), 
                  input3 => inputs(15 downto 8),  
                  output => outputs(2));
end Behavioral;
