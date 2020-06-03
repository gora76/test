select a.last_name emp, b.last_name mgr
from   employees a, employees b
where  a.manager_id = b.employee_id (+)

select last_name, employee_id, manager_id
from   employees
where  last_name in ('King','Kochhar','Greenberg') and employee_id <> 156

select ltrim(sys_connect_by_path(last_name,'-->'), '-->') leaf___branch___root
from   employees
where  level = 3
start with last_name = 'Greenberg'
connect by prior manager_id = employee_id

select ltrim(sys_connect_by_path(last_name,' - '), ' - ') emp_tree
from employees
start with manager_id is null
connect by prior employee_id = manager_id
order by 1

select lpad('.',2*level,'.')||last_name emp_tree
from employees
start with manager_id is null
connect by prior employee_id = manager_id

select last_name
from employees
start with last_name = 'De Haan'
connect by prior employee_id = manager_id 

select last_name,
       connect_by_isleaf is_leaf,
       (select count(*)
        from   employees e2
        where  e2.manager_id = e.employee_id
        and    e.manager_id is not null
        and    rownum = 1) is_branch,
        decode(last_name, connect_by_root(last_name),1,0) is_root,
        decode(employee_id, connect_by_root(employee_id),1,0) is_root2
from employees e
start with manager_id is null
connect by prior employee_id = manager_id
order by 4 desc, 3 desc

