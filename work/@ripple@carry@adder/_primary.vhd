library verilog;
use verilog.vl_types.all;
entity RippleCarryAdder is
    generic(
        WIDTH           : integer := 11
    );
    port(
        a               : in     vl_logic_vector;
        b               : in     vl_logic_vector;
        sum             : out    vl_logic_vector;
        cout            : out    vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of WIDTH : constant is 1;
end RippleCarryAdder;
