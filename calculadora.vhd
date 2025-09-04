------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
------------------------------------------------------------
ENTITY calculadora IS
    PORT (
        A   : IN  STD_LOGIC_VECTOR(3 DOWNTO 0);
        B   : IN  STD_LOGIC_VECTOR(3 DOWNTO 0);
        ope : IN  STD_LOGIC_VECTOR(1 DOWNTO 0); 
        -- 00 = suma
        -- 01 = resta
        -- 10 = multiplicación
        -- salidas a displays de 7 segmentos
        sseg1 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
        sseg2 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
        sseg3 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
        sseg4 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0)
    );
END calculadora;
------------------------------------------------------------
ARCHITECTURE estructural OF calculadora IS

    -- Señales internas
    SIGNAL sumRes_out : STD_LOGIC_VECTOR(4 DOWNTO 0); -- salida suma/resta
    SIGNAL S_aux      : STD_LOGIC;
	 SIGNAL	  S   :  STD_LOGIC; -- signo para resta
    SIGNAL    M   :  STD_LOGIC_VECTOR(3 DOWNTO 0); -- magnitud resta
    SIGNAL    R   :  STD_LOGIC_VECTOR(7 DOWNTO 0); -- resultado final
		  
    SIGNAL M_aux      : STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL mult_out   : STD_LOGIC_VECTOR(7 DOWNTO 0);
    SIGNAL R_aux      : STD_LOGIC_VECTOR(7 DOWNTO 0);

    SIGNAL U_aux      : STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL D_aux      : STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL GT9_aux    : STD_LOGIC;
	 
	 SIGNAL    U   :  STD_LOGIC_VECTOR(3 DOWNTO 0); -- unidades
    SIGNAL    D   :  STD_LOGIC_VECTOR(3 DOWNTO 0); -- decenas
    SIGNAL    GT9 :  STD_LOGIC;                    -- '1' si A o B > 9


BEGIN
    
    -- Instancia suma/resta
    U1: ENTITY work.sum_rest(aritmetica)
        PORT MAP (
            A      => A,
            B_ext  => B,
            D      => ope(0),   -- bit 0: 0 = suma, 1 = resta
            S      => S_aux,
            M      => M_aux,
            SumRes => sumRes_out
        );

    -- Instancia multiplicador
    U2: ENTITY work.mult4(por)
        PORT MAP (
            A => A,
            B => B,
            P => mult_out
        );

    -- Señales a salidas
    S <= S_aux;
    M <= M_aux;

    -- Multiplexor de resultados
    WITH ope SELECT
    R_aux <= ("000" & sumRes_out) WHEN "00",  -- suma
              ("0000" & M_aux)    WHEN "01",  -- resta
              mult_out            WHEN "10",  -- multiplicación
              (OTHERS => '0')     WHEN OTHERS;

    R <= R_aux;

    -- Instancia de "digitos"
    U3: ENTITY work.digitos(behav)
        PORT MAP (
            A    => R_aux,
            dig1 => U_aux,
            dig2 => D_aux
        );
		  
    -- Instancia de comparador mayor a 9
    U4: ENTITY work.comp_mayor9(logic)
        PORT MAP (
            A   => A,
            B   => B,
            GT9 => GT9_aux
        );

    -- Instancia de displays 7 segmentos
    U5: ENTITY work.mosseg(behaviour)
        PORT MAP (
            bin1  =>  U_aux,   -- unidades
            bin2  =>  D_aux,   -- decenas
            bin3  =>  B,
            bin4  =>  A,
            ope   => S_aux,   
            GT9   => GT9_aux,  -- comparador mayor a 9
            sseg1 => sseg1,
            sseg2 => sseg2,
            sseg3 => sseg3,
            sseg4 => sseg4
        );

    -- Asignación de señales internas a salidas
    U   <= U_aux;
    D   <= D_aux;
    GT9 <= GT9_aux;

END estructural;
------------------------------------------------------------
