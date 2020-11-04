Rezolvati: ex1 propus din LAB PLSQL1 si LAB PLSQL2.
Tratati cazul mai multi membri la ex3 din LAB PLSQL1(folosind rezolvarea adaugata in fisierul comun).
Rezolvati cu expresia CASE ex5 din LAB PLSQL1.


--1 din PLSQL 1
SET SERVEROUTPUT ON

DECLARE 
    numar number(3):=100; 
    mesaj1 varchar2(255):='text 1'; 
    mesaj2 varchar2(255):='text 2'; 
BEGIN 
    DECLARE 
        numar number(3):=1; 
        mesaj1 varchar2(255):='text 2'; 
        mesaj2 varchar2(255):='text 3';
    BEGIN 
        numar:=numar+1; 
        mesaj2:=mesaj2||' adaugat in sub-bloc'; 
    END; 
    numar:=numar+1; 
    mesaj1:=mesaj1||' adaugat un blocul principal'; 
    mesaj2:=mesaj2||' adaugat in blocul principal';
END;
/

--valoarea variabilei numar in subbloc: 2
--valoarea variabilei meaj1 in subbloc: 'text 2 adaugat in sub-bloc'
--valoarea variabilei mesaj2 in subbloc: 'text 3'
--valoarea variabilei numar in bloc: 101
--valoarea variabilei meaj1 in subbloc: 'text 2 adaugat in blocul principal'
--valoarea variabilei mesaj2 in subbloc: 'text 3 adaugat in blocul principal'


--1 din PLSQL 2
--Men?ine?i într-o colec?ie codurile celor mai prost pl?ti?i 5 angaja?i care nu câ?tig? 
--comision. Folosind aceast? colec?ie m?ri?i cu 5% salariul acestor angaja?i. 
--Afi?a?i valoarea veche a salariului, respectiv valoarea nou? a salariului.

--cu tablou indexat
alter session set plsql_warnings ='enable:all';


DECLARE
    TYPE tablou_indexat_dupa_id IS TABLE OF emp_bms.employee_id%TYPE INDEX BY BINARY_INTEGER;
    t tablou_indexat_dupa_id;
    TYPE tablou_indexat_dupa_salariu IS TABLE OF emp_bms.salary%TYPE INDEX BY BINARY_INTEGER;
    s tablou_indexat_dupa_salariu;
    v_curr NUMBER;
BEGIN
    select employee_id
    bulk collect into t
    from (select employee_id
          from emp_bms
          order by salary) a
    where rownum<=5;
    
    select salary
    bulk collect into s
    from (select employee_id, salary
          from emp_bms
          order by salary) a
    where rownum<=5;
            
    --salariile vechi
    for indx in s.first..s.last loop
        dbms_output.put_line(t(indx)||' avea salariul '||s(indx));
    end loop;
    dbms_output.put_line('');
    
    FORALL indx in t.FIRST..t.LAST
        UPDATE emp_bms
        SET salary=(105/100)*salary
        WHERE employee_id=t(indx);
        
     for indx in t.first..t.last loop
        select salary
        into v_curr
        from emp_bms
        where employee_id=t(indx);
        dbms_output.put_line('acum ' || t(indx)||' are salariul '||s(indx));
    end loop; 
END;
/
--cu tablouri imbricate
DECLARE
    TYPE tablou_indexat_dupa_id IS TABLE OF emp_bms.employee_id%TYPE;
    t tablou_indexat_dupa_id;
    TYPE tablou_indexat_dupa_salariu IS TABLE OF emp_bms.salary%TYPE;
    s tablou_indexat_dupa_salariu;
    v_curr NUMBER;
BEGIN
    select employee_id
    bulk collect into t
    from (select employee_id
          from emp_bms
          order by salary) a
    where rownum<=5;
    
    select salary
    bulk collect into s
    from (select employee_id, salary
          from emp_bms
          order by salary) a
    where rownum<=5;
            
    --salariile vechi
    for indx in s.first..s.last loop
        dbms_output.put_line(t(indx)||' avea salariul '||s(indx));
    end loop;
    dbms_output.put_line('');
    
    FORALL indx in t.FIRST..t.LAST
        UPDATE emp_bms
        SET salary=(105/100)*salary
        WHERE employee_id=t(indx);
        
     for indx in t.first..t.last loop
        select salary
        into v_curr
        from emp_bms
        where employee_id=t(indx);
        dbms_output.put_line('acum ' || t(indx)||' are salariul '||v_curr);
    end loop; 
END;
/
--cu vectori
DECLARE
    TYPE t_vector IS VARRAY(5) OF NUMBER;
    v_id t_vector;
    v_salary t_vector;
    v_curr NUMBER;
