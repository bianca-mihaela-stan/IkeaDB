select department_name, country_name
from departments d join locations l on (d.location_id=l.location_id)
join countries c on (c.country_id = l.country_id)
join employees e on (e.department_id = d.department_id)
group by department_name, country_name
having count(*) = (select max(count(*))--numarul maxim de angajati dintr-un departament
                   from employees
                   group by department_id);
                   
                   
--care este numarul de angajati care sunt sefi
select count(distinct manager_id)
from employees
where manager_id is not null;

select distinct manager_id
from employees
where manager_id is not null;

--sa se calculeze comisionul mediu final din firma
select avg(nvl(commission_pct, 0))
from employees;

--Scrie?i o cerere pentru a afi?a job-ul, salariul total pentru job-ul respectiv pe departamente si salariul total pentru job-ul respectiv pe departamentele 30, 60, 90. Se vor eticheta coloanele corespunz?tor. Rezultatul va ap?rea sub forma de mai jos:
--Job Dep30 Dep60 Dep90 Total
------------------------------------------------------------------------------ 

select job_id "Job",  
        (select nvl(sum(salary),0)--daca job-ul asta nu se afla la dep X am pus salariu toatl 0
         from employees e1
         where e1.job_id=e.job_id
         and e1.department_id=30) "Dep30", (select nvl(sum(salary),0)
                                             from employees e2
                                             where e2.job_id=e.job_id
                                             and e2.department_id=60) "Dep60", (select nvl(sum(salary),0)
                                                                                 from employees e3
                                                                                 where e3.job_id=e.job_id
                                                                                 and e3.department_id=90) "Dep90", (select sum(salary)
                                                                                                                    from employees e4
                                                                                                                    where e4.job_id=e.job_id) "Total"
from employees e
group by job_id;

--8. S? se afi?eze numele departamentelor, titlurile job-urilor ?i valoarea medie a salariilor,
--pentru:
-- fiecare departament ?i, în cadrul s?u pentru fiecare job;
-- fiecare departament (indiferent de job);
-- întreg tabelul.

--tema: an 2 recapitulare 1

proiect 12 cerinte pt 6 si optional (individual), proiect incarcat in teams
bonus lab

teme lab+proiect 40%
