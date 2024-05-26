library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity PositiveLinearActivationNeuron_TB is
end PositiveLinearActivationNeuron_TB;

architecture Behavioral of PositiveLinearActivationNeuron_TB is
    -- Constants for testbench
    constant CLK_PERIOD : time := 10 ns;
    
    -- Signals for the DUT (Design Under Test)
    signal input1 : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
    signal input2 : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
    signal input3 : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
    signal clock : STD_LOGIC := '0';
    signal reset : STD_LOGIC := '0';
    signal output : STD_LOGIC;
    
    -- Instantiate the DUT
    component PositiveLinearActivationNeuron
        Port (
            input1 : in STD_LOGIC_VECTOR(7 downto 0);
            input2 : in STD_LOGIC_VECTOR(7 downto 0);
            input3 : in STD_LOGIC_VECTOR(7 downto 0);
            clock : in STD_LOGIC;
            reset : in STD_LOGIC;
            output : out STD_LOGIC
        );
    end component;
    
    signal stop_simulation : boolean := false;

begin
    DUT: PositiveLinearActivationNeuron
        port map (
            input1 => input1,
            input2 => input2,
            input3 => input3,
            clock => clock,
            reset => reset,
            output => output
        );
    

    clock_process: process
    begin
        while not stop_simulation loop
            clock <= '0';
            wait for CLK_PERIOD / 2;
            clock <= '1';
            wait for CLK_PERIOD / 2;
        end loop;
        wait;
    end process clock_process;
    

    stimulus_process: process
    begin
        reset <= '1';
        wait for 50 ns;
        reset <= '0';
        
        input1 <= "00000001";  --1
        input2 <= "00000010";       --2
        input3 <= "00000011";  --       3
        wait for 100 ns; 

        input1 <= "00000001"; -- 1
        input2 <= "11111110"; -- -2
        input3 <= "00000011"; -- 3
        wait for 100 ns; 
        
        input1 <= "11111111";  -- -1
        input2 <= "11111110";   -- -2
        input3 <= "11111101"; 
        wait for 100 ns; 
        
        input1 <= "00000000"; 
        input2 <= "00000000"; 
        input3 <= "00000000"; 
        wait for 100 ns; 
        
        -- Test Case 5: Large positive inputs (127, 127, 127)
        input1 <= "01111111"; 
        input2 <= "01111111"; 
        input3 <= "01111111";  --127
        wait for 100 ns; 

        stop_simulation <= true; 
        wait;
    end process stimulus_process;

end Behavioral;
