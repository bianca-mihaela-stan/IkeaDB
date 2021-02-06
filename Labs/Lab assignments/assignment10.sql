--5 b)

--procedura
create or replace procedure p5_bms
as
v_nr number;
v_zi varchar(20);
v_count number;
v_min_date job_history.start_date%type;
cursor c(dep_id departments.department_id%type) is
    select * 
    from (select to_char(hire_date, 'day'), count(*)
          from employees
          where department_id=dep_id
          group by to_char(hire_date, 'day')
          having count(*)=(select max(count(*))
                           from employees
                           where department_id=dep_id
                           group by to_char(hire_date, 'day')))
    where rownum<2;
begin
    for v_dep in (select department_id, department_name from departments) loop
        
        dbms_output.put_line('-------------------------------------------');
        dbms_output.put_line('Pentru departamentul '|| v_dep.department_id);
        dbms_output.put_line('-------------------------------------------');
        
        select count(*)
        into v_nr
        from employees
        where department_id=v_dep.department_id;
        
        if v_nr=0 then
            dbms_output.put_line('In departamentul ' || v_dep.department_name || ' nu lucreaza niciun angajat!');
        else
        
            open c(v_dep.department_id);
            loop
                fetch c into v_zi, v_count;
                exit when c%notfound;
                
                dbms_output.put_line('In departamentul '||v_dep.department_name||' s-au angajat '||v_count||' angajati intr-o zi de '|| v_zi);
                
                for i in (select employee_id, last_name, first_name, hire_date, salary
                          from employees
                          where department_id=v_dep.department_id
                          and to_char(hire_date, 'day')=v_zi) loop
                    select count(*)
                    into v_nr
                    from job_history
                    where employee_id=i.employee_id;
                    
                    if v_nr>0 then
                        select min(start_date)
                        into v_min_date
                        from job_history
                        where employee_id=i.employee_id
                        group by employee_id;
                        
                        dbms_output.put_line('Angajatul '||i.last_name || ' '|| i.first_name || 'are salariul '||i.salary||' si vechimea '|| floor(sysdate-nvl(v_min_date, sysdate)));
                        
                    else
                        dbms_output.put_line('Angajatul '||i.last_name || ' '|| i.first_name || 'are salariul '||i.salary||' si vechimea '|| floor(sysdate-i.hire_date));
                    end if;
                end loop;
            end loop;
            close c;
        end if;
        
        
    end loop;
end;


--apelarea
declare
begin
p5_bms();
end;
/

--6
--creez doua tipuri
CREATE TYPE obiect_bms IS OBJECT (nume VARCHAR2(25), vechime NUMBER(8,2), venit NUMBER(8,2));
/
CREATE OR REPLACE TYPE colectie_bms IS VARRAY(110000000) of obiect_bms;
/


--procedura
create or replace procedure p6_bms
as
arr colectie_bms:=colectie_bms();--colectie are lemente de tip obiect (nume, vechime, venit)
v_p number:=1;
v_nr number;
v_zi varchar(20);
v_count number;
obj obiect_bms;
v_min_date job_history.start_date%type;
cursor c(dep_id departments.department_id%type) is
    select * 
    from (select to_char(hire_date, 'day'), count(*)
          from employees
          where department_id=dep_id
          group by to_char(hire_date, 'day')
          having count(*)=(select max(count(*))
                           from employees
                           where department_id=dep_id
                           group by to_char(hire_date, 'day')))
    where rownum<2;
begin
    for v_dep in (select department_id, department_name from departments) loop

        dbms_output.put_line('-------------------------------------------');
        dbms_output.put_line('Pentru departamentul '|| v_dep.department_id);
        dbms_output.put_line('-------------------------------------------');

        select count(*)
        into v_nr
        from employees
        where department_id=v_dep.department_id;

        if v_nr=0 then
            dbms_output.put_line('In departamentul ' || v_dep.department_name || ' nu lucreaza niciun angajat!');
        else

            open c(v_dep.department_id);
            loop
                fetch c into v_zi, v_count;
                exit when c%notfound;

                --dbms_output.put_line('In departamentul '||v_dep.department_name||' s-au angajat '||v_count||' angajati intr-o zi de '|| v_zi);

                for i in (select employee_id, last_name, first_name, hire_date, salary
                          from employees
                          where department_id=v_dep.department_id
                          and to_char(hire_date, 'day')=v_zi) loop

                    select count(*)
                    into v_nr
                    from job_history
                    where employee_id=i.employee_id;

                    if v_nr>0 then
                        select min(start_date)
                        into v_min_date
                        from job_history
                        where employee_id=i.employee_id
                        group by employee_id;

                        --dbms_output.put_line('Angajatul '||i.last_name || ' '|| i.first_name || 'are salariul '||i.salary||' si vechimea '|| floor(sysdate-nvl(v_min_date, sysdate)));

                        obj:=new obiect_bms(i.last_name, floor(sysdate-nvl(v_min_date, sysdate)),  i.salary);
                        arr.extend(1);
                        arr(v_p):=obj;
                        v_p:=v_p+1;
                    else
                        obj:=new obiect_bms(i.last_name, floor(sysdate-i.hire_date),  i.salary);
                        arr.extend(1);
                        arr(v_p):=obj;
                        v_p:=v_p+1;
                        --dbms_output.put_line('Angajatul '||i.last_name || ' '|| i.first_name || 'are salariul '||i.salary||' si vechimea '|| floor(sysdate-i.hire_date));
                    end if;
                end loop;
            end loop;
            close c;
        end if;
    end loop;
    
    --bubble sort
    for i in arr.first..arr.last loop
        for j in i+1..arr.last loop
            if(arr(j).vechime<arr(i).vechime) then
                obj:=arr(i);
                arr(i):=arr(j);
                arr(j):=obj;
            end if;
        end loop;
    end loop;
    
    for i in arr.first..arr.last loop
        dbms_output.put_line('Angajatul '||arr(i).nume || 'are salariul '||arr(i).venit||' si vechimea '|| arr(i).vechime);
    end loop;
end;

--apelarea

declare
begin
p6_bms();
end;
/

