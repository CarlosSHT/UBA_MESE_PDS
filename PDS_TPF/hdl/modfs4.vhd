----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11.12.2023 04:12:18
-- Design Name: 
-- Module Name: modFS4 - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity modfs4 is
	generic (
          DATA_IN_WIDTH     : integer := 16;
          DATA_OUT_WIDTH    : integer := 16
	);
	  
    Port ( 	clk_i 	: IN std_logic;
			reset_i: IN std_logic;
			data_i 	: in STD_LOGIC_VECTOR (127 downto 0);
			data_q 	: in STD_LOGIC_VECTOR (127 downto 0);
			out_in 	: out STD_LOGIC_VECTOR (127 downto 0);
			out_qn 	: out STD_LOGIC_VECTOR (127 downto 0));
end modfs4;

architecture Behavioral of modfs4 is
signal out_i1, out_i2, out_i3, out_i4, out_i5, out_i6, out_i7, out_i8 : std_logic_vector(DATA_OUT_WIDTH-1 downto 0) := (others => '0');
signal out_q1, out_q2, out_q3, out_q4, out_q5, out_q6, out_q7, out_q8 : std_logic_vector(DATA_OUT_WIDTH-1 downto 0) := (others => '0');



signal bufa : signed(15 downto 0);
begin
	process(clk_i, reset_i)
	begin
		if reset_i = '1' then 
            out_in <= (others => '0');
            out_qn <= (others => '0');
		elsif rising_edge(clk_i) then
		

			-- 0 GRADOS
            -- out_i1 <= std_logic_vector(to_signed( (to_integer(signed(sample_i1)) * 1 - to_integer(signed(sample_q1)) * 0) , DATA_IN_WIDTH ));
            -- out_q1 <= std_logic_vector(to_signed( (to_integer(signed(sample_i1)) * 0 + to_integer(signed(sample_q1)) * 1) , DATA_IN_WIDTH ));
            out_i1 <= std_logic_vector(to_signed(to_integer(signed(data_i(127 downto 112))), DATA_IN_WIDTH));
            out_q1 <= std_logic_vector(to_signed(to_integer(signed(data_q(127 downto 112))), DATA_IN_WIDTH));
			
			-- pi/2
            -- out_i2 <= std_logic_vector(to_signed( (to_integer(signed(sample_i1)) * 0 - to_integer(signed(sample_q1)) * 1) , DATA_IN_WIDTH ));
            -- out_q2 <= std_logic_vector(to_signed( (to_integer(signed(sample_i1)) * 1 + to_integer(signed(sample_q1)) * 0) , DATA_IN_WIDTH ));
            out_i2 <= std_logic_vector(to_signed( to_integer(signed(data_q ( 111 downto 96))) * to_integer(to_signed(-1,DATA_IN_WIDTH)), DATA_IN_WIDTH ));
            out_q2 <= std_logic_vector(to_signed( to_integer(signed(data_i ( 111 downto 96))) , DATA_IN_WIDTH ));
			
			-- pi
            -- out_i3 <= std_logic_vector(to_signed( (to_integer(signed(sample_i1)) * -1 - to_integer(signed(sample_q1)) * 0) , DATA_IN_WIDTH ));
            -- out_q3 <= std_logic_vector(to_signed( (to_integer(signed(sample_i1)) * 0 + to_integer(signed(sample_q1)) * -1) , DATA_IN_WIDTH ));
            out_i3 <= std_logic_vector(to_signed( to_integer(signed(data_i ( 95 downto 80))) *  to_integer(to_signed(-1,DATA_IN_WIDTH)) , DATA_IN_WIDTH ));
            out_q3 <= std_logic_vector(to_signed( to_integer(signed(data_q ( 95 downto 80))) *  to_integer(to_signed(-1,DATA_IN_WIDTH)) , DATA_IN_WIDTH ));
			
			-- 3pi/2
            -- out_i4 <= std_logic_vector(to_signed( (to_integer(signed(sample_i1)) * 0 - to_integer(signed(sample_q1)) * -1) , DATA_IN_WIDTH ));
            -- out_q4 <= std_logic_vector(to_signed( (to_integer(signed(sample_i1)) * -1 + to_integer(signed(sample_q1)) * 0) , DATA_IN_WIDTH ));
            out_i4 <= std_logic_vector(to_signed( to_integer(signed(data_q ( 79 downto 64))) , DATA_IN_WIDTH ));
            out_q4 <= std_logic_vector(to_signed( to_integer(signed(data_i ( 79 downto 64))) *  to_integer(to_signed(-1,DATA_IN_WIDTH))  , DATA_IN_WIDTH ));
			
            out_i5 <= std_logic_vector(to_signed( to_integer(signed(data_i ( 63 downto 48))) , DATA_IN_WIDTH ));
            out_q5 <= std_logic_vector(to_signed( to_integer(signed(data_q ( 63 downto 48))) , DATA_IN_WIDTH ));
            out_i6 <= std_logic_vector(to_signed( to_integer(signed(data_q ( 47 downto 32))) * to_integer(to_signed(-1,DATA_IN_WIDTH)), DATA_IN_WIDTH ));
            out_q6 <= std_logic_vector(to_signed( to_integer(signed(data_i ( 47 downto 32))) , DATA_IN_WIDTH ));
            out_i7 <= std_logic_vector(to_signed( to_integer(signed(data_i ( 31 downto 16))) *  to_integer(to_signed(-1,DATA_IN_WIDTH)) , DATA_IN_WIDTH ));
            out_q7 <= std_logic_vector(to_signed( to_integer(signed(data_q ( 31 downto 16))) *  to_integer(to_signed(-1,DATA_IN_WIDTH)) , DATA_IN_WIDTH ));
            out_i8 <= std_logic_vector(to_signed( to_integer(signed(data_q ( 15 downto 0))) , DATA_IN_WIDTH ));
            out_q8 <= std_logic_vector(to_signed( to_integer(signed(data_i ( 15 downto 0))) *  to_integer(to_signed(-1,DATA_IN_WIDTH))  , DATA_IN_WIDTH ));
			
	        -- out_in(127 downto 112) 	<= out_i1 ;
            out_in <= out_i1 & out_i2 & out_i3 & out_i4 & out_i5 & out_i6 & out_i7 & out_i8;
            out_qn <= out_q1 & out_q2 & out_q3 & out_q4 & out_q5 & out_q6 & out_q7 & out_q8;
		end if;
		
	end process;
	-- out_in(127 downto 112) 	<= out_i1 ;
	--out_in(111 downto 95) 	<= out_i2 ;
	--out_in(95 downto 80) 	<= out_i3 ;
	--out_in(79 downto 64) 	<= out_i4 ;
	--out_in(63 downto 48) 	<= out_i5 ;
	--out_in(47 downto 32) 	<= out_i5 ;
	--out_in(31 downto 16) 	<= out_i6 ;
	--out_in(15 downto 0) 	<= out_i7 ;
	
	--out_in <= out_i1 & out_i2 & out_i3 & out_i4 & out_i5 & out_i6 & out_i7 & out_i8;
	--out_qn <= out_q1 & out_q2 & out_q3 & out_q4 & out_q5 & out_q6 & out_q7 & out_q8;

end architecture Behavioral;