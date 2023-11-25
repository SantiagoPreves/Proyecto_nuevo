-- Copyright (C) 1991-2013 Altera Corporation
-- Your use of Altera Corporation's design tools, logic functions 
-- and other software and tools, and its AMPP partner logic 
-- functions, and any output files from any of the foregoing 
-- (including device programming or simulation files), and any 
-- associated documentation or information are expressly subject 
-- to the terms and conditions of the Altera Program License 
-- Subscription Agreement, Altera MegaCore Function License 
-- Agreement, or other applicable license agreement, including, 
-- without limitation, that your use is for the sole purpose of 
-- programming logic devices manufactured by Altera and sold by 
-- Altera or its authorized distributors.  Please refer to the 
-- applicable agreement for further details.

-- Generated by Quartus II Version 13.0.1 Build 232 06/12/2013 Service Pack 1 SJ Web Edition
-- Created on Thu Nov 16 13:22:56 2023

LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY control_alternativo IS
    PORT (
        stop : IN STD_LOGIC := '0';
        clock : IN STD_LOGIC;
        sensores : IN STD_LOGIC_VECTOR(1 DOWNTO 0) := "00";
        motor_izq : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
        motor_der : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
        in_1 : OUT STD_LOGIC;
        in_2 : OUT STD_LOGIC;
        in_3 : OUT STD_LOGIC;
        in_4 : OUT STD_LOGIC
    );
END control_alternativo;

ARCHITECTURE BEHAVIOR OF control_alternativo IS
    TYPE type_fstate IS (parado,recta,reversa,izq_suave,der_suave,der_brusca,izq_brusca);
    SIGNAL fstate : type_fstate;
    SIGNAL reg_fstate : type_fstate;
