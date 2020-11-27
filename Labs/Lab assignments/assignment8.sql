--Exercitiul 3

declare
v_nr number(4);
v_sum number(10);
v_comm employees.salary%type;
v_fname employees.first_name%type;
v_lname employees.last_name%type;
v_sal employees.salary%type;
i number;
cursor c_emp is
    select count(*) nr, sum(salary*(1+decode(commission_pct, NULL, 0, commission_pct))), sum (salary*decode(commission_pct, NULL, 0, commission_pct))
    from employees e;
cursor d is
    select salary, last_name, first_name
    from employees;
begin
    open c_emp;
        fetch c_emp into v_nr, v_sum, v_comm;
        dbms_output.put_line('In firma sunt ' || v_nr || ' angajati care au valoarea lunara a veniturilor ' || v_sum || ' si suma lunara a comisioanelor ' || v_comm || '.');
    close c_emp;
    open d;
    i:=1;
        loop
            fetch d into v_sal, v_lname, v_fname;
            exit when d%notfound;
            dbms_output.put_line(i || '. ' || v_fname || ' ' || v_lname || ' obtine '|| round((v_sal/v_sum)*100, 4) || '% din salariul total.');
            i:=i+1;
        end loop;
    close d;
end;
/ 


--Exercitiul 4

declare
i number;
cursor c is
    (select job_id id, job_title title
    from jobs);
v_id jobs.job_id%type;
v_title jobs.job_title%type;
begin
open c;
loop
    fetch c into v_id, v_title;
    exit when c%notfound;
    dbms_output.put_line('------------------------');
    dbms_output.put_line('Job-ul ' || v_title || '.');
    i:=1;
    for v_emp in (select lname, fname, sal
                from
                        (select last_name lname, first_name fname, salary sal
                        from employees
                        where job_id = v_id
                        order by salary desc)
                where rownum<=5)
    loop
        dbms_output.put_line(i || '. ' || v_emp.fname || ' ' || v_emp.lname || ' obtine '|| v_emp.sal);
        i:=i+1;
        exit when i=6;
    end loop;
end loop;
close c;
end;
/


--Exercitiul 5

declare
i number;
cursor c is
    (select job_id id, job_title title
    from jobs);
v_id jobs.job_id%type;
v_title jobs.job_title%type;
begin
open c;
loop
    fetch c into v_id, v_title;
    exit when c%notfound;
    dbms_output.put_line('------------------------');
    dbms_output.put_line('Job-ul ' || v_title || '.');
    i:=1;
    for v_emp in (select last_name lname, first_name fname, salary sal
                from employees
                where salary in (select *
                                 from (select distinct salary
                                        from employees
                                        where job_id=v_id
                                        order by salary desc)
                                  where rownum<=5)
                and job_id=v_id
                order by sal desc)
        loop
        dbms_output.put_line(i || '. ' || v_emp.fname || ' ' || v_emp.lname || ' obtine '|| v_emp.sal);
        i:=i+1;
    end loop;
end loop;
close c;
end;
/