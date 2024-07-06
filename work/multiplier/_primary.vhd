library verilog;
use verilog.vl_types.all;
entity multiplier is
    port(
        x               : in     vl_logic_vector(6 downto 0);
        y               : in     vl_logic_vector(6 downto 0);
        \out\           : out    vl_logic_vector(14 downto 0)
    );
end multiplier;
