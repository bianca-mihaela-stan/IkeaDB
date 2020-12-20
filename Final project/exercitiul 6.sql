6. Vrem sa imbunatatim recomandarile site-ului nostru. Astfel, pentru fiecare produs X
vrem sa identificam care sunt produsele Y care se vand intotdeauna cu produsul X.
(deci Y poate fi cumparat si fara X, dar X a fost cumparat impreuna cu Y in proportie
de minim 50%). Ordonati rezulatele pentru fiecare produs X in functie de procentajul de
cumparare.
/

create or replace type info_produs is object (id_produs number(8,0), denumire_produs varchar2(200));
/
create or replace type nested_table is table of info_produs;
/
create or replace type info_produs_produse is object (id_produs number(8,0), lista_produse nested_table);
/
create or replace type nested_table_of_nested_table is table of info_produs_produse;
/
--Cum procedam?
--Varianta 1
--Pentru fiecare produs X din produse O(n), unde n=numarul de produse
--Retin intr-un nested table comenzile distincte in care apare X O(m), unde m=numarul de comenzi
--Pentru fiecare produs Y din produse retin in alt nested table O(n)
--comenzile distincte in care apare Y O(m)
--intersectez cele 2 nested tables cu MULTISET INTERSECT
--adaug acest nested table la nested table of nested table
--complexitate finala aproximativa O(n*m^2)

create or replace function functie_6 return nested_table_of_nested_table
is
    
end;

