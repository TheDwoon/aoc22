create table aoc_input (
    LINE NUMBER,
    CONTENT VARCHAR2(4000)
)
/
create unique index aoc_input_u1 on aoc_input(LINE);
/