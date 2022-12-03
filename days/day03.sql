declare
    --
    type backpack_r is record
                       (
                           id           number,
                           content      varchar2(128),
                           left_pocket  varchar2(64),
                           right_pocket varchar2(64)
                       );
    --
    type backpack_t is table of backpack_r;
    --
    --
    cursor cs_backpack is
        select line,
               content,
               substr(content, 1, length(content) / 2)  as left_pocket,
               substr(content, length(content) / 2 + 1) as right_pocket
        from aoc_input;
    --
    --
    g_package varchar2(8) := 'day03';
    g_part1 varchar2(8) := 'part1';
    g_part2 varchar2(8) := 'part2';
    --
    g_upper_a number := 65;
    g_upper_z number := 90;
    g_lower_a number := 97;
    g_lower_z number := 122;
    --
    t_backpack backpack_t;
    l_common_item varchar2(1);
    l_priority number;
    l_part1 number := 0;
    l_part2 number := 0;
    --
    --
    function get_common_item(backpack in backpack_r) return varchar2 is
        --
        l_size number;
        --
    begin
        --
        l_size := length(backpack.left_pocket);
        --
        for i in 1..l_size loop
            --
            for j in 1..l_size loop
                --
                if substr(backpack.left_pocket, i, 1) = substr(backpack.right_pocket, j, 1) then
                    --
                    return substr(backpack.left_pocket, i, 1);
                    --
                end if;
                --
            end loop;
            --
        end loop;
        --
        return null;
        --
    end;
    --
    function get_score(p_common_item in varchar2) return number is
        --
        l_item_code number;
        --
    begin
        --
        l_item_code := ascii(p_common_item);
        --
        return case
            when l_item_code <= g_upper_z then l_item_code - g_upper_a + 26 + 1
            when l_item_code <= g_lower_z then l_item_code - g_lower_a + 1
        end;
        --
    end;
    --
begin
    --
    aoc.init(2022, aoc.day03, aoc.puzzle);
    aoc.get_input;
    --
    open cs_backpack;
    fetch cs_backpack bulk collect into t_backpack;
    close cs_backpack;
    --
    aoc.debug(g_package, g_part1, '#backpacks: ' || t_backpack.count);
    --
    for i in t_backpack.first..t_backpack.last loop
        --
        l_common_item := get_common_item(t_backpack(i));
        l_priority := get_score(l_common_item);
        l_part1 := l_part1 + l_priority;
        --
    end loop;
    --
    aoc.debug(g_package, g_part1, 'Part 1: ' || l_part1);
    --
end;

select ascii('p') from dual;

with chars as (
    select 'a' as c from dual union all
    select 'z' as c from dual union all
    select 'A' as c from dual union all
    select 'Z' as c from dual
)
select c, ascii(c)
from chars