BEGIN
    PROCESS (clock,reg_fstate)
    BEGIN
        IF (clock='1' AND clock'event) THEN
            fstate <= reg_fstate;
        END IF;
    END PROCESS;

    PROCESS (fstate,stop,sensores)
    BEGIN
        IF (stop='0') THEN
            reg_fstate <= parado;
            motor_izq <= "00";
            motor_der <= "00";
            in_1 <= '0';
            in_2 <= '0';
            in_3 <= '0';
            in_4 <= '0';
        ELSE
            motor_izq <= "00";
            motor_der <= "00";
            in_1 <= '0';
            in_2 <= '0';
            in_3 <= '0';
            in_4 <= '0';
            CASE fstate IS
                WHEN parado =>
                    IF ((sensores(1 DOWNTO 0) = "00")) THEN
                        reg_fstate <= recta;
                    ELSIF ((sensores(1 DOWNTO 0) = "01")) THEN
                        reg_fstate <= izq_suave;
                    ELSIF ((sensores(1 DOWNTO 0) = "10")) THEN
                        reg_fstate <= der_suave;
                    ELSIF ((sensores(1 DOWNTO 0) = "11")) THEN
                        reg_fstate <= parado;
                    -- Inserting 'else' block to prevent latch inference
                    ELSE
                        reg_fstate <= parado;
                    END IF;

                    in_4 <= '0';

                    in_3 <= '0';

                    in_2 <= '0';

                    in_1 <= '0';

                    motor_der <= "00";

                    motor_izq <= "00";
                WHEN recta =>
                    IF ((sensores(1 DOWNTO 0) = "00")) THEN
                        reg_fstate <= recta;
                    ELSIF ((sensores(1 DOWNTO 0) = "01")) THEN
                        reg_fstate <= izq_suave;
                    ELSIF ((sensores(1 DOWNTO 0) = "10")) THEN
                        reg_fstate <= der_suave;
                    ELSIF ((sensores(1 DOWNTO 0) = "11")) THEN
                        reg_fstate <= reversa;
                    -- Inserting 'else' block to prevent latch inference
                    ELSE
                        reg_fstate <= recta;
                    END IF;

                    in_4 <= '1';

                    in_3 <= '0';

                    in_2 <= '1';

                    in_1 <= '0';

                    motor_der <= "11";

                    motor_izq <= "11";
                WHEN reversa =>
                    IF ((sensores(1 DOWNTO 0) = "00")) THEN
                        reg_fstate <= recta;
                    ELSIF ((sensores(1 DOWNTO 0) = "01")) THEN
                        reg_fstate <= izq_suave;
                    ELSIF ((sensores(1 DOWNTO 0) = "10")) THEN
                        reg_fstate <= der_suave;
                    ELSIF ((sensores(1 DOWNTO 0) = "11")) THEN
                        reg_fstate <= reversa;
                    -- Inserting 'else' block to prevent latch inference
                    ELSE
                        reg_fstate <= reversa;
                    END IF;

                    in_4 <= '0';

                    in_3 <= '1';

                    in_2 <= '0';

                    in_1 <= '1';

                    motor_der <= "11";

                    motor_izq <= "11";
                WHEN izq_suave =>
                    IF ((sensores(1 DOWNTO 0) = "00")) THEN
                        reg_fstate <= recta;
                    ELSIF ((sensores(1 DOWNTO 0) = "01")) THEN
                        reg_fstate <= izq_suave;
                    ELSIF ((sensores(1 DOWNTO 0) = "10")) THEN
                        reg_fstate <= der_suave;
                    ELSIF ((sensores(1 DOWNTO 0) = "11")) THEN
                        reg_fstate <= izq_brusca;
                    -- Inserting 'else' block to prevent latch inference
                    ELSE
                        reg_fstate <= izq_suave;
                    END IF;

                    in_4 <= '1';

                    in_3 <= '0';

                    in_2 <= '1';

                    in_1 <= '0';

                    motor_der <= "11";

                    motor_izq <= "10";
                WHEN der_suave =>
                    IF ((sensores(1 DOWNTO 0) = "00")) THEN
                        reg_fstate <= recta;
                    ELSIF ((sensores(1 DOWNTO 0) = "01")) THEN
                        reg_fstate <= izq_suave;
                    ELSIF ((sensores(1 DOWNTO 0) = "10")) THEN
                        reg_fstate <= der_suave;
                    ELSIF ((sensores(1 DOWNTO 0) = "11")) THEN
                        reg_fstate <= der_brusca;
                    -- Inserting 'else' block to prevent latch inference
                    ELSE
                        reg_fstate <= der_suave;
                    END IF;

                    in_4 <= '1';

                    in_3 <= '0';

                    in_2 <= '1';

                    in_1 <= '0';

                    motor_der <= "10";

                    motor_izq <= "11";
                WHEN der_brusca =>
                    IF ((sensores(1 DOWNTO 0) = "00")) THEN
                        reg_fstate <= recta;
                    ELSIF ((sensores(1 DOWNTO 0) = "01")) THEN
                        reg_fstate <= izq_suave;
                    ELSIF ((sensores(1 DOWNTO 0) = "10")) THEN
                        reg_fstate <= der_suave;
                    ELSIF ((sensores(1 DOWNTO 0) = "11")) THEN
                        reg_fstate <= der_brusca;
                    -- Inserting 'else' block to prevent latch inference
                    ELSE
                        reg_fstate <= der_brusca;
                    END IF;

                    in_4 <= '0';

                    in_3 <= '1';

                    in_2 <= '1';

                    in_1 <= '0';

                    motor_der <= "00";

                    motor_izq <= "01";
                WHEN izq_brusca =>
                    IF ((sensores(1 DOWNTO 0) = "00")) THEN
                        reg_fstate <= recta;
                    ELSIF ((sensores(1 DOWNTO 0) = "01")) THEN
                        reg_fstate <= izq_suave;
                    ELSIF ((sensores(1 DOWNTO 0) = "10")) THEN
                        reg_fstate <= der_suave;
                    ELSIF ((sensores(1 DOWNTO 0) = "11")) THEN
                        reg_fstate <= izq_brusca;
                    -- Inserting 'else' block to prevent latch inference
                    ELSE
                        reg_fstate <= izq_brusca;
                    END IF;

                    in_4 <= '1';

                    in_3 <= '0';

                    in_2 <= '0';

                    in_1 <= '1';

                    motor_der <= "01";

                    motor_izq <= "00";
                WHEN OTHERS => 
                    motor_izq <= "XX";
                    motor_der <= "XX";
                    in_1 <= 'X';
                    in_2 <= 'X';
                    in_3 <= 'X';
                    in_4 <= 'X';
                    report "Reach undefined state";
            END CASE;
        END IF;
    END PROCESS;
END BEHAVIOR;
