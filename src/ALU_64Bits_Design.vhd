library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ALU_64Bits_Design is
    port(
        Reg_A     : in  std_logic_vector(63 downto 0);
        Reg_B     : in  std_logic_vector(63 downto 0);
        Op_Sel    : in  std_logic_vector(3 downto 0);
        Carry_In  : in  std_logic;
        Carry_Out : out std_logic;
        ALU_Out   : out std_logic_vector(63 downto 0)
    );
end ALU_64Bits_Design;

architecture Behavioral of ALU_64Bits_Design is

-- unsigned versions of A and B
signal A_u : unsigned(63 downto 0);
signal B_u : unsigned(63 downto 0);

-- convert lower 6 bits of B to 0-63 for shifting
function to_shift_amt(b : unsigned(63 downto 0)) return natural is
begin
    return to_integer(b(5 downto 0));
end function;

begin
    A_u <= unsigned(Reg_A);
    B_u <= unsigned(Reg_B);

-------------------------------------
-- ALU MAIN
-------------------------------------
process (A_u, B_u, Op_Sel, Carry_In)
    variable result : unsigned(63 downto 0);
    variable c_out  : std_logic := '0';
    variable sum65  : unsigned(64 downto 0);  -- extra bit for carry
begin
    -- defaults
    result := (others => '0');
    c_out  := '0';

    case Op_Sel is
        -- transfer A
        when "0000" =>
            result := A_u;

        -- increment A
        when "0001" =>
            sum65  := ("0" & A_u) + 1;
            result := sum65(63 downto 0);
            c_out  := sum65(64);

        -- decrement A
        when "0010" =>
            sum65  := ("0" & A_u) - 1;
            result := sum65(63 downto 0);
            c_out  := sum65(64);

        -- A + B + Carry_In
        when "0011" =>
            sum65 := ("0" & A_u) + ("0" & B_u);
            if Carry_In = '1' then
                sum65 := sum65 + 1;
            end if;
            result := sum65(63 downto 0);
            c_out  := sum65(64);

        -- NOT A
        when "0100" =>
            result := not A_u;

        -- A AND B
        when "0101" =>
            result := A_u and B_u;

        -- A OR B
        when "0110" =>
            result := A_u or B_u;

        -- A XOR B
        when "0111" =>
            result := A_u xor B_u;

         -- arithmetic right shift A by B
         when "1000" =>
        result := unsigned( shift_right( signed(A_u), to_shift_amt(B_u) ) );

        -- arithmetic left shift A by B
        when "1001" =>
        result := unsigned( shift_left(  signed(A_u), to_shift_amt(B_u) ) );


        -- logical right shift A by B
        when "1010" =>
            result := shift_right(A_u, to_shift_amt(B_u));

        -- logical left shift A by B
        when "1011" =>
            result := shift_left(A_u, to_shift_amt(B_u));

        -- others = safe default
        when others =>
            result := (others => '0');
    end case;

    -- outputs
    ALU_Out   <= std_logic_vector(result);
    Carry_Out <= c_out;
end process;

end Behavioral;
