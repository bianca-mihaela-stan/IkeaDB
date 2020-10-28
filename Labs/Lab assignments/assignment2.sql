--1. MEMBER : member_id
-- TITLE : title_id
-- TITLE_COPY : title_id, copy_id
-- RENTAL : copy_id, member_id, title_id
-- RESERVATION : 

--4
with categorie_nr as (select category, count(*) nr
                        from title a, title_copy b, rental c
                        where a.title_id=b.title_id
                        and b.title_id=c.title_id
                        group by category)
select category
from categorie_nr d
where d.nr = (select max(e.nr)
              from categorie_nr e);
              
--5
select title_id "titlu", sum(decode(status, 'AVAILABLE', 1,
                                    'RENTED', 0,
                                    null, 0)) "nr exemplare disponibile"
from title_copy
group by title_id;

--6
select title_id , copy_id, status, nvl(status, 'RENTED') "status corect"
from title_copy;

--7. a
select sum(decode(p.status, p.status_corect, 0, 1))
from 
    (select status, nvl(status, 'RENTED') status_corect
    from title_copy) p;
    
--7. b
create table title_copy_bms as select * from title_copy;
update title_copy_bms
set status='RENTED'
where status=null;

--8
with nr_rez_imp as (select count(*)
                    from reservation a, rental b
                    where a.title_id=b.title_id
                    and a.member_id=b.member_id
                    and a.res_date=b.book_date),
nr_rezervari as (select count(*) from reservation)
select distinct decode(nr_rezervari, nr_rez_imp, 'DA', 'NU')
from title;

--9
select a.last_name, a.first_name, b.title_id, count(*)
from member a, rental b
where a.member_id=b.member_id
group by a.last_name, a.first_name, b.title_id;

--10
select a.last_name, a.first_name, b.title_id, b.copy_id, count(*)
from member a, rental b
where a.member_id=b.member_id
group by a.last_name, a.first_name, b.title_id, b.copy_id;

--11
select title_id, copy_id
from title_copy;

with f as (select b.title_id, b.copy_id, count(*) nr -- de cate ori a fost imprumutat fiecare exemplar al unui film
            from member a, rental b
            where a.member_id=b.member_id
            group by  b.title_id, b.copy_id),
g as 
            (select f.title_id, max(nr) nr -- de cate ori a fost imprumutata cea mai imprumutata copie a sa
            from f
            group by f.title_id)
select f.title_id, f.copy_id, tc.status -- filmul impreuna cu cea mai imprumutata copie a sa
from f, g, title_copy tc
where f.title_id=g.title_id
and f.nr=g.nr
and tc.title_id=f.title_id
and tc.copy_id=f.copy_id;

--12

--a                                
select to_char(book_date, 'dd'), count(*)
from rental
where to_char(book_date, 'dd')='01'
or to_char(book_date, 'dd')='02'
group by to_char(book_date, 'dd');

--b
select to_char(book_date, 'dd'), count(*)
from rental
group by to_char(book_date, 'dd');
