declare
    --
    g_me_rock varchar2(4) := 'X';
    g_me_paper varchar2(4) := 'Y';
    g_me_scissor varchar2(4) := 'Z';
    g_elf_rock varchar2(4) := 'A';
    g_elf_paper varchar2(4) := 'B';
    g_elf_scissor varchar2(4) := 'C';
    --
    g_action_lose varchar2(4) := 'X';
    g_action_draw varchar2(4) := 'Y';
    g_action_win varchar2(4) := 'Z';
    --
    g_win number := 6;
    g_draw number := 3;
    g_lose number := 0;
    --
    part1 number := 0;
    part2 number := 0;
    --
    function get_points(elf in varchar2, me in varchar2) return number is
        --
        l_points number := 0;
        --
    begin
        --
        l_points := case
            when me = g_me_rock then 1
            when me = g_me_paper then 2
            when me = g_me_scissor then 3
        end;
        --
        l_points := l_points + case
            when me = g_me_rock    and elf = g_elf_scissor  then g_win
            when me = g_me_paper   and elf = g_elf_rock     then g_win
            when me = g_me_scissor and elf = g_elf_paper    then g_win
            when me = g_me_rock    and elf = g_elf_rock     then g_draw
            when me = g_me_paper   and elf = g_elf_paper    then g_draw
            when me = g_me_scissor and elf = g_elf_scissor  then g_draw
            when me = g_me_scissor and elf = g_elf_rock     then g_lose
            when me = g_me_rock    and elf = g_elf_paper    then g_lose
            when me = g_me_paper   and elf = g_elf_scissor  then g_lose
        end;
        --
        return l_points;
        --
    end get_points;
    --
    function get_action(elf in varchar2, me in varchar2) return varchar2 is
        --
        l_action varchar2(4);
        --
    begin
        --
        l_action := case
            when elf = g_elf_rock       and me = g_action_lose  then g_me_scissor
            when elf = g_elf_rock       and me = g_action_draw  then g_me_rock
            when elf = g_elf_rock       and me = g_action_win   then g_me_paper
            when elf = g_elf_paper      and me = g_action_lose  then g_me_rock
            when elf = g_elf_paper      and me = g_action_draw  then g_me_paper
            when elf = g_elf_paper      and me = g_action_win   then g_me_scissor
            when elf = g_elf_scissor    and me = g_action_lose  then g_me_paper
            when elf = g_elf_scissor    and me = g_action_draw  then g_me_scissor
            when elf = g_elf_scissor    and me = g_action_win   then g_me_rock
        end;
        --
        return l_action;
        --
    end;
    --
begin
    --
    aoc.init(2022, aoc.day02, aoc.puzzle);
    aoc.get_input;
    --
    for r_line in (select content from aoc_input) loop
        --
        part1 := part1 + get_points(substr(r_line.content, 1, 1), substr(r_line.content, 3, 1));
        --
    end loop;
    --
    aoc.debug('day02', 'part1', 'Part 1: ' || part1);
    --
    for r_line in (select content from aoc_input) loop
        --
        part2 := part2 + get_points(substr(r_line.content, 1, 1), get_action(substr(r_line.content, 1, 1), substr(r_line.content, 3, 1)));
        --
    end loop;
    --
    aoc.debug('day02', 'part2', 'Part 2: ' || part2);
    --
end;

select * from aoc_debug where batch_id = (select max(batch_id) from aoc_debug)
order by log_id desc;