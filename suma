------------------------------------------------------------
LIBRARY IEEE;
USE ieee.std_logic_1164.all;
------------------------------------------------------------
ENTITY suma IS
    PORT (
        A : IN STD_LOGIC_VECTOR(3 DOWNTO 0); -- Número de 4 bits
        B : IN STD_LOGIC_VECTOR(3 DOWNTO 0); -- Número de 4 bits
        S : OUT STD_LOGIC_VECTOR(4 DOWNTO 0) -- Resultado de 5 bits
    );
END suma;
------------------------------------------------------------
ARCHITECTURE sumRes OF suma IS
   
    SIGNAL Carry : STD_LOGIC_VECTOR(4 DOWNTO 0); -- Vector de acarreo
    SIGNAL Sum : STD_LOGIC_VECTOR(4 DOWNTO 0); -- Resultado de la suma
BEGIN
  
    -- Calcular la suma bit a bit sin proceso ni bucles
    Carry(0) <= '0';
    Sum(0) <= A(0) XOR B(0) XOR Carry(0);
    Carry(1) <= (A(0) AND B(0)) OR (A(0) AND Carry(0)) OR (B(0) AND Carry(0));
    
    Sum(1) <= A(1) XOR B(1) XOR Carry(1);
    Carry(2) <= (A(1) AND B(1)) OR (A(1) AND Carry(1)) OR (B(1) AND Carry(1));
    
    Sum(2) <= A(2) XOR B(2) XOR Carry(2);
    Carry(3) <= (A(2) AND B(2)) OR (A(2) AND Carry(2)) OR (B(2) AND Carry(2));
    
    Sum(3) <= A(3) XOR B(3) XOR Carry(3);
    Carry(4) <= (A(3) AND B(3)) OR (A(3) AND Carry(3)) OR (B(3) AND Carry(3));
    
  
    Sum(4) <= Carry(4);
    
    -- Asignar el resultado
    S <= Sum;
END sumRes;