BEGIN
    select employee_id
    bulk collect into v_id
    from (select employee_id
          from emp_bms
          order by salary) a
    where rownum<=5;
    
    select salary
    bulk collect into v_salary
    from (select employee_id, salary
          from emp_bms
          order by salary) a
    where rownum<=5;
            
    --salariile vechi
    for indx in v_salary.first..v_salary.last loop
        dbms_output.put_line(v_id(indx)||' avea salariul '||v_salary(indx));
    end loop;
    dbms_output.put_line('');
    
    FORALL indx in v_id.FIRST..v_id.LAST
        UPDATE emp_bms
        SET salary=(105/100)*salary
        WHERE employee_id=v_id(indx);
        
     for indx in v_id.first..v_id.last loop
        select salary
        into v_curr
        from emp_bms
        where employee_id=v_id(indx);
        
        dbms_output.put_line('acum ' || v_id(indx)||' are salariul '||v_curr);
    end loop; 
END;
/


--3 in PLSQL 2
--Defini?i un bloc anonim în care s? se determine num?rul de filme (titluri) 
--împrumutate de un membru al c?rui nume este introdus de la tastatur?. 
--Trata?i urm?toarele dou? situa?ii: nu exist? nici un membru cu nume dat; 
--exist? mai mul?i membrii cu acela?i nume.

SET VERIFY OFF
DECLARE
v_nr NUMBER;
v_nume member.last_name%TYPE:='&p_nume';
TYPE tablou_indexat_dupa_id IS TABLE OF member.member_id%TYPE INDEX BY BINARY_INTEGER;
v_pers tablou_indexat_dupa_id;
BEGIN
SELECT COUNT(*)
INTO v_nr
FROM member_bms
WHERE LOWER(last_name)=LOWER(v_nume);
IF v_nr = 0 THEN
    RAISE_APPLICATION_ERROR(-20000,'Nu exista membru cu numele dat!');
ELSIF v_nr > 1 THEN
    SELECT member_id
    BULK COLLECT INTO v_pers
    FROM member_bms
    WHERE lower(last_name)=lower(v_nume);
    
    FOR indx in v_pers.first..v_pers.last LOOP
        SELECT COUNT(title_id)
        INTO v_nr
        FROM rental JOIN member_bms USING (member_id)
        WHERE member_id=v_pers(indx);
        
        IF v_nr = 0 THEN 
            DBMS_OUTPUT.PUT_LINE('Membrul '|| v_nume || ' cu id ' || v_pers(indx) || ' nu a imprumutat nici un film!');
        ELSE
            DBMS_OUTPUT.PUT_LINE('Membrul '|| v_nume || ' cu id ' || v_pers(indx) ||' a imprumutat '||v_nr||' filme.');
        END IF;
        
        v_nr:=0;
    
    END LOOP;
ELSE
    SELECT COUNT(title_id)
    INTO v_nr
    FROM rental JOIN member USING (member_id)
    WHERE LOWER(last_name)=LOWER(v_nume);
    IF v_nr = 0 THEN 
        RAISE_APPLICATION_ERROR(-20001,'Membrul nu a imprumutat nici un film!');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Membrul '||v_nume||' a imprumutat '||v_nr||' filme.');
    END IF;
END IF;
END;
/

select * from member_bms;
insert into member_bms
values (110, 'Velasquez', 'Maria', '76 May Street', 'Hong Kong', '418-542-9988', to_date('18-JAN-91', 'dd-mon-yy'), null, null);

--5 din PLSQL 1
--Crea?i tabelul member_*** (o copie a tabelului member). Ad?uga?i în acest tabel coloana 
--discount, care va reprezenta procentul de reducere aplicat pentru membrii, în func?ie
--de categoria din care fac parte ace?tia:
-- 10% pentru membrii din Categoria 1
-- 5% pentru membrii din Categoria 2
-- 3% pentru membrii din Categoria 3
-- nimic
--Actualiza?i coloana discount pentru un membru al c?rui cod este dat de la tastatur?. 
--Afi?a?i un mesaj din care s? reias? dac? actualizarea s-a produs sau nu.


CREATE TABLE member_bms as
select * from member;
alter table member_bms
add dicount number;

DECLARE
v_cod member_bms.member_id%TYPE:='&p_cod';
v_nr NUMBER;
v_total NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO v_total
    from title;

    SELECT COUNT(*)
    INTO v_nr
    FROM member_bms
    WHERE member_id=v_cod;
    
    UPDATE member_bms
    SET discount= (CASE
                    WHEN v_nr>(75/100)*v_total THEN 10
                    WHEN v_nr>(50/100)*v_total THEN 5
                    WHEN v_nr>(25/100)*v_total THEN 3
                    ELSE 0
                    END)
    WHERE member_id=v_cod;
    
    DBMS_OUTPUT.PUT_LINE('Actualizarea s-a produs!');
END;
/