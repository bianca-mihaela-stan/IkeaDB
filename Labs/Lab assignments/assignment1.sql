--1. a. FALS
--b. ADEVARAT
--c. ADEVARAT

--2. a.FALS
--b. ADEVARAT
--c. FALS
--d. ADEVARAT

--3.a. FALS
--b. ADEVARAT
--c. FALS, acest lucru se intampla doar daca mentionam ON DELETE CASCADE
--d. ADEVARAT

--4.d

--5.d

--6. a

--7. d.

--8. c.

--9. c.

--10. d.

--11.
create table emp_bms as (select * from employees);

comment on table emp_bms is 'Informatii despre angajati';

--12. 

select * from user_tab_comments
where lower(table_name)='emp_bms';

--13.

alter session set nls_date_format = 'dd.mm.yyyy hh:mi:ss';

--14.

select extract(year from sysdate)
from dual;

--15.

select extract(day from sysdate) "day", extract(month from sysdate) "month"
from dual;

--16.

select table_name from user_tables
where table_name like '%_BMS';

