------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
------------------------------------------------------------
ENTITY digitos IS
    PORT (
        A    : IN  STD_LOGIC_VECTOR(7 DOWNTO 0); -- Entrada 0–99
        dig1 : OUT STD_LOGIC_VECTOR(3 DOWNTO 0); -- unidades
        dig2 : OUT STD_LOGIC_VECTOR(3 DOWNTO 0); -- decenas
        dig3 : OUT STD_LOGIC_VECTOR(3 DOWNTO 0); -- no usado
        dig4 : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)  -- no usado
    );
END digitos;
------------------------------------------------------------
ARCHITECTURE behav OF digitos IS

    COMPONENT rest IS
        PORT (
            A : IN  STD_LOGIC_VECTOR(7 DOWNTO 0);
            B : IN  STD_LOGIC_VECTOR(7 DOWNTO 0);
            M : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
        );
    END COMPONENT;

    SIGNAL B10 : STD_LOGIC_VECTOR(7 DOWNTO 0) := "00001010"; -- 10

    SIGNAL mag10a, mag10b, mag10c, mag10d, mag10e,
           mag10f, mag10g, mag10h, mag10i : STD_LOGIC_VECTOR(7 DOWNTO 0);

    SIGNAL d2_val  : STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL uni_vec : STD_LOGIC_VECTOR(7 DOWNTO 0);
BEGIN
    -- Cadenas de restas de 10 en 10
    U10a: rest PORT MAP (A => A,      B => B10, M => mag10a);
    U10b: rest PORT MAP (A => mag10a, B => B10, M => mag10b);
    U10c: rest PORT MAP (A => mag10b, B => B10, M => mag10c);
    U10d: rest PORT MAP (A => mag10c, B => B10, M => mag10d);
    U10e: rest PORT MAP (A => mag10d, B => B10, M => mag10e);
    U10f: rest PORT MAP (A => mag10e, B => B10, M => mag10f);
    U10g: rest PORT MAP (A => mag10f, B => B10, M => mag10g);
    U10h: rest PORT MAP (A => mag10g, B => B10, M => mag10h);
    U10i: rest PORT MAP (A => mag10h, B => B10, M => mag10i);

    -- Decenas
    d2_val <= "0000" WHEN A      < B10 ELSE
              "0001" WHEN mag10a < B10 ELSE
              "0010" WHEN mag10b < B10 ELSE
              "0011" WHEN mag10c < B10 ELSE
              "0100" WHEN mag10d < B10 ELSE
              "0101" WHEN mag10e < B10 ELSE
              "0110" WHEN mag10f < B10 ELSE
              "0111" WHEN mag10g < B10 ELSE
              "1000" WHEN mag10h < B10 ELSE
              "1001"; -- 90–99

    -- Unidades: escoger el primer resto < 10
    uni_vec <= A       WHEN A      < B10 ELSE
               mag10a  WHEN mag10a < B10 ELSE
               mag10b  WHEN mag10b < B10 ELSE
               mag10c  WHEN mag10c < B10 ELSE
               mag10d  WHEN mag10d < B10 ELSE
               mag10e  WHEN mag10e < B10 ELSE
               mag10f  WHEN mag10f < B10 ELSE
               mag10g  WHEN mag10g < B10 ELSE
               mag10h  WHEN mag10h < B10 ELSE
               mag10i; -- 90–99

    -- Salidas
    dig2 <= d2_val;
    dig1 <= uni_vec(3 DOWNTO 0);
    dig3 <= "0000";
    dig4 <= "0000";
END behav;
