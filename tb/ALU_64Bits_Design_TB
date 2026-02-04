library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ALU_64Bits_Design_TB is
--  Port ( );
end ALU_64Bits_Design_TB;

architecture Behavioral of ALU_64Bits_Design_TB is

-- =====================  DUT declaration  ===============================
component ALU_64Bits_Design is
    port(
        Reg_A     : in  STD_LOGIC_VECTOR (63 downto 0);
        Reg_B     : in  STD_LOGIC_VECTOR (63 downto 0);
        Op_Sel    : in  STD_LOGIC_VECTOR (3 downto 0);
        Carry_In  : in  STD_LOGIC;
        Carry_Out : out STD_LOGIC;
        ALU_Out   : out STD_LOGIC_VECTOR (63 downto 0)
    );
end component;

-- =====================  TB signals  ====================================
signal Reg_A_tb     : STD_LOGIC_VECTOR (63 downto 0);
signal Reg_B_tb     : STD_LOGIC_VECTOR (63 downto 0);
signal Op_Sel_tb    : STD_LOGIC_VECTOR (3 downto 0);
signal Carry_In_tb  : STD_LOGIC := '0';
signal Carry_Out_tb : STD_LOGIC;
signal ALU_Out_tb   : STD_LOGIC_VECTOR (63 downto 0);

begin
-- =====================  DUT instantiation  =============================
UUT : ALU_64Bits_Design
    port map(
        Reg_A     => Reg_A_tb,
        Reg_B     => Reg_B_tb,
        Op_Sel    => Op_Sel_tb,
        Carry_In  => Carry_In_tb,
        Carry_Out => Carry_Out_tb,
        ALU_Out   => ALU_Out_tb
    );

-- =====================  Stimulus process  ==============================
Test : process
begin
    ----------------------------------------------------------------------
    -- 0000 : Transfer A
    ----------------------------------------------------------------------
    Op_Sel_tb <= "0000";
    Reg_A_tb  <= x"1111_2222_3333_4444";
    Reg_B_tb  <= (others => '0');
    wait for 10 ns;

    ----------------------------------------------------------------------
    -- 0001 : Increment A
    ----------------------------------------------------------------------
    Op_Sel_tb <= "0001";
    Reg_A_tb  <= x"0000_0000_0000_000F";
    wait for 10 ns;

    ----------------------------------------------------------------------
    -- 0010 : Decrement A
    ----------------------------------------------------------------------
    Op_Sel_tb <= "0010";
    Reg_A_tb  <= x"0000_0000_0000_0010";
    wait for 10 ns;

    ----------------------------------------------------------------------
    -- 0011 : A + B + Carry_In
    ----------------------------------------------------------------------
    Op_Sel_tb    <= "0011";
    Reg_A_tb     <= x"0000_0000_0000_0001";
    Reg_B_tb     <= x"0000_0000_0000_0001";
    Carry_In_tb  <= '1';
    wait for 10 ns;
    Carry_In_tb  <= '0';  -- clear for remaining tests

    ----------------------------------------------------------------------
    -- 0100 : NOT A
    ----------------------------------------------------------------------
    Op_Sel_tb <= "0100";
    Reg_A_tb  <= x"FFFF_FFFF_0000_0000";
    wait for 10 ns;

    ----------------------------------------------------------------------
    -- 0101 : A AND B
    ----------------------------------------------------------------------
    Op_Sel_tb <= "0101";
    Reg_A_tb  <= x"FF00_FF00_FF00_FF00";
    Reg_B_tb  <= x"00FF_00FF_00FF_00FF";
    wait for 10 ns;

    ----------------------------------------------------------------------
    -- 0110 : A OR B
    ----------------------------------------------------------------------
    Op_Sel_tb <= "0110";
    Reg_A_tb  <= x"8000_0000_0000_0000";
    Reg_B_tb  <= x"0000_0000_0000_0001";
    wait for 10 ns;

    ----------------------------------------------------------------------
    -- 0111 : A XOR B
    ----------------------------------------------------------------------
    Op_Sel_tb <= "0111";
    Reg_A_tb  <= x"FFFF_FFFF_FFFF_FFFF";
    Reg_B_tb  <= x"1234_5678_9ABC_DEF0";
    wait for 10 ns;

    ----------------------------------------------------------------------
    -- 1000 : Arithmetic RIGHT shift
    ----------------------------------------------------------------------
    Op_Sel_tb <= "1000";
    Reg_A_tb  <= x"8000_0000_0000_0000";   -- negative when treated as signed
    Reg_B_tb  <= x"0000_0000_0000_0004";   -- shift by 4
    wait for 10 ns;

    ----------------------------------------------------------------------
    -- 1001 : Arithmetic LEFT shift
    ----------------------------------------------------------------------
    Op_Sel_tb <= "1001";
    Reg_A_tb  <= x"7FFF_FFFF_FFFF_FFFF";
    Reg_B_tb  <= x"0000_0000_0000_0002";   -- shift by 2
    wait for 10 ns;

    ----------------------------------------------------------------------
    -- 1010 : Logical RIGHT shift
    ----------------------------------------------------------------------
    Op_Sel_tb <= "1010";
    Reg_A_tb  <= x"F000_0000_0000_0000";
    Reg_B_tb  <= x"0000_0000_0000_0008";   -- shift by 8
    wait for 10 ns;

    ----------------------------------------------------------------------
    -- 1011 : Logical LEFT shift
    ----------------------------------------------------------------------
    Op_Sel_tb <= "1011";
    Reg_A_tb  <= x"0000_0000_0000_0001";
    Reg_B_tb  <= x"0000_0000_0000_0005";   -- shift by 5
    wait for 10 ns;

    ----------------------------------------------------------------------
    -- End simulation
    ----------------------------------------------------------------------
    wait;
end process;

end Behavioral;

