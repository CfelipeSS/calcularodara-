------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.all;
------------------------------------------------------------
ENTITY mosseg IS
    PORT( 
        bin1  : IN  STD_LOGIC_VECTOR(3 DOWNTO 0);
        bin2  : IN  STD_LOGIC_VECTOR(3 DOWNTO 0);
        bin3  : IN  STD_LOGIC_VECTOR(3 DOWNTO 0);
        bin4  : IN  STD_LOGIC_VECTOR(3 DOWNTO 0);
        ope   : IN  STD_LOGIC;  -- Control para el segundo display
        GT9   : IN  STD_LOGIC;  -- Señal que indica si bin1 > 9
        sseg1 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
        sseg2 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
        sseg3 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
        sseg4 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0)
    );
END ENTITY mosseg;
------------------------------------------------------------
ARCHITECTURE behaviour OF mosseg IS
BEGIN

    ----------------------------------------------------------------
    -- Primer display: depende de GT9
    ----------------------------------------------------------------
    PROCESS(bin1, GT9)
    BEGIN
        IF (GT9 = '1') THEN
            -- Mostrar "E"
            sseg1 <= "0000110";

        ELSE
            CASE bin1 IS
                WHEN "0000" => sseg1 <= "1000000"; -- 0
                WHEN "0001" => sseg1 <= "1111001"; -- 1
                WHEN "0010" => sseg1 <= "0100100"; -- 2
                WHEN "0011" => sseg1 <= "0110000"; -- 3
                WHEN "0100" => sseg1 <= "0011001"; -- 4
                WHEN "0101" => sseg1 <= "0010010"; -- 5
                WHEN "0110" => sseg1 <= "0000010"; -- 6
                WHEN "0111" => sseg1 <= "1111000"; -- 7
                WHEN "1000" => sseg1 <= "0000000"; -- 8
                WHEN "1001" => sseg1 <= "0010000"; -- 9
                WHEN OTHERS => sseg1 <= "0001110"; -- error
            END CASE;
        END IF;
    END PROCESS;

    ----------------------------------------------------------------
    -- Segundo display: depende de "ope"
    ----------------------------------------------------------------
    PROCESS(bin2, ope)
    BEGIN
        IF (ope = '0') THEN
            CASE bin2 IS
                WHEN "0000" => sseg2 <= "1000000"; -- 0
                WHEN "0001" => sseg2 <= "1111001"; -- 1
                WHEN "0010" => sseg2 <= "0100100"; -- 2
                WHEN "0011" => sseg2 <= "0110000"; -- 3
                WHEN "0100" => sseg2 <= "0011001"; -- 4
                WHEN "0101" => sseg2 <= "0010010"; -- 5
                WHEN "0110" => sseg2 <= "0000010"; -- 6
                WHEN "0111" => sseg2 <= "1111000"; -- 7
                WHEN "1000" => sseg2 <= "0000000"; -- 8
                WHEN "1001" => sseg2 <= "0010000"; -- 9
                WHEN OTHERS => sseg2 <= "0001110"; -- error
            END CASE;
        ELSE
            -- signo menos
            sseg2 <= "0111111";
        END IF;
    END PROCESS;

    ----------------------------------------------------------------
    -- Tercer display
    ----------------------------------------------------------------
    WITH bin3 SELECT
        sseg3 <=
            "1000000" WHEN "0000",
            "1111001" WHEN "0001",
            "0100100" WHEN "0010",
            "0110000" WHEN "0011",
            "0011001" WHEN "0100",
            "0010010" WHEN "0101",
            "0000010" WHEN "0110",
            "1111000" WHEN "0111",
            "0000000" WHEN "1000",
            "0010000" WHEN "1001",
            "0001110" WHEN OTHERS;

    ----------------------------------------------------------------
    -- Cuarto display
    ----------------------------------------------------------------
    WITH bin4 SELECT
        sseg4 <=
            "1000000" WHEN "0000",
            "1111001" WHEN "0001",
            "0100100" WHEN "0010",
            "0110000" WHEN "0011",
            "0011001" WHEN "0100",
            "0010010" WHEN "0101",
            "0000010" WHEN "0110",
            "1111000" WHEN "0111",
            "0000000" WHEN "1000",
            "0010000" WHEN "1001",
            "0001110" WHEN OTHERS;

END behaviour;
