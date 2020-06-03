create or replace package PKG_SAMPLE_5 is

  PROCEDURE sample1(o_cursor OUT SYS_REFCURSOR);
  PROCEDURE sample2(o_cursor OUT SYS_REFCURSOR);
  PROCEDURE sample3(o_cursor OUT SYS_REFCURSOR);
  PROCEDURE sample4(o_cursor OUT SYS_REFCURSOR);
  PROCEDURE sample5(o_cursor OUT SYS_REFCURSOR);
  PROCEDURE sample6(o_cursor OUT SYS_REFCURSOR);
  PROCEDURE sample7(o_cursor OUT SYS_REFCURSOR);
  PROCEDURE sample8(o_cursor OUT SYS_REFCURSOR);

end PKG_SAMPLE_5;
/
create or replace package body PKG_SAMPLE_5 is

  PROCEDURE sample1(o_cursor OUT SYS_REFCURSOR) is
  begin
   OPEN o_cursor FOR
     SELECT table_name
     FROM   all_tables
     WHERE  owner = 'HR';
  end;

  PROCEDURE sample2(o_cursor OUT SYS_REFCURSOR) is
  begin
   OPEN o_cursor FOR
     select column_name, data_type, column_id
     from   all_tab_columns
     where  owner = 'HR'
     and    table_name = 'EMPLOYEES';
  end;
  
  PROCEDURE sample3(o_cursor OUT SYS_REFCURSOR) is
  begin
   OPEN o_cursor FOR
     select table_name, index_name, column_name, column_position
     from   sys.all_ind_columns
     where  table_name = 'EMPLOYEES'
     and    table_owner = 'HR';
  end;

  PROCEDURE sample4(o_cursor OUT SYS_REFCURSOR) is
  begin
   OPEN o_cursor FOR
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
     and    a.constraint_name = b.constraint_name;
  end;
  
  PROCEDURE sample5(o_cursor OUT SYS_REFCURSOR) is
  begin
   OPEN o_cursor FOR
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
     and    a.column_name = c.column_name (+);
     --and    c.index_name is null
  end;   
  
  PROCEDURE sample6(o_cursor OUT SYS_REFCURSOR) is
  begin
   OPEN o_cursor FOR
     select   table_name, comments
     from     dictionary
     order by table_name;
  end;
  
  PROCEDURE sample7(o_cursor OUT SYS_REFCURSOR) is
  begin
   OPEN o_cursor FOR
     select column_name, comments
     from   dict_columns
     where  table_name = 'ALL_TAB_COLUMNS';
  end;   

  PROCEDURE sample8(o_cursor OUT SYS_REFCURSOR) is
  begin
   OPEN o_cursor FOR
     select   table_name, comments
     from     dictionary
     where    table_name LIKE '%TABLE%'
     order by table_name;
  end;

end PKG_SAMPLE_5;
/
