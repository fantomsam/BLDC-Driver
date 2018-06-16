library ieee;
use ieee.std_logic_1164.all;

--  A testbench has no ports.
entity BLDC_Driver_tb is
end BLDC_Driver_tb;

architecture behav of BLDC_Driver_tb is
   --  Declaration of the component that will be instantiated.
   component BLDC_Driver
	 port (
		      Dir : in std_logic; -- Motor direction, '0'= CW '1'=CCW
		      PWM : in std_logic; -- Output Chopping input
		      DR_en : in std_logic; -- Enable the EN lines
		      Brake : in std_logic; -- Brake the motor by short the inputs 
		      Hall_sens : in std_logic_vector(2 downto 0);
		      En : out std_logic_vector(2 downto 0);
		      Dr : out std_logic_vector(2 downto 0)
			  );
   end component;

   --  Specifies which entity is bound with the component.
   type pattern_array is array (natural range <>) of std_logic_vector(2 downto 0);
      constant hall_sens_patterns : pattern_array :=
        ("101",
         "100",
         "110",
         "010",
         "011",
         "001");
   signal Hall_sens,En,Dr : std_logic_vector(2 downto 0);
   signal Dir : std_logic;
   constant clk_in_t : time := 1000 ns;
   constant speed_of_motor : time := 250 us;
   begin
   --  Component instantiation.
   S_c_0: BLDC_Driver
   port map (
   					Dir => Dir,
   					PWM => '1',
   					Brake => '0',
   					DR_en => '1',
						Hall_sens => Hall_sens,
						En => En,
						Dr => Dr
            );

   stimuli: process
   begin
   Dir <= '0';
	 for i in hall_sens_patterns'range loop
	 	Hall_sens <= hall_sens_patterns(i);
	 	wait for 1 us;
	 end loop;
	 Dir <= '1';
	 for i in hall_sens_patterns'range loop
	 	Hall_sens <= hall_sens_patterns(i);
	 	wait for 1 us;
	 end loop;
	 wait;
   end process;
end behav;
