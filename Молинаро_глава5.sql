select table_name
from   all_tables
where  owner = 'HR';

select column_name, data_type, column_id
from all_tab_columns
where owner = 'HR'
and table_name = 'EMPLOYEES'

select table_name, index_name, column_name, column_position
from   sys.all_ind_columns
where  table_name = 'EMPLOYEES'
and    table_owner = 'HR'

select a.table_name,
       a.constraint_name,
       b.column_name,
       a.constraint_type
from   all_constraints a,
       all_cons_columns b
where  a.table_name = 'EMPLOYEES'
and    a.owner = 'HR'
and    a.table_name = b.table_name
and    a.owner = b.owner
and    a.constraint_name = b.constraint_name

select a.table_name,
       a.constraint_name,
       a.column_name,
       c.index_name
from   all_cons_columns a,
       all_constraints b,
       all_ind_columns c
where  a.table_name = 'EMPLOYEES'
and    a.owner = 'HR'
and    b.constraint_type = 'R'
and    a.owner = b.owner
and    a.table_name = b.table_name
and    a.constraint_name = b.constraint_name
and    a.owner = c.table_owner (+)
and    a.table_name = c.table_name (+)
and    a.column_name = c.column_name (+)
--and    c.index_name is null

select   table_name, comments
from     dictionary
order by table_name;

select column_name, comments
from   dict_columns
where  table_name = 'ALL_TAB_COLUMNS';

select   table_name, comments
from     dictionary
where    table_name LIKE '%TABLE%'
order by table_name;
