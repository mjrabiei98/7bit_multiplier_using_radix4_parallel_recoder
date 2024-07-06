library verilog;
use verilog.vl_types.all;
entity muliplicand_gen is
    port(
        x               : in     vl_logic_vector(6 downto 0);
        one             : in     vl_logic;
        two             : in     vl_logic;
        sign            : in     vl_logic;
        \out\           : out    vl_logic_vector(8 downto 0)
    );
end muliplicand_gen;
