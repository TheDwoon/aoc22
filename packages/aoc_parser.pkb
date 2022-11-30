create or replace package body aoc_parser is
    --
    g_package constant varchar2(16) := 'aoc_parser';
    g_rule_seq number := 0;
    --
    --
    procedure debug(
        p_method in varchar2,
        p_message in varchar2
    ) is
        --
        --
    begin
        --
        aoc.debug(g_package, p_method, p_message);
        --
    end;
    --
    function add_rule(
        p_op_code in number,
        p_name in varchar2,
        p_argument in varchar2,
        p_discard in boolean := false
    ) return number is
        --
        l_method constant varchar2(16) := 'add_rule';
        r_rule rule_r;
        --
    begin
        --
        r_rule.rule_id := g_rule_seq + 1;
        g_rule_seq := g_rule_seq + 1;
        --
        if p_op_code is null or p_name is null or p_argument is null or p_discard is null then
            --
            debug(l_method, 'invalid argument passed:');
            debug(l_method, 'p_op_code: ' || p_op_code);
            debug(l_method, 'p_name: ' || p_name);
            debug(l_method, 'p_argument: ' || p_argument);
            debug(l_method, 'p_discard: ' || case when p_discard then 'true' else 'false' end);
            --
            raise g_parser_exception;
            --
        end if;
        --
        r_rule.op_code := p_op_code;
        r_rule.name := p_name;
        r_rule.argument := p_argument;
        r_rule.discard := p_discard;
        --
        return r_rule.rule_id;
        --
    end;
    --
end;