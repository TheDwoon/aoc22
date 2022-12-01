declare
    cursor cs_elf_snack_sum is
        with inventory_borders as (select 0 as line
                                   from dual
                                   union all
                                   select line
                                   from aoc_input
                                   where content is null
                                   union all
                                   select max(line) + 1 as line
                                   from aoc_input),
             inventory_elfs as (select row_number() over (order by ib_start.line)                                  as elf,
                                       ib_start.line                                                               as inv_start,
                                       (select min(line)
                                        from inventory_borders ib_end
                                        where line > ib_start.line)                                                as inv_end
                                from inventory_borders ib_start),
             elf_snacks as (select ie.elf, to_number(ai.content) as snack
                            from inventory_elfs ie
                                     inner join aoc_input ai
                                                on (ai.line > ie.inv_start and ai.line < ie.inv_end)),
             elf_snack_sum as (select elf, sum(snack) as snack_sum
                               from elf_snacks
                               group by elf)
        select *
        from elf_snack_sum
        order by snack_sum desc;
    --
    first_elf cs_elf_snack_sum%rowtype;
    second_elf cs_elf_snack_sum%rowtype;
    third_elf cs_elf_snack_sum%rowtype;
begin
    --
    aoc.init(2022, aoc.day01, aoc.puzzle);
    aoc.get_input;
    --
    open cs_elf_snack_sum;
    fetch cs_elf_snack_sum into first_elf;
    fetch cs_elf_snack_sum into second_elf;
    fetch cs_elf_snack_sum into third_elf;
    close cs_elf_snack_sum;
    --
    aoc.debug('day01', 'part1', 'Most snacks has elf ' || first_elf.elf
                                    || ' with ' || first_elf.snack_sum || ' calories');
    --
    aoc.debug('day01', 'part2', 'The elfs are: '
                                    || first_elf.elf || ', ' || second_elf.elf || ', ' || third_elf.elf
                                    || ' with ' || (first_elf.snack_sum + second_elf.snack_sum + third_elf.snack_sum) || ' calories');
    --
end;