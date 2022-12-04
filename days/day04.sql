declare
    --
    part1 number;
    part2 number;
    --
begin
    --
    aoc.init(2022, aoc.day04, aoc.puzzle);
    aoc.get_input;
    --
    select count(*) into part1
        from (
            select line,
                   content,
                   to_number(substr(content, 1, instr(content, '-', 1, 1) - 1)) as FIRST_RANGE_LEFT,
                   to_number(substr(content, instr(content, '-', 1, 1) + 1, (instr(content, ',')) - (instr(content, '-', 1, 1) + 1))) as FIRST_RANGE_RIGHT,
                   to_number(substr(content, instr(content, ',') + 1, (instr(content, '-', 1, 2)) - (instr(content, ',') + 1))) as SECOND_RANGE_LEFT,
                   to_number(substr(content, instr(content, '-', 1, 2) + 1)) as SECOND_RANGE_RIGHT
            from aoc_input
        ) input
    where (first_range_left <= second_range_left and first_range_right >= second_range_right)
        or
        (first_range_left >= second_range_left and first_range_right <= second_range_right);
    --
    aoc.debug('day04', 'part1', 'Part 1: ' || part1);
    --
    select count(*) into part2
        from (
            select line,
                   content,
                   to_number(substr(content, 1, INSTR(content, '-', 1, 1) - 1)) as FIRST_RANGE_LEFT,
                   to_number(substr(content, INSTR(content, '-', 1, 1) + 1, (INSTR(content, ',')) - (INSTR(content, '-', 1, 1) + 1))) as FIRST_RANGE_RIGHT,
                   to_number(substr(content, INSTR(content, ',') + 1, (INSTR(content, '-', 1, 2)) - (INSTR(content, ',') + 1))) as SECOND_RANGE_LEFT,
                   to_number(substr(content, INSTR(content, '-', 1, 2) + 1)) as SECOND_RANGE_RIGHT
            from aoc_input
        ) input
    where not least(first_range_right, second_range_right) < greatest(second_range_left, first_range_left);
    --
    aoc.debug('day04', 'part2', 'Part 2: ' || part2);
    --
end;
