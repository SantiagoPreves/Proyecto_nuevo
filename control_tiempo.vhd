LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY control_tiempo IS
    PORT (
        reset : IN STD_LOGIC := '0';
        clock : IN STD_LOGIC;
        S : IN STD_LOGIC := '0';
        R2 : IN STD_LOGIC := '0';
        stop_and_go : OUT STD_LOGIC;
        Resultado : OUT STD_LOGIC;
        contador : OUT STD_LOGIC;
        LED1 : OUT STD_LOGIC;
        LED2 : OUT STD_LOGIC;
        LED3 : OUT STD_LOGIC;
        LED4 : OUT STD_LOGIC
    );
END control_tiempo;

ARCHITECTURE BEHAVIOR OF control_tiempo IS
    TYPE type_fstate IS (parar,marcha,V_0,V_1,V_2,V_3);
    SIGNAL fstate : type_fstate;
    SIGNAL reg_fstate : type_fstate;
    SIGNAL reg_stop_and_go : STD_LOGIC := '0';
BEGIN
    PROCESS (clock,reset,reg_fstate,reg_stop_and_go)
    BEGIN
        IF (reset='0') THEN
            fstate <= parar;
            stop_and_go <= '0';
        ELSIF (clock='1' AND clock'event) THEN
            fstate <= reg_fstate;
            stop_and_go <= reg_stop_and_go;
        END IF;
    END PROCESS;

    PROCESS (fstate,S,R2)
    BEGIN
        reg_stop_and_go <= '0';
        Resultado <= '0';
        contador <= '0';
        LED1 <= '0';
        LED2 <= '0';
        LED3 <= '0';
        LED4 <= '0';
        CASE fstate IS
            WHEN parar =>
                IF ((R2 = '1')) THEN
                    reg_fstate <= marcha;
                -- Inserting 'else' block to prevent latch inference
                ELSE
                    reg_fstate <= parar;
                END IF;

                LED1 <= '0';

                LED3 <= '0';

                LED2 <= '0';

                reg_stop_and_go <= '0';

                contador <= '0';

                LED4 <= '0';

                Resultado <= '1';
            WHEN marcha =>
                IF (((S = '1') AND (R2 = '0'))) THEN
                    reg_fstate <= marcha;
                ELSIF (((S = '0') AND (R2 = '0'))) THEN
                    reg_fstate <= V_0;
                -- Inserting 'else' block to prevent latch inference
                ELSE
                    reg_fstate <= marcha;
                END IF;

                LED1 <= '0';

                LED3 <= '0';

                LED2 <= '0';

                reg_stop_and_go <= '1';

                contador <= '0';

                LED4 <= '0';

                Resultado <= '0';
            WHEN V_0 =>
                IF (((S = '1') AND (R2 = '0'))) THEN
                    reg_fstate <= V_0;
                ELSIF (((S = '0') AND (R2 = '0'))) THEN
                    reg_fstate <= V_1;
                -- Inserting 'else' block to prevent latch inference
                ELSE
                    reg_fstate <= V_0;
                END IF;

                LED1 <= '1';

                LED3 <= '0';

                LED2 <= '0';

                reg_stop_and_go <= '1';

                contador <= '1';

                LED4 <= '0';

                Resultado <= '0';
            WHEN V_1 =>
                IF (((S = '1') AND (R2 = '0'))) THEN
                    reg_fstate <= V_1;
                ELSIF (((S = '0') AND (R2 = '0'))) THEN
                    reg_fstate <= V_2;
                -- Inserting 'else' block to prevent latch inference
                ELSE
                    reg_fstate <= V_1;
                END IF;

                LED1 <= '1';

                LED3 <= '0';

                LED2 <= '1';

                reg_stop_and_go <= '1';

                contador <= '1';

                LED4 <= '0';

                Resultado <= '0';
            WHEN V_2 =>
                IF (((S = '1') AND (R2 = '0'))) THEN
                    reg_fstate <= V_2;
                ELSIF (((S = '0') AND (R2 = '0'))) THEN
                    reg_fstate <= V_3;
                -- Inserting 'else' block to prevent latch inference
                ELSE
                    reg_fstate <= V_2;
                END IF;

                LED1 <= '1';

                LED3 <= '1';

                LED2 <= '1';

                reg_stop_and_go <= '1';

                contador <= '1';

                LED4 <= '0';

                Resultado <= '0';
            WHEN V_3 =>
                IF (((S = '0') AND (R2 = '0'))) THEN
                    reg_fstate <= parar;
                ELSIF (((S = '1') AND (R2 = '0'))) THEN
                    reg_fstate <= V_3;
                -- Inserting 'else' block to prevent latch inference
                ELSE
                    reg_fstate <= V_3;
                END IF;

                LED1 <= '1';

                LED3 <= '1';

                LED2 <= '1';
                LED2 <= '1';

                reg_stop_and_go <= '1';

                contador <= '1';

                LED4 <= '1';
                LED4 <= '1';

                Resultado <= '0';
            WHEN OTHERS => 
                reg_stop_and_go <= 'X';
                Resultado <= 'X';
                contador <= 'X';
                LED1 <= 'X';
                LED2 <= 'X';
                LED3 <= 'X';
                LED4 <= 'X';
                report "Reach undefined state";
        END CASE;
    END PROCESS;
END BEHAVIOR;