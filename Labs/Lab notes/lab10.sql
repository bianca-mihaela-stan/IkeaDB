create or replace procedure p5_bms
(arr OUT v_arr)
as
v_ziua varchar2(20);
begin
with nr_zi as (select count(*) nr, to_char(hire_date, 'day') zi
                from employees
                group by to_char(hire_date, 'day'))
select last_name, first_name, round(sysdate-hire_date), salary
bulk collect into arr
from employees
where to_char(hire_date, 'day')=(select zi
                                from nr_zi
                                where nr=(select max(nr)
                                         from nr_zi));
end;
/

declare
begin
p_bms();
end;
/
create or replace type ob_bms is object (nume varchar(25), prenume varchar(25), vechime number(5,2), venit number(8,2)); 
create or replace type v_arr is varray(10000) of ob_bms;