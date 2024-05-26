library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity NeuralNetworkTestbench is
end NeuralNetworkTestbench;

architecture behavior of NeuralNetworkTestbench is
    
    component NeuralNetwork
        Port ( network_input  : in  STD_LOGIC_VECTOR(23 downto 0);
               network_output : out STD_LOGIC);
    end component;
    
    signal network_input  : STD_LOGIC_VECTOR(23 downto 0) := (others => '0');
    signal network_output : STD_LOGIC;

begin
    
    uut: NeuralNetwork port map (
        network_input  => network_input,
        network_output => network_output
    );
    
   
    stimulus_process: process
    begin
    
        network_input <= X"000000"; 
        wait for 200 ns;
        
        network_input <= X"1FFFFF"; 
        wait for 200 ns;

        network_input <= X"040506"; 
        wait for 200 ns;
                
        network_input <= X"A5A505"; 
        wait for 200 ns;
        
        network_input <= X"050306"; 
        wait for 200 ns;
        
        network_input <= X"A5A505"; 
        wait for 200 ns;
        wait;
    end process;
end behavior;
