library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity NeuronTestbench is
-- Testbench has no ports.
end NeuronTestbench;

architecture behavior of NeuronTestbench is
    component SimpleNeuron
        Port ( input1 : in  STD_LOGIC_VECTOR(7 downto 0);
               input2 : in  STD_LOGIC_VECTOR(7 downto 0);
               input3 : in  STD_LOGIC_VECTOR(7 downto 0);
               output : out STD_LOGIC);
    end component;

    -- Inputs
    signal input1 : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
    signal input2 : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
    signal input3 : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');

    -- Output
    signal output : STD_LOGIC;

begin
    uut: SimpleNeuron
        Port map (input1 => input1,
                  input2 => input2,
                  input3 => input3,
                  output => output);

    stimulus: process
    begin
	input1 <= std_logic_vector(to_signed(1, 8));
	input2 <= std_logic_vector(to_signed(2, 8));
	input3 <= std_logic_vector(to_signed(3, 8));
	
	wait for 50 ns;

	input1 <= std_logic_vector(to_signed(4, 8));
	input2 <= std_logic_vector(to_signed(5, 8));
	input3 <= std_logic_vector(to_signed(6, 8));
	wait for 50 ns;


        wait;
    end process;
end behavior;
