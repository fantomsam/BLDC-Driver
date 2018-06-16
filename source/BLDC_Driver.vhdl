library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity BLDC_Driver is
  port (
        Dir : in std_logic;
        Hall_sens : in std_logic_vector(2 downto 0);
        En : out std_logic_vector(2 downto 0);
        Dr : out std_logic_vector(2 downto 0)
       );
end BLDC_Driver;

architecture behavioral of BLDC_Driver is
begin
    process(Hall_sens)
    begin
      case (Hall_sens) is
      	when "101" => En <= "110"; Dr <= "100" when Dir = '0' else "011";
      	when "100" => En <= "101"; Dr <= "100" when Dir = '0' else "011";
      	when "110" => En <= "011"; Dr <= "110" when Dir = '0' else "001";
      	when "010" => En <= "110"; Dr <= "011" when Dir = '0' else "100";
      	when "011" => En <= "101"; Dr <= "011" when Dir = '0' else "100";
      	when "001" => En <= "011"; Dr <= "001" when Dir = '0' else "110";
      	when others => En <= (others=>'0'); Dr <= (others => '0');
      end case;
    end process;
end behavioral;

