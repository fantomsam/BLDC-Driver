library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity BLDC_Driver is
  port (
        Dir : in std_logic; -- Motor direction, '0'= CW '1'=CCW
        PWM : in std_logic; -- Output Chopping input
        DR_en : in std_logic; -- Enable the EN lines
        Brake : in std_logic; -- Brake the motor by shorting the inputs 
        Hall_sens : in std_logic_vector(2 downto 0);
        En : out std_logic_vector(2 downto 0);
        Dr : out std_logic_vector(2 downto 0)
       );
end BLDC_Driver;

architecture behavioral of BLDC_Driver is
signal s_Dr,s_EN : std_logic_vector(2 downto 0);
begin
    process(Hall_sens)
    begin
      case (Hall_sens) is
      	when "101" => s_EN <= "110"; s_Dr <= "100" when Dir = '0' else "011";
      	when "100" => s_EN <= "101"; s_Dr <= "100" when Dir = '0' else "011";
      	when "110" => s_EN <= "011"; s_Dr <= "110" when Dir = '0' else "001";
      	when "010" => s_EN <= "110"; s_Dr <= "011" when Dir = '0' else "100";
      	when "011" => s_EN <= "101"; s_Dr <= "011" when Dir = '0' else "100";
      	when "001" => s_EN <= "011"; s_Dr <= "001" when Dir = '0' else "110";
      	when others => s_EN <= (others=>'0'); s_Dr <= (others => '0');
      end case;
    end process;
    Dr <= s_DR and PWM and not Brake;
    En <= (s_En or Brake) and DR_en;
end behavioral;

