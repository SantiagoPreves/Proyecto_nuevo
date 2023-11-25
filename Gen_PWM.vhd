library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Gen_PWM is
    Port (
        clk        : in STD_LOGIC;                           -- Entrada de reloj de la placa FPGA 50Mhz
		   V         : in STD_LOGIC_VECTOR(1 downto 0);
        PWM        : out STD_LOGIC                           -- Frecuencia de PWM deseada 
         );
end Gen_PWM;

architecture Behavioral of Gen_PWM is
    signal contador : natural range 0 to 1000000 - 1 := 0;   --Contador 
    signal out_PWM : STD_LOGIC := '0';                       --Auxiliar
	 signal out_duty_cycle : natural range 0 to 100:= 0;      --Auxiliar 

begin

-- Bloque 1: "Velocidades"
-- En funcion del duty cycle (4 diferentes)
Velocidades : Process(V)
   begin
		if(V="00")then 
			out_duty_cycle<=26;
		else 
		   if(V="01")then
			   out_duty_cycle<=30;
		   else 
			   if(V="10")then
			      out_duty_cycle<=23;
		      else 
				   if(V="11")then
			         out_duty_cycle<=30;	        
		         end if;
		      end if;
		   end if;
		end if;
End process;	

-- Bkoque 2: "Frecuencia PWM" 
-- Bajo de 50Mhz a 10khz

Divisor_freciencia_PWM : process (clk)

	 constant freq_PWM : natural := 100;
    variable periodo_PWM : natural := 50000000 / freq_PWM;               -- Calcula el periodo de PWM en base a la frecuencia deseada
    variable pulso_PWM : natural := periodo_PWM * out_duty_cycle / 100;  -- Calcula el pulso de PWM en base al Duty Cycle
  
  begin
        if rising_edge(clk) then
            if contador < pulso_PWM then
                out_PWM <= '1';                -- Pulso en alto 
            else
                out_PWM <= '0';                -- Pulso en bajo 
            end if; 

            if contador = periodo_PWM - 1 then
                contador <= 0;                 -- Reinicia el contador al final del perÃƒÆ’Ã†â€™Ãƒâ€ Ã¢â‚¬â„¢ÃƒÆ’Ã¢â‚¬Å¡Ãƒâ€šÃ‚Â­odo PWM
            else
                contador <= contador + 1;      -- Incrementa el contador
            end if;
        end if;
    end process;

    PWM <= out_PWM;

end Behavioral;