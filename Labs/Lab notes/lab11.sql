create table info_dept_bms as (select * from info_dept_mst);

alter table info_dept_bms
add numar number;

update info_dept_bms
set numar = 
    (select count(*)
    from employees e
    where e.department_id=id);

create table emp_test_bms
(employee_id number,
last_name varchar2(30),
first_name varchar2(30),
department_id number,
primary key (employee_id),
foreign key (department_id) references departments(department_id));

--drop table dept_test_bms;

create table dept_test_bms
(department_id number,
department_name varchar(100),
primary key (department_id));

create or replace trigger trigger5b_bms
    after delete or update on dept_test_bms
begin
    if deleting then
        stergere_angajati_bms(:old.department_id);
    elsif updating then
        update_angajati_bms(:old.department_id, :new.department_id);
    end if;
end;
/

create or replace procedure stergere_angajati_bms (dep_id number)
as
begin
    delete from emp_test_bms
    where department_id=dep_id;
end;
/

create or replace procedure update_angajati_bms (old_dep_id number, new_dep_id number)
as
begin
    update emp_test_bms
    set department_id=new_dep_id
    where department_id=old_dep_id;
end;
/