library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity NeuralNetwork is
    Port ( network_input  : in  STD_LOGIC_VECTOR(23 downto 0);
           network_output : out STD_LOGIC);
end NeuralNetwork;

architecture Behavioral of NeuralNetwork is
   
    signal layer1_outputs : STD_LOGIC_VECTOR(5 downto 0);
    signal layer2_outputs : STD_LOGIC_VECTOR(2 downto 0);

    component InputLayer
        Port ( inputs : in  STD_LOGIC_VECTOR(23 downto 0);
               outputs : out STD_LOGIC_VECTOR(5 downto 0));
    end component;

    component NeuronLayer 
        Port ( inputs : in  STD_LOGIC_VECTOR(23 downto 0);
               outputs : out STD_LOGIC_VECTOR(2 downto 0));
    end component;

    component SimpleNeuron 
        Port ( input1 : in  STD_LOGIC_VECTOR(7 downto 0); 
               input2 : in  STD_LOGIC_VECTOR(7 downto 0);
               input3 : in  STD_LOGIC_VECTOR(7 downto 0);
               output : out STD_LOGIC);
    end component;
     
  signal layer1_outputs_can : STD_LOGIC_VECTOR (23 downto 0); 
  
  signal layer2_outputs_input1 : STD_LOGIC_VECTOR (7 downto 0);
  signal layer2_outputs_input2 : STD_LOGIC_VECTOR (7 downto 0);
  signal layer2_outputs_input3 : STD_LOGIC_VECTOR (7 downto 0);   



begin
  
    
 -- layer1_outputs_can <=  "000000" & layer1_outputs(5) & layer1_outputs(4) &
 --                        "000000" & layer1_outputs(3) & layer1_outputs(2) &
 --                        "000000" & layer1_outputs(1) & layer1_outputs(0) ;    
 
    layer1_outputs_can <= (17 downto 0 => '0') & layer1_outputs(5 downto 0);

  
  layer2_outputs_input1 <=  "0000001" & layer2_outputs(0);
  layer2_outputs_input2 <=  "0000011" & layer2_outputs(1);
  layer2_outputs_input3 <=  "0000001" & layer2_outputs(2);
                                           
   
    -- Layer 1:
    layer1: InputLayer port map (
        inputs => network_input,
        outputs => layer1_outputs
    );
    
    -- Layer 2: 
    layer2: NeuronLayer port map (
        inputs => layer1_outputs_can, 
        outputs => layer2_outputs
    );

    -- Layer 3: Output SimpleNeuron
    output_layer: SimpleNeuron port map (
        input1 => layer2_outputs_input1,
        input2 => layer2_outputs_input2,
        input3 => layer2_outputs_input3,
        output => network_output
    );
end Behavioral;




