library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL; 

entity NeuronLayerTestbench is
-- Testbench has no ports.
end NeuronLayerTestbench;

architecture behavior of NeuronLayerTestbench is
    
    signal inputs : STD_LOGIC_VECTOR(23 downto 0) := (others => '0');
    signal outputs : STD_LOGIC_VECTOR(2 downto 0);

  
    component NeuronLayer
        Port ( inputs : in  STD_LOGIC_VECTOR(23 downto 0);
               outputs : out STD_LOGIC_VECTOR(2 downto 0));
    end component;

begin
    uut: NeuronLayer
        port map (inputs => inputs,
                  outputs => outputs);

    stimulus: process
    begin
        inputs <= X"000000"; 
        wait for 100 ns;

       
        inputs <= X"FFFFFF"; 
        wait for 100 ns;

        inputs <= X"040506"; 
        wait for 100 ns;
                
        inputs <= X"A5A505"; 
        wait for 100 ns;
        
        inputs <= X"050306"; 
        wait for 100 ns;
        
        inputs <= X"A5A505"; 
        wait for 100 ns;
        
        wait;
    end process;
end behavior;
