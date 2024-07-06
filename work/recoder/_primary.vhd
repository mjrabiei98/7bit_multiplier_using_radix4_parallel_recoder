library verilog;
use verilog.vl_types.all;
entity recoder is
    port(
        y               : in     vl_logic_vector(2 downto 0);
        sign            : out    vl_logic;
        one             : out    vl_logic;
        two             : out    vl_logic
    );
end recoder;
