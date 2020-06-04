create or replace package PKG_SAMPLE_13 is

  PROCEDURE sample1(o_cursor OUT SYS_REFCURSOR);
  PROCEDURE sample2(o_cursor OUT SYS_REFCURSOR);
  PROCEDURE sample3(o_cursor OUT SYS_REFCURSOR);
  PROCEDURE sample4(o_cursor OUT SYS_REFCURSOR);
  PROCEDURE sample5(o_cursor OUT SYS_REFCURSOR);
  PROCEDURE sample6(o_cursor OUT SYS_REFCURSOR);
  PROCEDURE sample7(o_cursor OUT SYS_REFCURSOR);

end PKG_SAMPLE_13;
/
create or replace package body PKG_SAMPLE_13 is

  PROCEDURE sample1(o_cursor OUT SYS_REFCURSOR) is
  begin
    OPEN o_cursor FOR
      select a.last_name emp, b.last_name mgr
      from   employees a, employees b
      where  a.manager_id = b.employee_id (+);
  end;

  PROCEDURE sample2(o_cursor OUT SYS_REFCURSOR) is
  begin
    OPEN o_cursor FOR
      select last_name, employee_id, manager_id
      from   employees
      where  last_name in ('King','Kochhar','Greenberg') and employee_id <> 156;
  end;
  
  PROCEDURE sample3(o_cursor OUT SYS_REFCURSOR) is
  begin
    OPEN o_cursor FOR
      select ltrim(sys_connect_by_path(last_name,'-->'), '-->') leaf___branch___root
      from   employees
      where  level = 3
      start with last_name = 'Greenberg'
      connect by prior manager_id = employee_id;
  end;

  PROCEDURE sample4(o_cursor OUT SYS_REFCURSOR) is
  begin
    OPEN o_cursor FOR
      select ltrim(sys_connect_by_path(last_name,' - '), ' - ') emp_tree
      from employees
      start with manager_id is null
      connect by prior employee_id = manager_id
      order by 1;
  end;
  
  PROCEDURE sample5(o_cursor OUT SYS_REFCURSOR) is
  begin
    OPEN o_cursor FOR
      select lpad('.',2*level,'.')||last_name emp_tree
      from employees
      start with manager_id is null
      connect by prior employee_id = manager_id;
  end;   
  
  PROCEDURE sample6(o_cursor OUT SYS_REFCURSOR) is
  begin
    OPEN o_cursor FOR
      select last_name
      from employees
      start with last_name = 'De Haan'
      connect by prior employee_id = manager_id;
  end;
  
  PROCEDURE sample7(o_cursor OUT SYS_REFCURSOR) is
  begin
    OPEN o_cursor FOR
      select last_name,
             connect_by_isleaf is_leaf,
             (select count(*)
              from   employees e2
              where  e2.manager_id = e.employee_id
              and    e.manager_id is not null
              and    rownum = 1) is_branch,
              decode(employee_id, connect_by_root(employee_id),1,0) is_root
      from employees e
      start with manager_id is null
      connect by prior employee_id = manager_id
      order by 4 desc, 3 desc;
  end;

end PKG_SAMPLE_13;
/
