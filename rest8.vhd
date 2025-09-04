------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
------------------------------------------------------------
ENTITY rest IS
    PORT (
        A  : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
        B  : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
        S  : OUT STD_LOGIC; -- Signo de la resta (0 = positivo, 1 = negativo)
        M  : OUT STD_LOGIC_VECTOR(7 DOWNTO 0) -- Magnitud del resultado
    );
END rest;
------------------------------------------------------------
ARCHITECTURE aritmeticaRes OF rest IS
    SIGNAL mayor   : STD_LOGIC_VECTOR(7 DOWNTO 0);
    SIGNAL menor   : STD_LOGIC_VECTOR(7 DOWNTO 0);
    SIGNAL diff    : STD_LOGIC_VECTOR(7 DOWNTO 0);
    SIGNAL borrow  : STD_LOGIC_VECTOR(8 DOWNTO 0);
BEGIN
    -- Comparador: Determina cuál es el mayor y cuál el menor
    mayor <= A WHEN A >= B ELSE B;
    menor <= B WHEN A >= B ELSE A;
    
    -- Determina el signo (S = '0' si A >= B, S = '1' si A < B)
    S <= '0' WHEN A >= B ELSE '1';

    -- Resta combinacional sin usar - ni +
    borrow(0) <= '0'; -- Inicializamos el acarreo

    -- Bit 0
    diff(0)   <= mayor(0) XOR menor(0);
    borrow(1) <= (NOT mayor(0)) AND menor(0);

    -- Bit 1
    diff(1)   <= mayor(1) XOR menor(1) XOR borrow(1);
    borrow(2) <= ((NOT mayor(1)) AND menor(1)) OR (borrow(1) AND (NOT (mayor(1) XOR menor(1))));

    -- Bit 2
    diff(2)   <= mayor(2) XOR menor(2) XOR borrow(2);
    borrow(3) <= ((NOT mayor(2)) AND menor(2)) OR (borrow(2) AND (NOT (mayor(2) XOR menor(2))));

    -- Bit 3
    diff(3)   <= mayor(3) XOR menor(3) XOR borrow(3);
    borrow(4) <= ((NOT mayor(3)) AND menor(3)) OR (borrow(3) AND (NOT (mayor(3) XOR menor(3))));

    -- Bit 4
    diff(4)   <= mayor(4) XOR menor(4) XOR borrow(4);
    borrow(5) <= ((NOT mayor(4)) AND menor(4)) OR (borrow(4) AND (NOT (mayor(4) XOR menor(4))));

    -- Bit 5
    diff(5)   <= mayor(5) XOR menor(5) XOR borrow(5);
    borrow(6) <= ((NOT mayor(5)) AND menor(5)) OR (borrow(5) AND (NOT (mayor(5) XOR menor(5))));

    -- Bit 6
    diff(6)   <= mayor(6) XOR menor(6) XOR borrow(6);
    borrow(7) <= ((NOT mayor(6)) AND menor(6)) OR (borrow(6) AND (NOT (mayor(6) XOR menor(6))));

    -- Bit 7
    diff(7)   <= mayor(7) XOR menor(7) XOR borrow(7);
    borrow(8) <= ((NOT mayor(7)) AND menor(7)) OR (borrow(7) AND (NOT (mayor(7) XOR menor(7))));

    -- La magnitud del resultado es la diferencia absoluta
    M <= diff;
    
END aritmeticaRes;
