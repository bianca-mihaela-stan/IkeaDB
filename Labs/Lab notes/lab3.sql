--9

select project_id
from projects
where deadline<delivery_date

select employee_id
from works_on w
where project_id in (select project_id
                    from projects
                    where deadline<delivery_date);
                    
                    
select distinct e.employee_id
from works_on a
where not exists;

select project_id
from works_on
group by employee_id;

--10
select e.employee_id, w.project_id
from employees e, works_on w
where e.employee_id=w.employee_id(+);


--11
select e.employee_id
from employees e
where e.department_id in (select a.department_id -- departamentele in care lucreaza angajatii care sunt project manager
                          from project p, employees a
                          where p.project_manager=a.employee_id);
                          
--12                      
select e.employee_id
from employees e
where e.department_id not in (select a.department_id -- departamentele in care lucreaza angajatii care sunt project manager
                          from project p, employees a
                          where p.project_manager=a.employee_id);
                          
--13
select e.department_id
from employees e
where e.department_id is not null
group by e.department_id
having avg(e.salary)>3000;


--14.
select e.employee_id, e.first_name, e.last_name, e.salary--detaliile despre acesti manageri
from employees e, 
                (select p.project_manager--id-ul managerilor care au lucrat pe 2 poiecte
                from works_on w, project p
                where w.project_id=p.project_id
                group by p.project_manager
                having count(distinct p.project_id)=2) f
where e.employee_id=f.project_manager;

--15
select distinct a.employee_id
from works_on a
where not exists
(
--proiectele pe care lucreaza angajatul - proiectele la care e manager 102 = multimea vida
    (select distinct b.project_id 
    from works_on b, project c
    where b.project_id=c.project_id
    and b.employee_id=a.employee_id)
    minus
    (select distinct c.project_id 
      from project c
      where c.project_manager=102))
    and not exists 
((select distinct c.project_id 
      from project c
      where c.project_manager=102)
minus
  (select b.project_id
  from works_on b, project c
  where b.project_id=c.project_id
  and b.employee_id=a.employee_id));
      
select distinct a.project_id
from works_on a, project p
where p.project_manager=102
and a.project_id=p.project_id;


      
--16 --a)
select e.last_name nume
from
  (select distinct a.employee_id
  from works_on a
  minus
  select t3.employee_id from
    (select distinct employee_id, project_id
      from (select distinct employee_id from works_on) t1,
          (select distinct p.project_id from project p, works_on w
            where p.project_id=w.project_id
            and w.employee_id=200)
      minus
      select distinct b.employee_id, b.project_id
      from works_on b) t3) rez, employees e
where e.employee_id=rez.employee_id;

--16 --b)
select e.last_name nume
from employees e,
(select distinct a.employee_id
from works_on a
where not exists 
                (select 1
                from project b
                where b.project_id in (select distinct project_id
                                      from works_on u
                                      where u.employee_id=a.employee_id)
                and not exists 
                              (select 1
                              from works_on c, project d
                              where c.project_id=d.project_id
                              and c.employee_id=200
                              and b.project_id=c.project_id))) i
where e.employee_id=i.employee_id;

--17
select e.last_name nume
from employees e,
(select distinct a.employee_id
from works_on a
where not exists 
                (select 1
                from project b
                where b.project_id in (select distinct project_id
                                      from works_on u
                                      where u.employee_id=a.employee_id)
                and not exists 
                              (select 1
                              from works_on c, project d
                              where c.project_id=d.project_id
                              and c.employee_id=200
                              and b.project_id=c.project_id))) i
where e.employee_id=i.employee_id;

--18
create table emp_bms as select * from departments;
create table dep_bms as select * from departments;