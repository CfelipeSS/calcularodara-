-----------------------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
-----------------------------------------------------------------------------
ENTITY sum_rest IS
    PORT (
        A  : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        B_ext  : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        D  : IN STD_LOGIC; -- 0 para suma, 1 para resta
        S  : OUT STD_LOGIC; -- Signo de la resta
        M  : OUT STD_LOGIC_VECTOR(3 DOWNTO 0); -- Magnitud del resultado en resta
        SumRes : OUT STD_LOGIC_VECTOR(4 DOWNTO 0) -- Resultado de la suma/resta
    );
END sum_rest;
-----------------------------------------------------------------------------
ARCHITECTURE aritmetica OF sum_rest IS
    SIGNAL mayor   : STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL menor   : STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL diff    : STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL borrow  : STD_LOGIC_VECTOR(4 DOWNTO 0);
    SIGNAL Carry   : STD_LOGIC_VECTOR(4 DOWNTO 0);
    SIGNAL Sum     : STD_LOGIC_VECTOR(4 DOWNTO 0);
    SIGNAL M_internal : STD_LOGIC_VECTOR(3 DOWNTO 0); 
BEGIN
    
    
    
    
    mayor <= A WHEN A >= B_ext ELSE B_ext;
    menor <= B_ext WHEN A >= B_ext ELSE A;
    S <= '0' WHEN D = '0' ELSE '1' WHEN A < B_ext ELSE '0';
    
    -- Resta combinacional
    borrow(0) <= '0';
    diff(0) <= mayor(0) XOR menor(0);
    borrow(1) <= (NOT mayor(0)) AND menor(0);
    
    diff(1) <= mayor(1) XOR menor(1) XOR borrow(1);
    borrow(2) <= ((NOT mayor(1)) AND menor(1)) OR (borrow(1) AND (NOT (mayor(1) XOR menor(1))));
    
    diff(2) <= mayor(2) XOR menor(2) XOR borrow(2);
    borrow(3) <= ((NOT mayor(2)) AND menor(2)) OR (borrow(2) AND (NOT (mayor(2) XOR menor(2))));
    
    diff(3) <= mayor(3) XOR menor(3) XOR borrow(3);
    borrow(4) <= ((NOT mayor(3)) AND menor(3)) OR (borrow(3) AND (NOT (mayor(3) XOR menor(3))));
    
    -- Suma combinacional
    Carry(0) <= '0';
    Sum(0) <= A(0) XOR B_ext(0) XOR Carry(0);
    Carry(1) <= (A(0) AND B_ext(0)) OR (A(0) AND Carry(0)) OR (B_ext(0) AND Carry(0));
    
    Sum(1) <= A(1) XOR B_ext(1) XOR Carry(1);
    Carry(2) <= (A(1) AND B_ext(1)) OR (A(1) AND Carry(1)) OR (B_ext(1) AND Carry(1));
    
    Sum(2) <= A(2) XOR B_ext(2) XOR Carry(2);
    Carry(3) <= (A(2) AND B_ext(2)) OR (A(2) AND Carry(2)) OR (B_ext(2) AND Carry(2));
    
    Sum(3) <= A(3) XOR B_ext(3) XOR Carry(3);
    Carry(4) <= (A(3) AND B_ext(3)) OR (A(3) AND Carry(3)) OR (B_ext(3) AND Carry(3));
    
    Sum(4) <= Carry(4);
    
    -- Selección entre suma o resta (sin signo en la resta)
    M_internal <= diff WHEN D = '1' ELSE Sum(3 DOWNTO 0);
    M <= M_internal;
    SumRes <= Sum WHEN D = '0' ELSE ('0' & M_internal); 
    
END aritmetica;
