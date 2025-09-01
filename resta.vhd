------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
------------------------------------------------------------
ENTITY rest IS
    PORT (
        A  : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        B  : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        S  : OUT STD_LOGIC; -- Signo de la resta
        M  : OUT STD_LOGIC_VECTOR(3 DOWNTO 0) -- Magnitud del resultado
    );
END rest;
------------------------------------------------------------
ARCHITECTURE aritmeticaRes OF rest IS
    SIGNAL mayor   : STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL menor   : STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL diff    : STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL borrow  : STD_LOGIC_VECTOR(4 DOWNTO 0);
BEGIN
    -- Comparador: Determina cuál es el mayor y cuál el menor
    mayor <= A WHEN A >= B ELSE B;
    menor <= B WHEN A >= B ELSE A;
    
    -- Determina el signo (S = '0' si A >= B, S = '1' si A < B)
    S <= '0' WHEN A >= B ELSE '1';

    -- Resta combinacional sin usar - ni +
    borrow(0) <= '0'; -- Inicializamos el acarreo

    diff(0) <= mayor(0) XOR menor(0); 
    borrow(1) <= (NOT mayor(0)) AND menor(0);  

    diff(1) <= mayor(1) XOR menor(1) XOR borrow(1);
    borrow(2) <= ((NOT mayor(1)) AND menor(1)) OR (borrow(1) AND (NOT (mayor(1) XOR menor(1))));

    diff(2) <= mayor(2) XOR menor(2) XOR borrow(2);
    borrow(3) <= ((NOT mayor(2)) AND menor(2)) OR (borrow(2) AND (NOT (mayor(2) XOR menor(2))));

    diff(3) <= mayor(3) XOR menor(3) XOR borrow(3);
    borrow(4) <= ((NOT mayor(3)) AND menor(3)) OR (borrow(3) AND (NOT (mayor(3) XOR menor(3))));

    -- La magnitud del resultado es la diferencia absoluta
    M <= diff;
    
END aritmeticaRes;
