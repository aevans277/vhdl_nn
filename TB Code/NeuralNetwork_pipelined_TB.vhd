library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity NeuralNetwork_pipelined_TB is
-- Testbench has no ports.
end NeuralNetwork_pipelined_TB;

architecture behavior of NeuralNetwork_pipelined_TB is
    constant CLK_PERIOD : time := 10 ns;
    component NeuralNetwork_pipelined
        Port ( 
            clk : in STD_LOGIC;
            reset : in STD_LOGIC;
            network_input  : in  STD_LOGIC_VECTOR(23 downto 0);
            network_output : out STD_LOGIC
        );
    end component;
    
    signal clk : STD_LOGIC := '0';
    signal reset : STD_LOGIC := '0';
    signal network_input  : STD_LOGIC_VECTOR(23 downto 0) := (others => '0');
    signal network_output : STD_LOGIC;

    signal stop_simulation : boolean := false;
    
begin
 
    uut: NeuralNetwork_pipelined port map (
        clk            => clk,
        reset          => reset,
        network_input  => network_input,
        network_output => network_output
    );
    
    clock_process: process
    begin
        while not stop_simulation loop
            clk <= '0';
            wait for CLK_PERIOD / 2;
            clk <= '1';
            wait for CLK_PERIOD / 2;
        end loop;
        wait;
    end process clock_process;
    
    stimulus_process: process
    begin
        reset <= '1';
        wait for CLK_PERIOD / 2; -- Align reset with clock edge
        reset <= '0';
        wait for CLK_PERIOD; -- Wait for one clock cycle after reset

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
        
        stop_simulation <= true; 
        wait;
    end process stimulus_process;

end behavior;
