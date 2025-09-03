------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
------------------------------------------------------------
ENTITY comp_mayor9 IS
    PORT(
        A   : IN  STD_LOGIC_VECTOR(3 DOWNTO 0); -- número de 4 bits
        B   : IN  STD_LOGIC_VECTOR(3 DOWNTO 0); -- número de 4 bits
        GT9 : OUT STD_LOGIC                     -- '1' si A o B > 9
    );
END comp_mayor9;
------------------------------------------------------------
ARCHITECTURE logic OF comp_mayor9 IS
    SIGNAL GT1 : STD_LOGIC; 
    SIGNAL GT2 : STD_LOGIC; 
BEGIN
    -- A > 9
    GT1 <= A(3) AND (A(2) OR A(1));

    -- B > 9
    GT2 <= B(3) AND (B(2) OR B(1));

    -- '1' si A o B es mayor que 9
    GT9 <= GT1 OR GT2;
END logic;
------------------------------------------------------------
