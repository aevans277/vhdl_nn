library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity SigmoidNeuron is
    Port ( 
        clk    : in STD_LOGIC;
        input1 : in STD_LOGIC;
        input2 : in STD_LOGIC;
        input3 : in STD_LOGIC;
        output : out STD_LOGIC
    );
end SigmoidNeuron;



architecture Behavioral of SigmoidNeuron is
    constant weight1 : INTEGER := -10;
    constant weight2 : INTEGER := -5;
    constant weight3 : INTEGER := 30;
    
    signal weighted_sum : INTEGER range -63 to 63 := 0;
    signal input1_vector, input2_vector, input3_vector : STD_LOGIC_VECTOR(2 downto 0); 

    type lut_type is array (-63 to 63) of REAL;

constant LUT : lut_type := (

        0.0, 0.3425, 0.345, 0.3475, 0.35, 0.3525, 0.355, 0.3575,
        0.36, 0.3625, 0.365, 0.3675, 0.37, 0.3725, 0.375, 0.3775,
        0.38, 0.3825, 0.385, 0.3875, 0.39, 0.3925, 0.395, 0.3975,
        0.4, 0.4025, 0.405, 0.4075, 0.41, 0.4125, 0.415, 0.4175,
        0.42, 0.4225, 0.425, 0.4275, 0.43, 0.4325, 0.435, 0.4375,
        0.44, 0.4425, 0.445, 0.4475, 0.45, 0.4525, 0.455, 0.4575,
        0.46, 0.4625, 0.465, 0.4675, 0.47, 0.4725, 0.475, 0.4775,
        0.48, 0.4825, 0.485, 0.4875, 0.49, 0.4925, 0.495, 0.4975,
        0.5, 0.5025, 0.505, 0.5075, 0.51, 0.5125, 0.515, 0.5175,
        0.52, 0.5225, 0.525, 0.5275, 0.53, 0.5325, 0.535, 0.5375,
        0.54, 0.5425, 0.545, 0.5475, 0.55, 0.5525, 0.555, 0.5575,
        0.56, 0.5625, 0.565, 0.5675, 0.57, 0.5725, 0.575, 0.5775,
        0.58, 0.5825, 0.585, 0.5875, 0.59, 0.5925, 0.595, 0.5975,
        0.6, 0.6025, 0.605, 0.6075, 0.61, 0.6125, 0.615, 0.6175,
        0.62, 0.6225, 0.625, 0.6275, 0.63, 0.6325, 0.635, 0.6375,
        0.64, 0.6425, 0.645, 0.6475, 0.65, 0.6525, 0.655
     
    );


begin
    process(clk)
    begin
        if rising_edge(clk) then
          
            input1_vector <= "00" & input1;
            input2_vector <= "00" & input2;
            input3_vector <= "00" & input3;

            weighted_sum <= to_integer(unsigned(input1_vector)) * weight1 +
                            to_integer(unsigned(input2_vector)) * weight2 +
                            to_integer(unsigned(input3_vector)) * weight3;

            if weighted_sum > 63 then
                weighted_sum <= 63;
            elsif weighted_sum < -63 then
                weighted_sum <= -63;
            end if;

            if LUT(weighted_sum) > 0.5 then
                output <= '1';
            else
                output <= '0';
            end if;
        end if;
    end process;
end Behavioral;
