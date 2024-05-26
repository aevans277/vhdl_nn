library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity SigmoidNeuron_TB is
end SigmoidNeuron_TB;

architecture TB_arch of SigmoidNeuron_TB is
    constant CLK_PERIOD : time := 10 ns;

    signal clk : STD_LOGIC := '0';
    signal input1, input2, input3 : STD_LOGIC := '0';
    signal output : STD_LOGIC;

signal stop_simulation : boolean := false;

    component SigmoidNeuron
        Port (
            clk    : in STD_LOGIC;
            input1 : in STD_LOGIC;
            input2 : in STD_LOGIC;
            input3 : in STD_LOGIC;
            output : out STD_LOGIC
        );
    end component;
    
begin

    
        UUT : SigmoidNeuron
            port map (
                clk => clk,
                input1 => input1,
                input2 => input2,
                input3 => input3,
                output => output
            );


    process
    begin
        while not stop_simulation loop
            clk <= '0'; wait for CLK_PERIOD / 2;
            clk <= '1'; wait for CLK_PERIOD / 2;
        end loop;
        wait;
    end process;

    process
    begin
        wait for 50 ns;
        input1 <= '1'; input2 <= '0'; input3 <= '0';  -- Output is '0'
        wait for 50 ns;
        input1 <= '0'; input2 <= '1'; input3 <= '0';  -- Output is '1'
        wait for 50 ns;
        input1 <= '0'; input2 <= '0'; input3 <= '1';  -- Output is '1'
        wait for 50 ns;
        input1 <= '1'; input2 <= '1'; input3 <= '1';  -- Output is '1'
        wait for 50 ns;
        input1 <= '0'; input2 <= '0'; input3 <= '0';  -- Output is '0'
        wait for 50 ns;
        input1 <= '1'; input2 <= '0'; input3 <= '1';  -- Output is '1'
        wait for 50 ns;
        input1 <= '0'; input2 <= '1'; input3 <= '1';  -- Output is '1'
        wait for 50 ns;
        input1 <= '1'; input2 <= '1'; input3 <= '0';  -- Output is '0'
        wait for 50 ns;
        input1 <= '1'; input2 <= '0'; input3 <= '1';  -- Output is '1'
        wait for 50 ns;
        input1 <= '1'; input2 <= '1'; input3 <= '1';  -- Output is '1'
        wait for 50 ns;
        input1 <= '0'; input2 <= '1'; input3 <= '1';  -- Output is '0'
        wait for 50 ns;
        input1 <= '1'; input2 <= '0'; input3 <= '1';  -- Output is '0'
        wait for 50 ns;
        input1 <= '0'; input2 <= '0'; input3 <= '1';  -- Output is '1'
        wait for 50 ns;
        input1 <= '1'; input2 <= '1'; input3 <= '0';  -- Output is '0'
        
        
        stop_simulation <= true; -- Stop simulation
        wait;
        
    end process;
end TB_arch;
