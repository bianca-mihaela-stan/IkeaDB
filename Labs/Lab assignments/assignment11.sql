--punctul b

--signatura pachetului
create or replace package pachet2_bms
as
procedure mutare_angajat( lname employees.last_name%type, fname employees.first_name%type, department_name departments.department_name%type, job_title jobs.job_title%type,  lname_manager employees.last_name%type, fname_manager employees.first_name%type);
function get_salariu(cod_dep departments.department_id%type, cod_job jobs.job_id%type) return number;
function get_comision(cod_dep departments.department_id%type, cod_job jobs.job_id%type) return number;
procedure add_to_job_history(cod_emp employees.employee_id%type, hire_date employees.hire_date%type, cod_job jobs.job_id%type, cod_dep departments.department_id%type);
function f_emp ( lname employees.last_name%type, fname employees.first_name%type) return number;
function f_manager(fname employees.first_name%TYPE, lname employees.last_name%TYPE) return number;
end pachet2_bms;

--corpul pachetului

create or replace package body pachet2_bms
as
procedure mutare_angajat( lname employees.last_name%type, fname employees.first_name%type, department_name departments.department_name%type, job_title jobs.job_title%type,  lname_manager employees.last_name%type, fname_manager employees.first_name%type)
is
    v_cod number;
    v_cod_manager number;
    v_hire_date date;
    v_old_dep number;
    v_old_job varchar2(50);
    v_new_dep number;
    v_new_job varchar2(50);
    v_new_sal number;
    v_old_sal number;
begin
    dbms_output.put_line('Incep mutarea lui '|| fname || ' '|| lname);
    v_cod:=f_emp(lname, fname);
    dbms_output.put_line('Codul: '||v_cod);
    v_cod_manager:=f_manager(fname_manager, lname_manager);
    
    select employee_id, hire_date, department_id, job_id, salary
    into v_cod, v_hire_date, v_old_dep, v_old_job, v_old_sal
    from emp_bms
    where employee_id=v_cod;

    dbms_output.put_line('Jobul vechi: '||v_old_job);
    dbms_output.put_line('Departamentul vechi: '||v_old_dep);
    v_new_dep:=pachet1_bms.f_dep(department_name);
    v_new_job:=pachet1_bms.f_job(job_title);
    dbms_output.put_line('Jobul nou: '||v_new_job);
    dbms_output.put_line('Departamentul nou: '||v_new_dep);

    v_new_sal:=get_salariu(v_new_dep, v_new_job);
    if v_new_sal<v_old_sal then
        v_new_sal:=v_old_sal;
    end if;
    dbms_output.put_line('Salariul vechi: '||v_old_sal);
    dbms_output.put_line('Salariul nou: '||v_new_sal);

    update emp_bms
    set department_id=v_new_dep,
        job_id=v_new_job,
        salary=v_new_sal,
        commission_pct=get_comision(v_new_dep, v_new_job),
        manager_id=v_cod_manager,
        hire_date=sysdate
    where employee_id=v_cod;
    
    add_to_job_history(v_cod, v_hire_date, v_old_job, v_old_dep);
    
    exception
        when no_data_found then
            raise_application_error(-20001, 'Nu exista angajati cu codul '|| v_cod);
        when others then
            raise_application_error(-20002, 'Alta eroare! (mutare angajat)');
end mutare_angajat;

function get_salariu(cod_dep departments.department_id%type, cod_job jobs.job_id%type) return number
is
    v_sal number;
begin
    select min(nvl(salary, 0))
    into v_sal
    from employees
    where department_id=cod_dep
    and job_id=cod_job;
    
    return v_sal;
    exception
        when no_data_found then
            raise_application_error(-20001, 'Nu exista angajati cu job-ul '||cod_job||' in departamentul ' || cod_dep);
        when others then
            raise_application_error(-20002, 'Alta eroare! (get_salariu)');
end get_salariu;

function get_comision(cod_dep departments.department_id%type, cod_job jobs.job_id%type) return number
is
v_com number;
begin
    select min(nvl(commission_pct, 0))
    into v_com
    from employees
    where department_id=cod_dep
    and job_id=cod_job;

    return v_com;
    exception
        when no_data_found then
            raise_application_error(-20001, 'Nu exista angajati cu job-ul '||cod_job||' in departamentul ' || cod_dep);
        when others then 
            raise_application_error(-20002, 'Alta eroare! (get_comision)');
end get_comision;

procedure add_to_job_history(cod_emp employees.employee_id%type, hire_date employees.hire_date%type, cod_job jobs.job_id%type, cod_dep departments.department_id%type)
is
begin
    dbms_output.put_line('Incep adaugarea lui '|| cod_emp ||' in tabela job_history');
    
    insert into job_history_bms
    values (cod_emp, hire_date, sysdate, cod_job, cod_dep);
    
    dbms_output.put_line('Am terminat adaugarea lui '|| cod_emp ||' in tabela job_history');
