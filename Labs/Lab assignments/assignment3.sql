--18
create table emp_bms as select * from employees;
create table dep_bms as select * from departments;
alter table emp_bms
add constraint constraint1 foreign key (department_id) references departments(department_id);
alter table emp_bms
add constraint constraint4 primary key (employee_id);
alter table emp_bms
add constraint constraint6 foreign key (job_id) references jobs(job_id);
alter table emp_bms
add constraint constraint9 foreign key (manager_id) references employees(employee_id);
alter table emp_bms
add constraint constraint10 check (salary>=0); --aici trebuie sa pun >= ca altfel nu merge sa pun default 0 la exerctiul 27

alter table dep_bms
add constraint constraint2 primary key (department_id);
alter table dep_bms
add constraint constraint3 foreign key (location_id) references locations(location_id);
alter table dep_bms
add constraint constraint5 foreign key (manager_id) references employees(employee_id);


rollback;


--19
alter table emp_bms
modify (salary not null);

--20
insert into emp_bms (employee_id, last_name, email, hire_date, job_id, salary)
values (10, 'Rock', 'paul.rock@gmail.com', to_date('10.11.2007', 'dd.mm.yyyy'), 'AD_PRES', 700);

--21
savepoint a;

--22
variable x number
delete from emp_bms
where salary = (select min(salary)
                from emp_bms)
returning salary into :x;

print x;

--23
savepoint b;

--24
variable x number
delete from emp_bms
where employee_id =
                    (select b.employee_id
                    from (
                            select min(salary-(select avg(salary)from employees)) nr
                            from emp_bms
                          ) a, emp_bms b
                    where b.salary-(select avg(salary)from employees)=a.nr)
returning employee_id into :x;

print x;


--25
rollback to savepoint b;

--26
update emp_bms
set salary=1.1*salary
where employee_id=
                    (select b.manager_id
                    from emp_bms a, dep_bms b
                    where a.department_id=b.department_id
                    group by a.department_id, b.manager_id
                    having count(*)= (   select max(nr)
                                        from
                                                (select b.manager_id, a.department_id, count(*) nr
                                                from emp_bms a, dep_bms b
                                                where a.department_id=b.department_id
                                                group by a.department_id, b.manager_id) c, emp_bms d
                                        where c.manager_id=d.employee_id));
                                        
--27
alter table emp_bms
modify salary default 0;


update emp_bms
set salary = default
where employee_id=
                    (select max(employee_id)
                    from emp_bms);
                    
--28
create view vizualizare_bms as 
select a.employee_id "id", a.last_name "nume", a.email "email", a.job_id "job", a.hire_date "data_angajarii", b.department_name "nume_departament", b.department_id "departament"
from employees a, departments b
where a.department_id=b.department_id;

insert into vizualizare_bms (id, nume, email, job , data_angajarii)--aici nu merge
values (10, 'Rock', 'paul.rock@gmail.com', 'AD_PRES', to_date('10.11.2007', 'dd.mm.yyyy'));

--din descrierea vizualizarii observ ca doar coloanele nume_departament si departament 
--nu sunt insertable sau updateable

--29

--varianta 1: not exists
select distinct employee_id
from works_on a
where not exists (select 1
                  from project p
                  where p.budget=10000
                  and not exists (select 'x'
                                  from works_on b
                                  where b.project_id=p.project_id
                                  and b.employee_id=a.employee_id));
                                  
--varianta 2: count               
select employee_id
from works_on
where project_id in (select project_id
                    from project
                    where budget=10000)
group by employee_id
having count(project_id)=(select count(*)
                          from project
                          where budget=10000);
                    
--varianta 3: minus
select employee_id
from works_on
minus
select employee_id from
((select employee_id, project_id
from (select distinct employee_id from works_on) t1,
      (select project_id from project where budget=10000) t2
      order by 2)
      minus
      select employee_id, project_id from works_on) t3;
      
--30
--varianta 1
select distinct w.employee_id
from works_on w
where not exists(
  (select project_id
  from project p
  where p.start_date>='1-jan-2006'
  and p.start_date<'1-jul-2006')
  minus
  (select p.project_id
  from project p, works_on b
  where p.project_id=b.project_id
  and b.employee_id=w.employee_id));
  
  
--varianta 2
select employee_id
from works_on
minus
select employee_id from
  (select employee_id, project_id
  from (select distinct employee_id from works_on) t1,
        (select project_id from project p where p.start_date>='1-jan-2006'
                                        and p.start_date<'1-jul-2006') t2
  minus
  select employee_id, project_id from works_on) t3;
  
--varianta 3
select employee_id
from works_on
where project_id in (select project_id
                    from project p
                    where p.start_date>='1-jan-2006'
                    and p.start_date<'1-jul-2006')
group by employee_id
having count(project_id)=(select count(*)
                          from project p
                          where p.start_date>='1-jan-2006'
                          and p.start_date<'1-jul-2006');
            
--varianta 4
select distinct employee_id
from works_on a
where not exists (select 1
                  from project p
                  where p.start_date>='1-jan-2006'
                  and p.start_date<'1-jul-2006'
                  and not exists (select 1
                                  from works_on b
                                  where b.project_id=p.project_id
                                  and b.employee_id=a.employee_id));
                                  
--31
select a.project_id
from project a
where not exists (select 1
                  from (select b.employee_id
                        from job_history b
                        group by b.employee_id
                        having count(*)>=2) c
                   where not exists (select 1
                                     from works_on d
                                     where d.employee_id=c.employee_id
                                     and d.project_id=a.project_id));
