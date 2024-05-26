library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity NeuralNetwork_pipelined is
    Port ( 
        clk : in STD_LOGIC;
        reset : in STD_LOGIC;
        network_input  : in  STD_LOGIC_VECTOR(23 downto 0);
        network_output : out STD_LOGIC
    );
end NeuralNetwork_pipelined;

architecture Behavioral of NeuralNetwork_pipelined is

    signal layer1_outputs : STD_LOGIC_VECTOR(5 downto 0);
    signal layer2_outputs : STD_LOGIC_VECTOR(2 downto 0);

    component InputLayer
        Port ( 
            inputs : in  STD_LOGIC_VECTOR(23 downto 0);
            outputs : out STD_LOGIC_VECTOR(5 downto 0)
        );
    end component;

    component NeuronLayer 
        Port ( 
            inputs : in  STD_LOGIC_VECTOR(23 downto 0);
            outputs : out STD_LOGIC_VECTOR(2 downto 0)
        );
    end component;

    component SimpleNeuron 
        Port ( 
            input1 : in  STD_LOGIC_VECTOR(7 downto 0); 
            input2 : in  STD_LOGIC_VECTOR(7 downto 0);
            input3 : in  STD_LOGIC_VECTOR(7 downto 0);
            output : out STD_LOGIC
        );
    end component;
     
    signal layer1_outputs_can : STD_LOGIC_VECTOR (23 downto 0); 
    signal layer2_outputs_input1 : STD_LOGIC_VECTOR (7 downto 0);
    signal layer2_outputs_input2 : STD_LOGIC_VECTOR (7 downto 0);
    signal layer2_outputs_input3 : STD_LOGIC_VECTOR (7 downto 0);   

    signal layer1_ready : std_logic := '0';
    signal layer2_ready : std_logic := '0';
    signal network_output_reg : std_logic := '0' ;
    signal network_output_w : std_logic := '0';
    

begin
  
    -- Layer 1:
    layer1: InputLayer port map (
        inputs => network_input,
        outputs => layer1_outputs
    );

    -- Pipeline stage for Layer 1 output
    process (clk, reset)
    begin
        if reset = '1' then
            layer1_ready <= '0';
        elsif rising_edge(clk) then
            layer1_ready <= '1';
        end if;
    end process;

    -- Layer 2: 
    process (clk, reset)
    begin
        if reset = '1' then
            layer2_ready <= '0';
        elsif rising_edge(clk) then
            if layer1_ready = '1' then
                layer1_outputs_can <= (17 downto 0 => '0') & layer1_outputs(5 downto 0);
                layer2_ready <= '1'; -- Ready for Layer 2 calculation
            end if;
        end if;
    end process;

    layer2: NeuronLayer port map (
        inputs => layer1_outputs_can, 
        outputs => layer2_outputs
    );

    -- Pipeline stage for Layer 2 output
    process (clk, reset)
    begin
        if reset = '1' then
            layer2_outputs_input1 <= "00000000"; 
            layer2_outputs_input2 <= "00000000";
            layer2_outputs_input3 <= "00000000";
        elsif rising_edge(clk) then
            if layer2_ready = '1' then
                layer2_outputs_input1 <= "0000001" & layer2_outputs(0);
                layer2_outputs_input2 <= "0000011" & layer2_outputs(1);
                layer2_outputs_input3 <= "0000001" & layer2_outputs(2);
                end if;
        end if;
    end process;

    output_layer: SimpleNeuron port map (
        input1 => layer2_outputs_input1,
        input2 => layer2_outputs_input2,
        input3 => layer2_outputs_input3,
        output => network_output_w
    );
    
    process (clk, reset)
        begin
            if reset = '1' then
                network_output_reg <= '0'; -- Initialise network_output
            elsif rising_edge(clk) then
                if layer2_ready = '1' then
                    network_output_reg <= network_output_w;
                end if;
            end if;
    end process;
    
    
      process (clk, reset)
          begin
              if reset = '1' then
                  network_output <= '1'; 
              elsif rising_edge(clk) then
                  if network_output_reg = '1' then
                        network_output <= '1';
                  else
                   network_output <= '0';               
                  end if;
               end if;
       end process;                 
          
     
end Behavioral;