end add_to_job_history;

function f_emp ( lname employees.last_name%type, fname employees.first_name%type) return number
is
v_cod number;
begin
    select employee_id
    into v_cod
    from employees
    where first_name=fname
    and last_name=lname;
    
    return v_cod;
    exception
        when no_data_found then
            raise_application_error(-20001, 'Nu exista angajati cu numele '||fname||' ' || lname);
        when too_many_rows then
            raise_application_error(-20001, 'Exista mai multi angajati cu numele '||fname||' ' || lname);
        when others then
            raise_application_error(-20002, 'Alta eroare! (f_emp)');
end f_emp;

FUNCTION f_manager(fname employees.first_name%TYPE, lname employees.last_name%TYPE) RETURN NUMBER IS
    cod_manager NUMBER := 0;
    e_manager NUMBER :=0;
BEGIN
    select a.employee_id
    into cod_manager
    from employees a, employees b
    where a.first_name=fname
    and a.last_name=lname
    and b.manager_id=a.employee_id;
    
    return cod_manager;
EXCEPTION
WHEN NO_DATA_FOUND THEN
DBMS_OUTPUT.PUT_LINE('NU EXISTA MANAGER CU NUMELE INTRODUS');
return -1;
END f_manager;

end pachet2_bms;

--exemplu de rulare
begin
pachet2_bms.mutare_angajat('King', 'Steven', 'IT', 'Programmer', 'De Haan', 'Lex');
end;
/


--punctul c
create or replace function numar_subalterni_by_cod_bms (cod employees.employee_id%type) return number
is
cursor c (cod number) is
    (select employee_id
    from employees
    where manager_id=cod);
v_nr number:=0;
v_cod number;
begin
    open c(cod);
    loop
        fetch c into v_cod;
        exit when c%notfound;
            v_nr:=v_nr+1+numar_subalterni_by_cod_bms(v_cod);
    end loop;
    close c;
    return v_nr;
end;
/

create or replace function numar_subalterni_by_name_bms (fname employees.first_name%type, lname employees.last_name%type) return number
is
v_cod number;
begin
    select employee_id
    into v_cod
    from employees
    where fname=first_name
    and lname=last_name;
    
    return numar_subalterni_by_cod_bms(v_cod);
    exception
        when no_data_found then
            raise_application_error(-20001, 'Nu exista angajati cu numele '||fname||' ' || lname);
        when too_many_rows then
            raise_application_error(-20001, 'Exista mai multi angajati cu numele '||fname||' ' || lname);
        when others then
            raise_application_error(-20002, 'Alta eroare! (f_emp)');
end numar_subalterni_by_name_bms;
/


--exemplu de rulare
begin
    dbms_output.put_line('Numarul de subalterni este: '||numar_subalterni_by_name_bms('Adam', 'Fripp'));
end;
/

--punctul e
create or replace procedure actualizeaza_salariul(sal employees.salary%type, fname employees.first_name%type, lname employees.last_name%type)
is
v_lim_inf jobs.min_salary%type;
v_lim_sup jobs.max_salary%type;
v_cod employees.employee_id%type;
v_cod_job employees.job_id%type;
begin
    select employee_id, job_id
    into v_cod, v_cod_job
    from employees
    where first_name=fname
    and last_name=lname;

    select min_salary, max_salary
    into v_lim_inf, v_lim_sup
    from jobs
    where job_id=v_cod_job;

    if v_lim_inf<=sal then
        if v_lim_sup>=sal then
            update emp_bms
            set salary=sal
            where employee_id=v_cod;
        end if;
    end if;

    exception
        when no_data_found then
            raise_application_error(-20001, 'Nu exista angajati cu numele '||fname||' ' || lname);
        when too_many_rows then
            raise_application_error(-20001, 'Exista mai multi angajati cu numele '||fname||' ' || lname);
        when others then
            raise_application_error(-20002, 'Alta eroare! (f_emp)');
end actualizeaza_salariul;


--exemplu de rulare
begin
    actualizeaza_salariul(28000, 'Steven', 'King');
end;
/
 
select * from emp_bms;

--punctul f
declare
cursor c_bms(cod_job jobs.job_id%type) is
    (select *
    from employees
    where job_id=cod_job);
v_row employees%rowtype;
begin
    open c_bms('IT_PROG');
    loop
        fetch c_bms into v_row;
        exit when c_bms%notfound;
        dbms_output.put_line(v_row.employee_id);
    end loop;
    close c_bms;
end;
/