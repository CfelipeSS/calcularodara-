------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
------------------------------------------------------------
ENTITY mult4 IS
    PORT (
        A : IN  STD_LOGIC_VECTOR(3 DOWNTO 0);
        B : IN  STD_LOGIC_VECTOR(3 DOWNTO 0);
        P : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
    );
END mult4;
------------------------------------------------------------
ARCHITECTURE por OF mult4 IS

    -- Productos parciales
    SIGNAL pp0 : STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL pp1 : STD_LOGIC_VECTOR(4 DOWNTO 0);
    SIGNAL pp2 : STD_LOGIC_VECTOR(5 DOWNTO 0);
    SIGNAL pp3 : STD_LOGIC_VECTOR(6 DOWNTO 0);

    -- Señales intermedias para los sumadores
    SIGNAL s1 : STD_LOGIC_VECTOR(4 DOWNTO 0);
    SIGNAL s2 : STD_LOGIC_VECTOR(5 DOWNTO 0);
    SIGNAL s3 : STD_LOGIC_VECTOR(6 DOWNTO 0);

    -- carries
    SIGNAL c1 : STD_LOGIC_VECTOR(4 DOWNTO 0);
    SIGNAL c2 : STD_LOGIC_VECTOR(5 DOWNTO 0);
    SIGNAL c3 : STD_LOGIC_VECTOR(6 DOWNTO 0);

BEGIN
    --------------------------------------------------------
    -- Productos parciales
    --------------------------------------------------------
    pp0(0) <= A(0) AND B(0);
    pp0(1) <= A(1) AND B(0);
    pp0(2) <= A(2) AND B(0);
    pp0(3) <= A(3) AND B(0);

    pp1(0) <= '0';
    pp1(1) <= A(0) AND B(1);
    pp1(2) <= A(1) AND B(1);
    pp1(3) <= A(2) AND B(1);
    pp1(4) <= A(3) AND B(1);

    pp2(0) <= '0';
    pp2(1) <= '0';
    pp2(2) <= A(0) AND B(2);
    pp2(3) <= A(1) AND B(2);
    pp2(4) <= A(2) AND B(2);
    pp2(5) <= A(3) AND B(2);

    pp3(0) <= '0';
    pp3(1) <= '0';
    pp3(2) <= '0';
    pp3(3) <= A(0) AND B(3);
    pp3(4) <= A(1) AND B(3);
    pp3(5) <= A(2) AND B(3);
    pp3(6) <= A(3) AND B(3);

    --------------------------------------------------------
    -- Primera suma: pp0 (con 0 delante) + pp1
    --------------------------------------------------------
    s1(0) <= pp0(0);
    c1(0) <= '0';

    s1(1) <= pp0(1) XOR pp1(1) XOR c1(0);
    c1(1) <= (pp0(1) AND pp1(1)) OR (pp0(1) AND c1(0)) OR (pp1(1) AND c1(0));

    s1(2) <= pp0(2) XOR pp1(2) XOR c1(1);
    c1(2) <= (pp0(2) AND pp1(2)) OR (pp0(2) AND c1(1)) OR (pp1(2) AND c1(1));

    s1(3) <= pp0(3) XOR pp1(3) XOR c1(2);
    c1(3) <= (pp0(3) AND pp1(3)) OR (pp0(3) AND c1(2)) OR (pp1(3) AND c1(2));

    s1(4) <= pp1(4) XOR c1(3);
    c1(4) <= pp1(4) AND c1(3);

    --------------------------------------------------------
    -- Segunda suma: s1 + pp2
    --------------------------------------------------------
    s2(0) <= s1(0);
    c2(0) <= '0';

    s2(1) <= s1(1) XOR pp2(1) XOR c2(0);
    c2(1) <= (s1(1) AND pp2(1)) OR (s1(1) AND c2(0)) OR (pp2(1) AND c2(0));

    s2(2) <= s1(2) XOR pp2(2) XOR c2(1);
    c2(2) <= (s1(2) AND pp2(2)) OR (s1(2) AND c2(1)) OR (pp2(2) AND c2(1));

    s2(3) <= s1(3) XOR pp2(3) XOR c2(2);
    c2(3) <= (s1(3) AND pp2(3)) OR (s1(3) AND c2(2)) OR (pp2(3) AND c2(2));

    s2(4) <= s1(4) XOR pp2(4) XOR c2(3);
    c2(4) <= (s1(4) AND pp2(4)) OR (s1(4) AND c2(3)) OR (pp2(4) AND c2(3));

    s2(5) <= pp2(5) XOR c2(4);
    c2(5) <= pp2(5) AND c2(4);

    --------------------------------------------------------
    -- Tercera suma: s2 + pp3
    --------------------------------------------------------
    s3(0) <= s2(0);
    c3(0) <= '0';

    s3(1) <= s2(1) XOR pp3(1) XOR c3(0);
    c3(1) <= (s2(1) AND pp3(1)) OR (s2(1) AND c3(0)) OR (pp3(1) AND c3(0));

    s3(2) <= s2(2) XOR pp3(2) XOR c3(1);
    c3(2) <= (s2(2) AND pp3(2)) OR (s2(2) AND c3(1)) OR (pp3(2) AND c3(1));

    s3(3) <= s2(3) XOR pp3(3) XOR c3(2);
    c3(3) <= (s2(3) AND pp3(3)) OR (s2(3) AND c3(2)) OR (pp3(3) AND c3(2));

    s3(4) <= s2(4) XOR pp3(4) XOR c3(3);
    c3(4) <= (s2(4) AND pp3(4)) OR (s2(4) AND c3(3)) OR (pp3(4) AND c3(3));

    s3(5) <= s2(5) XOR pp3(5) XOR c3(4);
    c3(5) <= (s2(5) AND pp3(5)) OR (s2(5) AND c3(4)) OR (pp3(5) AND c3(4));

    s3(6) <= pp3(6) XOR c3(5);
    c3(6) <= pp3(6) AND c3(5);

    --------------------------------------------------------
    -- Salida final
    --------------------------------------------------------
    P(0) <= pp0(0);    -- primer bit directo
    P(1) <= s1(1);
    P(2) <= s2(2);
    P(3) <= s3(3);
    P(4) <= s3(4);
    P(5) <= s3(5);
    P(6) <= s3(6);
    P(7) <= c3(6);

END por;
