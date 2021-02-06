-----------------------------------------------------------------------
4. ADAUGARE TABELE SI CONSTRANGERI
-----------------------------------------------------------------------

drop table magazin_online;
create table magazine_online
(magazin_online_id number,
primary key (magazin_online_id));

drop table useri_magazin_online;
create table useri_magazin_online
(user_id number,
email varchar2(100),
nume varchar2(50),
prenume varchar2(50),
numar_telefon varchar2(12),
gen varchar2(10),
data_nasterii date,
primary key (user_id));

drop table comanda;
create table comenzi
(comanda_id number,
status_comanda number,
data_efectuarii date,
data_livrarii date,
primary key (comanda_id));



drop table produs_comanda;
create table produse_comenzi
(produs_id number,
comanda_id number,
cantitate number,
pret_facturare number,
primary key (produs_id, comanda_id));

drop table produs;
create table produse
(produs_id number,
stoc_curent number,
pret_unitar number,
primary key (produs_id),
foreign key (produs_id) references produse(produs_id));


create table categorii
(categorie_id number,
nume_categorie varchar2(100),
primary key (categorie_id),
foreign key (categorie_id) references categorii(categorie_id));


drop table voucher;
create table vouchere
(voucher_id number,
cod varchar2(20),
valoare number,
data_inceput date,
data_final date,
primary key (voucher_id));

create table discounturi
(discount_id number,
valoare number,
data_inceput date,
data_final date,
primary key (discount_id));

drop table angajati;
create table angajati
(angajat_id number,
nume varchar2(50),
prenume varchar2(50),
email varchar2(100),
numar_telefon varchar2(12),
data_angajarii date,
data_nasterii date,
manager_id number,
primary key (angajat_id),
foreign key (manager_id) references angajati(angajat_id));

drop table joburi;
create table joburi
(job_id number,
nume_job varchar2(50),
primary key (job_id));

drop table departamente;
create table departamente
(departament_id number,
nume_departament varchar2(50),
primary key (departament_id));

drop table transport;
create table transporturi
(transport_id number,
primary key (transport_id));

drop table garantie;
create table garantii
(garantie_id number,
primary key(garantie_id));

create table magazine
(magazin_id number,
primary key (magazin_id));

alter table orase
modify nume_oras varchar2(50);
create table orase
(oras_id number,
nume_oras varchar2(50),
primary key(oras_id));

alter table tari
modify nume_tara varchar2(50);
create table tari
(tara_id number,
nume_tara varchar2(50),
primary key(tara_id));

drop table zone;
create table zone
(zona_id number,
numar number,
primary key (zona_id));

create table raioane
(raion_id number,
numar number,
primary key (raion_id));

create table rafturi
(raft_id number,
numar number,
primary key (raft_id));

create table case
(casa_id number,
numar number,
primary key (casa_id));

alter table useri_adrese
modify tip_adresa varchar2(20);
create table useri_adrese
(user_id number,
adresa_id number,
tip_adresa varchar(20),
primary key(user_id, adresa_id));

create table discounturi_produse
(discount_id number,
produs_id number,
primary key(discount_id, produs_id));

--pentru a aplica un discount pe o intreaga categorie se va face un pachet care sa aplice la fiecare dintre produse


create table vouchere_comenzi
(voucher_id number,
comanda_id number,
primary key(voucher_id, comanda_id));

alter table discounturi_produse
add constraint fk1_discounturi_produse foreign key (discount_id) references discounturi(discount_id);

alter table discounturi_produse
add constraint fk2_discounturi_produse foreign key (produs_id) references produse(produs_id);

alter table vouchere_comenzi
add constraint fk1_vouchere_comenzi foreign key (voucher_id) references vouchere(voucher_id);

alter table vouchere_comenzi
add constraint fk2_vouchere_comenzi foreign key (comanda_id) references comenzi(comanda_id);

create table produse_categorii
(produs_id number,
categorie_id number,
primary key (produs_id, categorie_id));

alter table produse_categorii
add constraint fk1_produse_categorii foreign key (produs_id) references produse(produs_id);

alter table produse_categorii
drop constraint fk2_produse_categorii;

alter table produse_categorii
add constraint fk2_produse_categorii foreign key (categorie_id) references categorii(categorie_id);

alter table produse
add raft_id number;

alter table produse
add constraint fk1_produse foreign key (raft_id) references rafturi(raft_id);

alter table rafturi
add raion_id number;

alter table rafturi
add constraint fk1_rafturi foreign key (raion_id) references raioane(raion_id);

alter table raioane
add zona_id number;

alter table raioane
add constraint fk1_raioane foreign key (zona_id) references zone(zona_id);

alter table zone
add magazin_id number;

alter table zone
add constraint fk1_zone  foreign key (magazin_id) references magazine(magazin_id);

alter table case
add magazin_id number;

alter table case
add constraint fk1_case foreign key (magazin_id) references magazine(magazin_id);

drop table magazine_categorii;
create table magazine_online_categorii
(magazin_online_id number,
categorie_id number,
primary key (magazin_online_id, categorie_id));

alter table magazine_online_categorii
add constraint fk1_magazine_online_categorii foreign key (magazin_online_id) references magazine_online(magazin_online_id);

alter table magazine_online_categorii
add constraint fk2_magazine_online_categorii foreign key (magazin_online_id) references categorii(categorie_id);

alter table produse
add garantie_id number;

alter table produse
add constraint fk2_produse foreign key (garantie_id) references garantii(garantie_id);

alter table produse_comenzi
add constraint fk1_produse_comenzi foreign key (produs_id) references produse(produs_id);

alter table produse_comenzi
add constraint fk2_produse_comenzi foreign key (comanda_id) references comenzi(comanda_id);

alter table magazine_online
add tara_id number;

alter table magazine_online
add constraint fk1_magazine_online foreign key (tara_id) references tari(tara_id);

alter table orase
add tara_id number;

alter table orase
add constraint fk1_orase foreign key (tara_id) references tari(tara_id);

create table adrese
(adresa_id number,
strada varchar2(50),
numar number,
cod_postal varchar2(10),
scara varchar2(10),
bloc varchar2(10),
apartament number,
primary key (adresa_id));

alter table adrese
add oras_id number;

alter table adrese
add constraint fk1_adrese foreign key (oras_id) references orase(oras_id);

alter table magazine
add adresa_id number;

alter table magazine
add constraint fk1_magazine foreign key (adresa_id) references adrese(adresa_id);

alter table useri_adrese
add constraint fk1_useri_adrese foreign key (user_id) references useri_magazin_online(user_id);

alter table useri_adrese
add constraint fk2_useri_adrese foreign key (adresa_id) references adrese(adresa_id);

alter table useri_magazin_online
add magazin_online_id number;

alter table useri_magazin_online
add constraint fk1_useri_magazin_online foreign key (magazin_online_id) references magazine_online(magazin_online_id);

alter table comenzi
add user_id number;

alter table comenzi
add constraint fk1_comenzi foreign key (user_id) references useri_magazin_online(user_id);

alter table transporturi
add adresa_start number;

alter table transporturi
add adresa_finish number;

alter table transporturi
add comanda_id number;

alter table transporturi
add constraint fk1_transporturi foreign key (comanda_id) references comenzi(comanda_id);

alter table transporturi
add constraint fk2_transporturi foreign key (adresa_start) references adrese(adresa_id);

alter table transporturi
add constraint fk3_transporturi foreign key (adresa_finish) references adrese(adresa_id);

alter table transporturi
add sofer_id number;

alter table transporturi
add constraint fk4_transporturi foreign key (sofer_id) references angajati(angajat_id);

alter table angajati
add job_id number;

alter table angajati
add departament_id number;

alter table angajati
add constraint fk1_angajati foreign key (job_id) references joburi(job_id);

alter table angajati
add constraint fk2_angajati foreign key (departament_id) references departamente(departament_id);

alter table angajati 
add magazin_id number;

alter table angajati
add constraint fk3_angajati foreign key (magazin_id) references magazine(magazin_id);

--am horatat ca este redundant sa tin 2 seturi de tabele: comenzi si facturi, 
--care in sine erau acleasi lucru, doar ca comenzile erau date online
--asa ca adaug in table a comenzi campul in_magazin, iar daca acesta este 1, 
--inseamna ca plata s-a efectuat la o casa, impreuna cu un angajat al magazinului
alter table comenzi
add in_magazin number;

alter table comenzi
add angajat_id number;

alter table comenzi
add casa_id number;

alter table comenzi
add constraint fk2_comenzi foreign key (casa_id) references case(casa_id);

alter table comenzi
add constraint fk3_comenzi foreign key (angajat_id) references angajati(angajat_id);

alter table angajati
add salatiu number;

alter table garantii
add durata_luni number;

alter table magazine_online
drop constraint fk1_magazine_online;

rename magazine_online to magazin_online;

drop table produse_magazine;
drop table magazine_online_categorii;
drop table magazine;

alter table zone
drop constraint fk1_zone;
alter table zone
drop column magazin_id;

alter table case
drop constraint fk1_case;
alter table case
drop column magazin_id;

alter table angajati
drop constraint fk3_angajati;
alter table angajati
drop column magazin_id;

drop table magazin_online;
alter table useri_magazin_online
drop constraint fk1_useri_magazin_online;

alter table comenzi
add voucher_aplicat_id number;

alter table comenzi
add constraint fk4_comenzi foreign key (voucher_aplicat_id) references vouchere(voucher_id);

create table comenzi_vouchere
(comanda_id number,
voucher_id number,
numar_bucati number,
primary key(comanda_id, voucher_id));

alter table comenzi_vouchere
add constraint fk1_comenzi_vouchere foreign key (voucher_id) references vouchere(voucher_id);

alter table comenzi_vouchere
add constraint fk2_comenzi_vouchere foreign key (comanda_id) references comenzi(comanda_id);
 
alter table produse
drop constraint SYS_C007586;

create table produse_produse
(componenta_id number,
produs_final_id number,
primary key(componenta_id, produs_final_id));

rename produse_produse to componente_produse;

alter table componente_produse
add constraint fk1_componente_produse foreign key (componenta_id) references produse(produs_id);

alter table componente_produse
add constraint fk2_componente_produse foreign key (produs_final_id) references produse(produs_id);

alter table componente_produse
add numar_necesar number;

alter table produse
drop constraint fk2_produse;
alter table produse
drop column garantie_id;

drop table garantii;

alter table comenzi
add transport_id number;

alter table comenzi
add constraint fk5_comenzi foreign key (transport_id) references transporturi(transport_id);

alter table comenzi
drop constraint fk2_comenzi;

alter table comenzi
drop constraint fk3_comenzi;

alter table comenzi
drop column casa_id;

alter table comenzi
drop column angajat_id;

rename achizitie_in_magazin to achizitii_in_magazin;
create table achizitie_in_magazin
(achizitie_id number,
data_achizitiei date,
casa_id number,
angajat_id number,
primary key (achizitie_id));

create table produse_achizitii
(produs_id number,
achizitie_id number,
numar_produse number,
primary key(produs_id, achizitie_id));

alter table produse_achizitii
add constraint fk1_produse_achizitii foreign key (produs_id) references produse(produs_id);

alter table produse_achizitii
add constraint fk2_produse_achizitii foreign key (achizitie_id) references achizitii_in_magazin(achizitie_id);

alter table useri_magazin_online
drop column magazin_online_id;

drop table tari;
alter table orase
drop constraint fk1_orase;

create table judete
(judet_id number,
denumire_judet varchar2(50),
primary key(judet_id));

alter table orase
add judet_id number;

alter table orase
add constraint fk1_orase foreign key (judet_id) references judete(judet_id);

alter table orase
drop column tara_id;

alter table transporturi
drop constraint fk1_transporturi;

alter table transporturi
drop column comanda_id;

alter table angajati
drop column salatiu;

alter table angajati
add salariu number;
commit;

alter table useri_magazin_online
add adresa_id number;

alter table useri_magazin_online
add constraint fk1_useri_magazin_online foreign key (adresa_id) references adrese(adresa_id);

drop table useri_adrese;

alter table comenzi
drop column in_magazin;

drop table vouchere_comenzi;

alter table transporturi
drop column adresa_start;

drop table comenzi_vouchere;

alter table discounturi
drop column categorie_id;

create table discounturi_categorii
(discount_id number,
categorie_id number,
primary key (discount_id, categorie_id));

alter table discounturi_categorii
add constraint fk1_discounturi_categorii foreign key (discount_id) references discounturi(discount_id);

alter table discounturi_categorii
add constraint fk2_discounturi_categorii foreign key (categorie_id) references categorii(categorie_id);

alter table categorii
drop column discount_id;


alter table categorii
add categorie_parinte_id number;

alter table comenzi
modify user_id not null;

alter table achizitii_in_magazin
rename column angajat_id to casier_id;

alter table produse_achizitii
add pret_facturare number;

alter table achizitii_in_magazin
add voucher_id number;

alter table achizitii_in_magazin
add constraint fk1_achizitii_in_magazin foreign key (casier_id) references angajati(angajat_id);

alter table achizitii_in_magazin
add constraint fk2_achizitii_in_magazin foreign key (indrumator_id) references angajati(angajat_id);

alter table achizitii_in_magazin
add constraint fk3_achizitii_in_magazin foreign key (voucher_id) references vouchere(voucher_id);

alter table categorii
add constraint fk1_categorii foreign key (categorie_parinte_id) references categorii(categorie_id);

alter table achizitii_in_magazin
add constraint fk4_achizitii_in_magazin foreign key (casa_id) references case(casa_id);

select * from achizitii_in_magazin;

update achizitii_in_magazin
set casa_id=2
where casa_id=10;

select * from case;

alter table produse
add categorie_id number;

alter table produse
add constraint fk2_produse foreign key (categorie_id) references categorii(categorie_id);



---------------------------------------------------------------------
5. POPULARE TABELE
---------------------------------------------------------------------

--achizitii in magazin
declare
type v_array is varray(200) of number;
casieri v_array:=v_array();
begin
    dbms_random.seed(val =>0);
    --pun toti soferii in soferi
    select angajat_id
    bulk collect into casieri
    from angajati
    where job_id=2;

    for i in 1..600 loop
        dbms_output.put_line(i || ' ' || to_date(trunc(dbms_random.value(to_char(date '2000-01-01', 'J'), to_char(date '2021-01-09', 'J'))), 'J') || ' ' ||  dbms_random.value(low=>1, high=>10) || ' ' || 
        casieri(dbms_random.value(high=>casieri.count, low=>1)));
--        insert into achizitii_in_magazin (achizitie_id, data_achizitiei, casa_id, angajat_id)
--        values(i, to_date(trunc(dbms_random.value(to_char(date '2000-01-01', 'J'), to_char(date '2021-01-09', 'J'))), 'J'), dbms_random.value(low=>1, high=>10), 
--        casieri(dbms_random.value(high=>casieri.count, low=>1)));
    end loop;
end;
/

declare
type nested_table is table of number;
indrumator number;
indrumatori nested_table;
begin
    dbms_random.seed(val =>0);
    select angajat_id
    bulk collect into indrumatori
    from angajati
    where job_id=8;
   for i in 1..5000 loop
        indrumator:=dbms_random.value(low=>1, high=>indrumatori.count);
        update achizitii_in_magazin
        set indrumator_id=indrumatori(indrumator)
        where achizitie_id=i;
   end loop;
end;
/

select * from joburi;
select * from case;
select * from angajati;


--adrese
declare
type v_array is varray(200) of varchar(50);
type big_v_array is varray(1000) of varchar(10);
street_names v_array := v_array('Darrel', 'Deer', 'Deer', 'Path', 'Delano', 'Dellwood', 'Dellwood', 'Road', 'Driftwood', 
'Driving', 'Park', 'Dubuque', 'Dundee', 'Eagle', 'Ridge', 'Eben', 'Echo', 'Edgewood', 'Elm', 
'Everett', 'Evergreen', 'Fairlawn', 'Fairmeadows', 'Fairy', 'Falls', 'Farm', 'Hill', 'Fischer', 'Frontage', 
'Gadient', 'Gilbert', 'Greeley', 'Green', 'Twig', 'Greenmeadow', 'Greenwood', 'Grove', 'Hancock', 'Hanson', 
'Harriet', 'Harvest', 'Hawthorne', 'Hazel', 'Heifort', 'Hemlock', 'Heritage', 'Hickory', 'Hidden', 'Valley', 
'Highland', 'Hillcrest', 'Hillside', 'Holcombe', 'Homestead', 'Homeward', 'Honeye', 'Hudson', 'Icerose', 'Ilo', 
'Imperial', 'Industrial', 'Ingberg', 'Interlachen', 'Inwood', 'Irish', 'Ironwood', 'Isleton', 'Itasca', 'Ivy', 
'Jamaca', 'Jarvis', 'Jasmine', 'Jeffrey', 'Jewell', 'Jocelyn', 'Jody', 'Johnson', 'Joliet', 'Judd', 
'Julianne', 'Juno', 'Justen', 'Kallie', 'Keats', 'Kelman', 'Kelvin', 'Kersh', 'Keswick', 'Keystone', 
'Kimbro', 'Kinship', 'Kismet', 'Knollwood', 'Krueger', 'Lake', 'Lakeside', 'Lansing', 'Laurel', 'Laurie', 
'Lecuyer', 'Leeward', 'Legend', 'Liberty', 'Linden', 'Linson', 'Lockridge', 'Locust', 'Lofton', 'Long', 
'Lake', 'Lookout', 'Lydia', 'Macey', 'Main', 'Mallard', 'Manning', 'Manning', 'Trail', 'Maple', 
'Marine', 'Market', 'Marsh', 'Martha', 'Maryknoll', 'Marylane', 'May', 'Mayfield', 'Mcdonald', 'Mcdougal', 
'Mckusick', 'Meadowlark', 'Meadowview', 'Melville', 'Memorial', 'Mendel', 'Mid', 'Oaks', 'Minar', 'Monarda', 
'Moonlight', 'Bay', 'Moore', 'Morgan', 'Morning', 'Dove', 'Morningside', 'Muir', 'Mulberry', 'Myeron', 
'Myrtle', 'Myrtlewood', 'Mystic', 'Ridge', 'Neal', 'Nelson', 'Nena', 'New', 'England', 'Newberry', 
'Newell', 'Newgate', 'Newman', 'Nightingale', 'Nolan', 'Norcrest', 'Nordic', 'Norell', 'Norman', 'Normandale', 
'Normandy', 'Northbrook', 'Northland', 'Northridge', 'Northwestern', 'Norwich', 'Norwood', 'Nova', 'Scotia', 'Novak', 
'Oak', 'Oak', 'Glen', 'Oak', 'Park', 'Oakes', 'Oakgreen', 'Oakgreen', 'Avenue', 'Oakhill', 
'Oakland', 'Oakridge', 'Oasis', 'Obrien', 'Odegard', 'Odell', 'Ojib', 'Old', 'Deer', 'Oldfield', 
'Oldfield');
postal_codes v_array:=v_array('987706', '348586', '859648', '609301', '588923', '924576', '478090', '499901', '665500', 
'856956', '291633', '371805', '203014', '572863', '899321', '032408', '199167', '950764', '212531', 
'526441', '713391', '759175', '138081', '599481', '544710', '756476', '050268', '914910', '815982', 
'658052', '108048', '244429', '071901', '309625', '846231', '591094', '324053', '560649', '872226', 
'411247', '152423', '425776', '434608', '094072', '869935', '362398', '386251', '989433', '414483', 
'432373', '282900', '391320', '979591', '177273', '938259', '347377', '664777', '670082', '036920', 
'385835', '239947', '906642', '881954', '657017', '854312', '461580', '538857', '589374', '100657', 
'618095', '433010', '039305', '653057', '403041', '967424', '329527', '134061', '764733', '206631', 
'258264', '550892', '990680', '905022', '261313', '084202', '302298', '768756', '441943', '944377', 
'398528', '024223', '228365', '125291', '018964', '920423', '483010', '695685', '011876', '668692', 
'240479', '625047', '539127', '038420', '380461', '984375', '847799', '470345', '122234', '763763', 
'257027', '133183', '136280', '062329', '748487', '556183', '837609', '450832', '778832', '960842', 
'688822', '377346', '100161', '225362', '050722', '849538', '291612', '072687', '724223', '974677', 
'977059', '452395', '124910', '557613', '834014', '454124', '643383', '014352', '918303', '426363', 
'620456', '903429', '808282', '489723', '336481', '000838', '114294', '225009', '914356', '680163', 
'319122', '651828', '043371', '215058', '449301', '576646', '150537', '173468', '876260', '040583', 
'392072', '155142', '790864', '562591', '333650', '684644', '613756', '729466', '994372', '050970', 
'762432', '953779', '638337', '074847', '745089', '861766', '790545', '660625', '191355', '227910', 
'761957', '510654', '202827', '765585', '344913', '644452', '846214', '607996', '858161', '580506', 
'875973', '174743', '070825', '544751', '477271', '597606', '666549', '628543', '152313', '873308', 
'123562');
nr1 number;
nr2 number;
begin
    dbms_random.seed(val =>0);
    for i in 1..200 loop
        nr1:=round(dbms_random.value(low => 1, high => 200));
        nr2:=round(dbms_random.value(low => 1, high => 200));
    
        insert into adrese
        values (i, street_names(nr1), round(dbms_random.value(low=>1, high=>1000)), postal_codes(nr2), round(dbms_random.value(low=>1, high=>10)), round(dbms_random.value(low=>1, high=>10)), round(dbms_random.value(low=>1, high=>100)), round(dbms_random.value(low=>1, high=>42)));
    end loop;
end;
/

select * from adrese;

--angajati

declare
type v_array is varray(100) of varchar(50);
names v_array := v_array('Liam', 'Emma', 'Noah','Olivia', 'William', 'Ava', 'James','Isabella',
'Oliver','Sophia', 'Benjamin','Charlotte', 'Elijah', 'Mia', 'Lucas', 'Amelia', 'Mason', 'Harper', 
'Logan', 'Evelyn', 'Alexander', 'Abigail', 'Ethan', 'Emily', 'Jacob', 'Elizabeth', 
'Michael', 'Mila', 'Daniel', 'Ella', 'Henry', 'Avery', 'Jackson', 'Sofia', 'Sebastian', 'Camila',
'Aiden', 'Aria', 'Matthew', 'Scarlett', 'Samuel', 'Victoria', 'David', 'Madison', 
'Joseph','Luna', 'Carter', 'Grace', 'Owen', 'Chloe', 'Wyatt', 'Penelope', 'John','Layla', 
'Jack', 'Riley', 'Luke', 'Zoey', 'Jayden', 'Nora', 'Dylan', 'Lily', 'Grayson', 'Eleanor', 
'Levi', 'Hannah', 'Isaac', 'Lillian', 'Gabriel', 'Addison', 'Julian', 'Aubrey', 
'Mateo', 'Ellie', 'Anthony', 'Stella', 'Jaxon', 'Natalie', 'Lincoln', 'Zoe', 
'Joshua', 'Leah', 'Christopher', 'Hazel', 'Andrew',	'Violet', 'Theodore', 'Aurora', 
'Caleb', 'Savannah', 'Ryan', 'Audrey', 'Asher', 'Brooklyn', 'Nathan', 'Bella', 
'Thomas', 'Claire', 'Leo', 'Skylar');
surnames v_array:= v_array('Brown', 'Hall', 'Palmer','Green', 'Clark', 'Quinn', 'Harper',
'Johnson', 'Owen', 'Ross', 'Carr', 'Allen', 'Hunter', 'Wilson', 'Davis', 'Rogers',
'Anderson', 'Jennings', 'Day', 'Jackson', 'Hewitt', 'Morgan', 'Kelly', 'Rowe', 'Reynolds',
'Austin', 'Harding', 'Hammond', 'Buckley', 'Burgess','Glover', 'Riley', 'Willis',
'Richardson', 'Hawkins', 'Doyle', 'Wells', 'Perry', 'Heath', 'Bates', 'Steele', 
'Johnston', 'Holland', 'Barnett', 'Jones', 'Spencer', 'Barry', 'Hayes', 'Grant', 'Gardner', 
'Goodwin', 'Cox', 'Chambers', 'Barrett', 'Warren','Little','Coates', 'Archer', 'Mann',
'Howell', 'Dale', 'Oliver', 'Wheeler', 'Andrews', 'Waters','Moss', 'Briggs', 'West', 
'Blake', 'Patterson', 'Higgins', 'Francis', 'Barber', 'Frost', 'Griffin', 'Middleton',
'Murphy', 'Lambert', 'Kent', 'George', 'Marsh', 'Reed', 'Page', 'Stone', 'Dean', 'Booth', 
'Roberts', 'Elliott', 'Bailey', 'Harris', 'Bolton', 'Morton', 'Sanders', 'Joyce', 
'James', 'Smith', 'Hill', 'Douglas', 'Thomson', 'Khan');
phone_numbers v_array:=v_array('0755363698', '0707838219', '0744636919', '0723524945', '0739877899', '0740985615', '0725609077', '0714094975', '0737585614', '0755755007'
, '0798245342', '0773061663', '0731325266', '0758155920', '0740788085', '0782640389', '0726307959', '0789967564', '0766742815', '0764549859'
, '0764009626', '0753892012', '0773523070', '0735563107', '0733998028', '0734684587', '0711574457', '0727878331', '0796184967', '0786862845'
, '0748607497', '0791778373', '0740795197', '0710920793', '0700070544', '0707871597', '0759627725', '0787380976', '0791833342', '0736289983'
, '0771240172', '0775178636', '0799752034', '0784240715', '0789822731', '0744788358', '0732799609', '0797980170', '0773355269', '0797095444'
, '0710308004', '0762661193', '0769455794', '0762232711', '0719912176', '0751879333', '0776805066', '0741057334', '0750687771', '0743123828'
, '0748603520', '0718535253', '0754410619', '0784461914', '0737524065', '0700090413', '0758659633', '0792953996', '0706641987', '0742642088'
, '0772757442', '0732911699', '0751222955', '0758491567', '0762405136', '0784289888', '0713343558', '0798395789', '0729217514', '0764981415'
, '0768879950', '0766198041', '0700902057', '0732515792', '0738839396', '0703539699', '0730276041', '0755200475', '0712009627', '0786474763'
, '0711991016', '0710906532', '0740142893', '0769168675', '0701712867', '0731641205', '0702922791', '0714390079', '0766273606', '0714861970');
nr1 number;
nr2 number;
begin
    dbms_random.seed(val =>0);
    for i in 101..180 loop
        nr1:=round(dbms_random.value(low => 1, high => 100));
        nr2:=round(dbms_random.value(low => 1, high => 100));
    
        insert into angajati (angajat_id, nume, prenume, email, numar_telefon, data_angajarii, data_nasterii, manager_id, job_id, departament_id, salariu)
        values (i, surnames(nr1), names(nr2), surnames(nr1)||'.'||names(nr2)||'@idea.com', phone_numbers(nr1),
        to_date(trunc(dbms_random.value(to_char(date '2000-01-01', 'J'), to_char(date '2020-01-01', 'J'))), 'J'),
        to_date(trunc(dbms_random.value(to_char(date '1950-01-01', 'J'), to_char(date '2002-01-01', 'J'))), 'J'),
        null,
        8,
        round(dbms_random.value(low => 1, high => 7)),
        round(dbms_random.value(low => 1000, high => 5000)));
    end loop;
end;
/

select * from angajati;
select * from departamente;

--case
begin
    for i in 1..10 loop
        insert into case
        values(i, i);
    end loop;
end;
/

--categorii
declare
begin
    for i in 1..20 loop
        insert into categorii
        values(i, 'Categorie ' || i);
    end loop;
end;
/

insert into categorii
values (21, 'Categorie 21', null);

insert into categorii
values (22, 'Categorie 22', null);

insert into categorii
values (23, 'Categorie 23', null);

insert into categorii
values (24, 'Categorie 24', null);

insert into categorii
values (25, 'Categorie 25', null);

insert into categorii
values (26, 'Categorie 26', null);

update categorii
set categorie_parinte_id=21
where categorie_id=1 or categorie_id=10 or categorie_id=13;

update categorii
set categorie_parinte_id=22
where categorie_id=2 or categorie_id=8 or categorie_id=18 or categorie_id=19;

update categorii
set categorie_parinte_id=23
where categorie_id=4 or categorie_id=11 or categorie_id=14;

update categorii
set categorie_parinte_id=24
where categorie_id=15 or categorie_id=16;

update categorii
set categorie_parinte_id=25
where categorie_id=12 or categorie_id=20;

update categorii
set categorie_parinte_id=26
where categorie_id=24 or categorie_id=25;

select * from categorii;

--comenzi
declare
status_comanda number;
data_efectuarii date;
data_livrarii date;
us_id number;
adr_id number;
sofer_id number;
type v_array is varray(100) of number;
soferi v_array:=v_array();
trans_id number;
voucher number;
valoare_random number;
begin
    dbms_random.seed(val =>0);
    --pun toti soferii in soferi
    select angajat_id
    bulk collect into soferi
    from angajati
    where job_id=7;
    
    --voi introduce 130 de comenzi
    for i in 1..130 loop
        
        --iau cu random statusul comenzii
        status_comanda:=round(dbms_random.value(high=>3, low=>0));
        --si id-ul userului
        us_id:=round(dbms_random.value(high=>100, low=>1));
        
        data_efectuarii:=to_date(trunc(dbms_random.value(to_char(date '2000-01-01', 'J'), to_char(date '2020-01-01', 'J'))), 'J');
        data_livrarii:=to_date(trunc(dbms_random.value(to_char(data_efectuarii, 'J'), (to_char(add_months(data_efectuarii, 3), 'J')))), 'J');
        voucher:=round(dbms_random.value(low=>1, high=>100));
        valoare_random:=round(dbms_random.value(1, 1000));
        if mod(valoare_random, 10)>0 then
            voucher:=0;
        end if;
        --daca comanda a fost livrata
        if status_comanda=2 then
            --trebuie sa adaug si transportul in lista de transporturi
            --deci imi trebuie adresa utilizatorului care a fectuat comanda
            select adresa_id
            into adr_id
            from useri_magazin_online 
            where user_id=us_id;
            
            --adaug trasnportul
            
            trans_id:=seq1.nextval;
            insert into transporturi
            values (trans_id, adr_id, soferi(round(dbms_random.value(low=>1, high=>14))));
            
            --adaug comanda, cu tot cu id-ul transportului
            insert into comenzi(comanda_id, status_comanda, data_efectuarii, data_livrarii, user_id, voucher_aplicat_id, transport_id)
            values (i, --id
            status_comanda, --status
            data_efectuarii, 
            data_livrarii, --daca comanda nu a fost livrata nu data_livrarii e null
            us_id,--id user
            decode(voucher,0, null, voucher), --am luat o valoare random cu 10% sanse sa aplice un voucer
                            --daca valoarea din random e divizibila cu 10 voi alege un voucher random care sa se aplice pe comanda, altfel am null
            trans_id);
        else
            --altfel, la transport_id am null
            insert into comenzi(comanda_id, status_comanda, data_efectuarii, data_livrarii, user_id, voucher_aplicat_id, transport_id)
            values (i, --id
            status_comanda, --status
            data_efectuarii, 
            null, --daca comanda nu a fost livrata nu data_livrarii e null
            us_id,--id user
            decode(voucher,0, null, voucher), --am luat o valoare random cu 10% sanse sa aplice un voucer
                            --daca valoarea din random e divizibila cu 10 voi alege un voucher random care sa se aplice pe comanda, altfel am null
            null);
        end if;
    end loop;
end;
/


select * from comenzi;
select * from transporturi;
delete from transporturi where transport_id>0;
delete from comenzi where comanda_id>0;

set serveroutput on;

create sequence seq1
minvalue 1
increment by 1;

select * from comenzi;

--insert into comenzi
--values (1, 0, sysdate, null, 


--componente_produse
declare
numar_necesar number;
numar_subcomponente number;
componenta number;
componenta_necesara_stoc_curent number;
pret_componenta number;
index_nou_produs number;
nr number:=0;
begin
    --voi genera 200 de produse care incapsuleaza alte produse
    for i in 1..200 loop
        --produsul i va avea numar_componente
        numar_subcomponente:=round(dbms_random.value(low=>2, high=>6));
        index_nou_produs:=800+i;
        
        --inserez produsul incapsulator in tabela
        insert into produse
        values(index_nou_produs, null, 0, null, 'Produs '||index_nou_produs);
        --voi adauga relatiile de incapsulare
        for j in 1..numar_subcomponente loop
            numar_necesar:= round(dbms_random.value(low=>1, high=>10));
            componenta:=round(dbms_random.value(low=>1, high=>800));
            
            if componenta<=100 or componenta>=161 then
                select count(*)
                into nr
                from componente_produse
                where componenta_id=componenta
                and produs_final_id=index_nou_produs;
                
                if nr=0 then
                
                    insert into componente_produse
                    values (componenta, 
                    index_nou_produs, numar_necesar);
                    
                    --stocul curent din produsul incapsulator o sa fie min(stoc_curent, stoc_curent_componenta_necesara/numar_necesar)
                    
                    select stoc_curent, pret_unitar
                    into componenta_necesara_stoc_curent, pret_componenta
                    from produse
                    where produs_id=componenta;
                    
                    dbms_output.put_line(floor(componenta_necesara_stoc_curent/numar_necesar));
                    
    --                set stoc_curent=decode(stoc_curent, null, floor(componenta_necesara_stoc_curent/numar_necesar),
    --                decode(stoc_curent>floor(componenta_necesara_stoc_curent/numar_necesar), true, floor(componenta_necesara_stoc_curent/numar_necesar), stoc_curent)),
                    
                    
                    
                    update produse
                    set stoc_curent= case
                                        when stoc_curent is null then floor(componenta_necesara_stoc_curent/numar_necesar)
                                        when stoc_curent>floor(componenta_necesara_stoc_curent/numar_necesar) then floor(componenta_necesara_stoc_curent/numar_necesar)
                                        else stoc_curent
                                        end,
                    pret_unitar=pret_unitar+pret_componenta*numar_necesar
                    where produs_id=index_nou_produs;
                else
                    nr:=0;
                end if;
            
            end if;
        end loop;
    end loop;
end;
/

select count(*) from componente_produse;
rollback;

--vreau sa verific ca nu exista doua produse finale du acelasi componente si acelasi numar necesar pentru fiecare componenta
create type number_number is object
( componenta number,
  numar_necesar number );
/

declare
type v_array is varray(200) of number_number;
type v_array2 is varray(200) of number;
produse_ce_trebuie_sterse v_array2:=v_array2();
lista_componente1 v_array:=v_array();
lista_componente2 v_array:=v_array();
intersectie v_array:=v_array();
ok number :=0;--ok insemna daca sunt identice sau nu
nr number:=1;
begin
    for i in 101..160 loop
        
        for j in (i+1)..160 loop

            select count(*)
            into ok
            from componente_produse a, componente_produse b
            where a.produs_final_id=j
            and b.produs_final_id=i
            and a.componenta_id=b.componenta_id
            and a.numar_necesar=b.numar_necesar;
            
            if ok>0 then
                dbms_output.put_line(i || ' ' || j);
                delete from componente_produse
                where produs_final_id=j;
            end if;
        end loop;
    end loop;
end;
/    
set serveroutput on;
create sequence seq6
minvalue 0
increment by 1;
/

set serveroutput on;
select * from produse;
select * from componente_produse;

delete from componente_produse where componenta_id>0;
delete from produse where produs_id>100;

create sequence seq2
minvalue 1
increment by 1;

create sequence seq3
minvalue 101
increment by 1;


--departamente
declare
type v_array is varray(100) of varchar2(70);
lista_departamente v_array := v_array('Production', 'Research', 'Purchasing', 'Marketing',
'Human Resource Management', 'Accounting and Finance', 'Sales');
begin
    for i in 1..7 loop
        insert into departamente
        values (i, lista_departamente(i));
    end loop;
end;
/

select * from departamente;

--discounturi
declare
valoare number;
data_inceput date;
data_final date;
begin
    for i in 1..100 loop
        valoare:=round(dbms_random.value(low=>5, high=>90));
        data_inceput:=to_date(trunc(dbms_random.value(to_char(date '2000-01-01', 'J'), to_char(date '2022-01-01', 'J'))), 'J');
        data_final:=to_date(trunc(dbms_random.value(to_char(data_inceput, 'J'), to_char(add_months(data_inceput, 6), 'J'))), 'J');
        insert into discounturi
        values (i, valoare, data_inceput, data_final);
    end loop;
end;
/

select * from discounturi;
delete from discounturi where discount_id>0;

--discounturi_categorii
declare
data_start date;
data_finish date;
categorie number;
nr number;
discount number;
begin
    dbms_random.seed(val =>0);
    for i in 1..40 loop
        discount:=round(dbms_random.value(low=>1, high=>100));
        categorie:=round(dbms_random.value(low=>1, high=>20));
    
        dbms_output.put_line(discount||' '||categorie);
    
        select data_inceput, data_final
        into data_start, data_finish
        from discounturi
        where discount_id=discount;
        
        --vreau sa vad daca pe categoria categorie, in perioada data_start, data_finsh, am vreun discount deja aplicat 
        if i>1 then
            select count(*)
            into nr
            from discounturi_categorii a, discounturi b
            where a.discount_id= b.discount_id
            and a.categorie_id=categorie
            and data_start<=data_final
            and data_finish<=data_inceput;
            
            
            
            dbms_output.put_line(nr);
            
            if nr=0 then
                insert into discounturi_categorii
                values(i, categorie);
            end if;
        else
            insert into discounturi_categorii
            values(i, categorie);
        end if;
    end loop;
end;
/
set serveroutput on;

select * from discounturi_categorii;
delete from discounturi_categorii where discount_id>0;

--discounturi produse

declare
nr number;
discount number;
produs number;
begin
    dbms_random.seed(val =>0);
    for i in 1..200 loop
    
        discount:=round(dbms_random.value(low=>1, high=>100));
        produs:=round(dbms_random.value(low=>1, high=>160));
        
        select count(*)
        into nr
        from discounturi_produse
        where discount_id=discount
        and produs_id=produs;
        
        if nr=0 then
            insert into discounturi_produse
            values(discount, produs);
        end if;
    end loop;
end;
/
select * from discounturi_produse;
delete from discounturi_produse where produs_id>0;
--garantii
insert into garantii
values (1, 24);

insert into garantii
values (2, 1);

insert into garantii
values (3, 6);

insert into garantii
values (4, 12);

--joburi
declare
type v_array is varray(100) of varchar2(70);
lista_joburi v_array := v_array('Sales Associate', 'Cashier', 'Customer Service Representative', 
'Visual Merchandiser', 'Inventory Control Specialist', 'Retail Security Officer', 'Driver');
begin
    for i in 1..7 loop
        insert into joburi
        values (i, lista_joburi(i));
    end loop;
end;
/

delete from angajati
where angajat_id>0;

delete from joburi
where job_id>0;
select * from joburi;

insert into joburi
values (8, 'Sales Consulting');


--judete
declare
type v_array is varray(100) of varchar(50);
type big_v_array is varray(1000) of varchar(10);
lista_judete v_array := v_array('Alba', 'Arad', 'Arges', 'Bacau', 'Bihor', 'Bistrita-Nasaud', 'Botosani', 'Brasov',
'Braila', 'Bucuresti', 'Buzau', 'Caras-Severin', 'Clarasi', 'Cluj', 'Constanta', 'Covasna', 'Dambovita',
'Dolj', 'Galati', 'Giurgiu', 'Gorj', 'Harghita','Hunedoara', 'Ialomita', 'Iasi', 'Ilfov', 'Maramures','Mehedinti',
'Mures', 'Neamt', 'Olt', 'Prahova', 'Satu Mare', 'Salaj', 'Sibiu', 'Suceava', 'Teleorman', 'Timis', 'Tulcea',
'Vaslui', 'Valcea', 'Vrancea');
begin
    dbms_random.seed(val =>0);
    for i in 1..42 loop
        insert into judete
        values (i, lista_judete(i));
    end loop;
end;
/

select * from judete;

--orase
/
declare
type v_array is varray(100) of varchar2(70);
lista_orase v_array := v_array('Alba Iulia', 'Arad', 'Pitesti', 'Bacau', 'Oradea', 'Bistrita', 
'Botosani', 'Brasov', 'Braila','Bucuresti', 'Buzau', 'Resita', 'Calarasi','Cluj-Napoca', 'Constanta',
'Sfantu Gheorghe', 'Targoviste', 'Craiova', 'Galati', 'Giurgiu', 'Targu Jiu', 'Miercurea Ciuc', 'Deva', 'Slobozia',
'Iasi', 'Bucuresti', 'Baia Mare', 'Drobeta-Turnu Severin', 'Targu Mures', 'Piatra Neamt', 'Slatina',
'Ploiesti', 'Satu Mare', 'Zalaj', 'Sibiu', 'Suceava', 'Alexandria', 'Timisoara', 'Tulcea', 'Vaslui', 
'Ramnicu Valcea', 'Focsani');
begin
    for i in 1..42 loop
        insert into orase(oras_id, nume_oras, judet_id)
        values (i, lista_orase(i), i);
    end loop;
end;
/

select * from orase;

--produse
declare
begin
    for i in 161..800 loop
        insert into produse
        values(i, 
        round(dbms_random.value(low=>0, high=>50)), 
        round(dbms_random.value(low=>10, high=>5200)), 
        round(dbms_random.value(low=>1, high=>300)), 
        'Produs '||i);
    end loop;
end;
/
rollback;
select * from produse;

delete from produse where produs_id>0;
delete from componente_produse where componenta_id>0;

--produse_achiztii

declare
type v_array is varray(100) of number;
valori v_array;
produs number;
achizitie number;
nr number :=0;
data_efectuarii_achizitiei date;
pret_facturare number;
valoare number;
begin
    for i in 1..9000 loop
        produs:=round(dbms_random.value(high=>1000, low=>1));
        achizitie:=round(dbms_random.value(high=>5000, low=>1));
        select pret_unitar
        into pret_facturare
        from produse
        where produs_id=produs;
        
        select count(*)
        into nr
        from produse_achizitii
        where produs_id=produs
        and achizitie_id=achizitie;
        --daca nu a fost deja inserat produsul in comanda
        if nr=0 then
            select a.data_achizitiei
            into data_efectuarii_achizitiei
            from achizitii_in_magazin a
            where achizitie_id=achizitie;
            
            --pun toate discounturile aplicate pe produs in valori
            select a.valoare
            bulk collect into valori
            from discounturi a, discounturi_produse b
            where a.discount_id=b.discount_id
            and b.produs_id=produs
            and data_inceput<=data_efectuarii_achizitiei
            and data_efectuarii_achizitiei>=data_final;
            
            for valoare in nvl(valori.first, 0)..nvl(valori.last, -1) loop
                pret_facturare:=(100-valoare)*pret_facturare/100;
            end loop;
            
            --nr:=1;
            --caut discount-ul pe categorie in acea perioada
            select count(*)
            into nr
            from discounturi_categorii a, discounturi b, produse_categorii c
            where a.discount_id=b.discount_id
            and c.categorie_id=a.categorie_id
            and c.produs_id=produs
            and b.data_inceput<=data_efectuarii_achizitiei
            and data_efectuarii_achizitiei>=b.data_final;
            
            if nr=1 then
            
                select b.valoare
                into valoare
                from discounturi_categorii a, discounturi b, produse_categorii c
                where a.discount_id=b.discount_id
                and c.categorie_id=a.categorie_id
                and c.produs_id=produs
                and b.data_inceput<=data_efectuarii_achizitiei
                and data_efectuarii_achizitiei>=b.data_final;
                
                pret_facturare:=(100-valoare)*pret_facturare/100;
            end if;
            
                insert into produse_achizitii
                values(produs, achizitie, round(dbms_random.value(high=>8, low=>1)), round(pret_facturare, 2));
            
        else
            dbms_output.put_line('Deja exista acest produs in aceasta comanda');
        end if;
        
        nr:=0;
    end loop;
end;
/

select * from produse_achizitii;




--produse_categorii
declare
nr number;
begin
    dbms_random.seed(val =>0);
    for i in 1..160 loop
        nr:=round(dbms_random.value(low=>1, high=>20));
        insert into produse_categorii
        values (i, nr);
    end loop;
end;
/

declare
nr number;
begin
    dbms_random.seed(val =>0);
    for i in 1..1000 loop
        nr:=round(dbms_random.value(low=>1, high=>26));
        insert into produse_categorii
        values (i, nr);
    end loop;
end;
/

delete from produse_categorii where produs_id>0;

select * from produse_categorii;
--produse_comenzi

declare
type v_array is varray(100) of number;
valori v_array;
produs number;
comanda number;
nr number :=0;
data_comenzii date;
pret_facturare number;
valoare number;
begin
    for i in 1..9000 loop
        produs:=round(dbms_random.value(high=>160, low=>1));
        comanda:=round(dbms_random.value(high=>130, low=>1));
        select pret_unitar
        into pret_facturare
        from produse
        where produs_id=produs;
        
        select count(*)
        into nr
        from produse_comenzi
        where produs_id=produs
        and comanda_id=comanda;
        --daca nu a fost deja inserat produsul in comanda
        if nr=0 then
            select data_efectuarii
            into data_comenzii
            from comenzi
            where comanda_id=comanda;
            
            --pun toate discounturile aplicate pe produs in valori
            select a.valoare
            bulk collect into valori
            from discounturi a, discounturi_produse b
            where a.discount_id=b.discount_id
            and b.produs_id=produs
            and data_inceput<=data_comenzii
            and data_comenzii>=data_final;
            
            for valoare in nvl(valori.first, 0)..nvl(valori.last, -1) loop
                pret_facturare:=(100-valoare)*pret_facturare/100;
            end loop;
            
            nr:=1;
            select count(*)
            into nr
            from discounturi_categorii a, discounturi b, produse_categorii c
            where a.discount_id=b.discount_id
            and c.categorie_id=a.categorie_id
            and c.produs_id=produs
            and b.data_inceput<=data_comenzii
            and data_comenzii>=b.data_final;
            
            if nr=1 then
            
                select b.valoare
                into valoare
                from discounturi_categorii a, discounturi b, produse_categorii c
                where a.discount_id=b.discount_id
                and c.categorie_id=a.categorie_id
                and c.produs_id=produs
                and b.data_inceput<=data_comenzii
                and data_comenzii>=b.data_final;
                
                pret_facturare:=(100-valoare)*pret_facturare/100;
            end if;
            
                insert into produse_comenzi
                values(produs, comanda, round(dbms_random.value(high=>8, low=>1)), round(pret_facturare, 2));
            
        end if;
        
        nr:=0;
    end loop;
end;
/

select * from produse_comenzi;
delete from produse_comenzi where produs_id>0;
select * from comenzi;
select * from discounturi;
update produse_comenzi
set pret_facturare=round(pret_facturare, 2)
where produs_id>0;

--produse_magazine

--rafturi
declare
begin
    for i in 1..300 loop
        insert into rafturi
        values(i, i, round(dbms_random.value(low=>1, high=>30)));
    end loop;
end;
/


--raioane
declare
begin
    for i in 1..30 loop
        insert into raioane
        values(i, i, round(dbms_random.value(low=>1, high=>5)));
    end loop;
end;
/
select * from raioane;
delete from raioane where raion_id>0;

--transporturi

declare
begin
    dbms_random.seed(val =>0);
    for i in 1..100 loop
        nr:=round(dbms_random.value(low=>1, high=>2));
        
    end loop;
end;
/
--useri_magazin_online
declare
type v_array is varray(100) of varchar(20);
type big_v_array is varray(1000) of varchar(10);
names v_array := v_array('Liam', 'Emma', 'Noah','Olivia', 'William', 'Ava', 'James','Isabella',
'Oliver','Sophia', 'Benjamin','Charlotte', 'Elijah', 'Mia', 'Lucas', 'Amelia', 'Mason', 'Harper', 
'Logan', 'Evelyn', 'Alexander', 'Abigail', 'Ethan', 'Emily', 'Jacob', 'Elizabeth', 
'Michael', 'Mila', 'Daniel', 'Ella', 'Henry', 'Avery', 'Jackson', 'Sofia', 'Sebastian', 'Camila',
'Aiden', 'Aria', 'Matthew', 'Scarlett', 'Samuel', 'Victoria', 'David', 'Madison', 
'Joseph','Luna', 'Carter', 'Grace', 'Owen', 'Chloe', 'Wyatt', 'Penelope', 'John','Layla', 
'Jack', 'Riley', 'Luke', 'Zoey', 'Jayden', 'Nora', 'Dylan', 'Lily', 'Grayson', 'Eleanor', 
'Levi', 'Hannah', 'Isaac', 'Lillian', 'Gabriel', 'Addison', 'Julian', 'Aubrey', 
'Mateo', 'Ellie', 'Anthony', 'Stella', 'Jaxon', 'Natalie', 'Lincoln', 'Zoe', 
'Joshua', 'Leah', 'Christopher', 'Hazel', 'Andrew',	'Violet', 'Theodore', 'Aurora', 
'Caleb', 'Savannah', 'Ryan', 'Audrey', 'Asher', 'Brooklyn', 'Nathan', 'Bella', 
'Thomas', 'Claire', 'Leo', 'Skylar');
surnames v_array:= v_array('Brown', 'Hall', 'Palmer','Green', 'Clark', 'Quinn', 'Harper',
'Johnson', 'Owen', 'Ross', 'Carr', 'Allen', 'Hunter', 'Wilson', 'Davis', 'Rogers',
'Anderson', 'Jennings', 'Day', 'Jackson', 'Hewitt', 'Morgan', 'Kelly', 'Rowe', 'Reynolds',
'Austin', 'Harding', 'Hammond', 'Buckley', 'Burgess','Glover', 'Riley', 'Willis',
'Richardson', 'Hawkins', 'Doyle', 'Wells', 'Perry', 'Heath', 'Bates', 'Steele', 
'Johnston', 'Holland', 'Barnett', 'Jones', 'Spencer', 'Barry', 'Hayes', 'Grant', 'Gardner', 
'Goodwin', 'Cox', 'Chambers', 'Barrett', 'Warren','Little','Coates', 'Archer', 'Mann',
'Howell', 'Dale', 'Oliver', 'Wheeler', 'Andrews', 'Waters','Moss', 'Briggs', 'West', 
'Blake', 'Patterson', 'Higgins', 'Francis', 'Barber', 'Frost', 'Griffin', 'Middleton',
'Murphy', 'Lambert', 'Kent', 'George', 'Marsh', 'Reed', 'Page', 'Stone', 'Dean', 'Booth', 
'Roberts', 'Elliott', 'Bailey', 'Harris', 'Bolton', 'Morton', 'Sanders', 'Joyce', 
'James', 'Smith', 'Hill', 'Douglas', 'Thomson', 'Khan');
phone_numbers big_v_array:=big_v_array('0767409078', '0777693722', '0781909140', '0757193574', '0781736900', '0799133358', '0799643554', '0790929083', '0786119305', '0799619310'
, '0744997139', '0736705894', '0788912427', '0773624795', '0752274190', '0704660725', '0703478966', '0797533068', '0724498630', '0769160449'
, '0761279635', '0769986050', '0773307842', '0703626849', '0787346363', '0784534175', '0720078460', '0716034871', '0761835590', '0779875097'
, '0793828684', '0791582125', '0751962447', '0772815495', '0782682028', '0780318825', '0799304681', '0763424860', '0722115572', '0705954022'
, '0758740050', '0706225256', '0796515328', '0731649240', '0764242345', '0770486812', '0723106231', '0742637733', '0743343181', '0705176275'
, '0723137398', '0788833550', '0793357484', '0781658409', '0794068824', '0718443854', '0770128093', '0754650799', '0730898717', '0704318339'
, '0783884740', '0786039964', '0791276966', '0719352649', '0771683424', '0738868822', '0717550909', '0783311779', '0795885028', '0787498482'
, '0728138783', '0796678709', '0761784568', '0736740815', '0740911595', '0705153061', '0797432973', '0713914783', '0743363907', '0710185811'
, '0706863281', '0704793388', '0740027570', '0752058282', '0752406585', '0794225445', '0742415314', '0741927734', '0767337702', '0731722833'
, '0724872128', '0711266730', '0734096218', '0705152701', '0710314871', '0753961453', '0737985804', '0775061833', '0792285523', '0783944454'
, '0709584957', '0779543215', '0713646789', '0767111315', '0718011613', '0737412197', '0740355626', '0745409049', '0732640247', '0762616722'
, '0748295126', '0776556605', '0782860076', '0747366350', '0779950658', '0777010143', '0760569486', '0740820115', '0751373773', '0718324755'
, '0730305278', '0721854519', '0708852913', '0759912548', '0711534641', '0708236095', '0746943856', '0797277383', '0798758205', '0704108041'
, '0733318263', '0798306944', '0718203974', '0743700661', '0723807991', '0716557894', '0785425933', '0783196633', '0774901039', '0754847808'
, '0749082861', '0789455424', '0724695011', '0796820611', '0786725219', '0727166549', '0710085392', '0748027059', '0742124693', '0712755591'
, '0747940981', '0745690042', '0728814397', '0712115958', '0778236408', '0729716341', '0732140323', '0715892370', '0749487798', '0750664911'
, '0710456243', '0728334754', '0768621925', '0713721499', '0734490415', '0709373243', '0734992022', '0789854135', '0741433845', '0713068037'
, '0766929648', '0772931861', '0741975255', '0782351537', '0787184171', '0796231717', '0724469297', '0764135930', '0795576377', '0704020505'
, '0718847712', '0716749520', '0778420389', '0730113603', '0729426425', '0760807472', '0760870296', '0768480921', '0722114553', '0752511445'
, '0789833201', '0776990679', '0752159496', '0745117709', '0781372367', '0785456983', '0706919466', '0759283957', '0702956880', '0772278168'
, '0770410154', '0744305916', '0744548952', '0701269041', '0786383103', '0739895818', '0755340002', '0792877389', '0701972838', '0777714861'
, '0722463011', '0759001290', '0765176559', '0700374702', '0720859752', '0707557964', '0756880379', '0758943950', '0782092807', '0776556742'
, '0767768263', '0735773906', '0780314522', '0750711489', '0776796439', '0701326758', '0780407685', '0780275852', '0720030346', '0720498930'
, '0783877890', '0702903809', '0781366666', '0778233846', '0776564305', '0763943858', '0737105141', '0794837720', '0752851149', '0712564291'
, '0777737614', '0753615016', '0729938137', '0790672588', '0725071633', '0738483732', '0747534554', '0755630519', '0725679504', '0795453536'
, '0738092346', '0755874582', '0794002483', '0757401486', '0762722630', '0792706559', '0737442035', '0702103264', '0739314764', '0754470902'
, '0795726887', '0732401188', '0735286659', '0753269444', '0798790699', '0714629404', '0704144984', '0737097872', '0714753676', '0772554943'
, '0796661491', '0751718853', '0715675077', '0756288012', '0760261533', '0734473457', '0795539666', '0758254243', '0779382444', '0708858278'
, '0755363698', '0707838219', '0744636919', '0723524945', '0739877899', '0740985615', '0725609077', '0714094975', '0737585614', '0755755007'
, '0798245342', '0773061663', '0731325266', '0758155920', '0740788085', '0782640389', '0726307959', '0789967564', '0766742815', '0764549859'
, '0764009626', '0753892012', '0773523070', '0735563107', '0733998028', '0734684587', '0711574457', '0727878331', '0796184967', '0786862845'
, '0748607497', '0791778373', '0740795197', '0710920793', '0700070544', '0707871597', '0759627725', '0787380976', '0791833342', '0736289983'
, '0771240172', '0775178636', '0799752034', '0784240715', '0789822731', '0744788358', '0732799609', '0797980170', '0773355269', '0797095444'
, '0710308004', '0762661193', '0769455794', '0762232711', '0719912176', '0751879333', '0776805066', '0741057334', '0750687771', '0743123828'
, '0748603520', '0718535253', '0754410619', '0784461914', '0737524065', '0700090413', '0758659633', '0792953996', '0706641987', '0742642088'
, '0772757442', '0732911699', '0751222955', '0758491567', '0762405136', '0784289888', '0713343558', '0798395789', '0729217514', '0764981415'
, '0768879950', '0766198041', '0700902057', '0732515792', '0738839396', '0703539699', '0730276041', '0755200475', '0712009627', '0786474763'
, '0711991016', '0710906532', '0740142893', '0769168675', '0701712867', '0731641205', '0702922791', '0714390079', '0766273606', '0714861970');
nr1 number;
nr2 number;
begin
    dbms_random.seed(val =>0);
    for i in 1..100 loop
        nr1:=round(dbms_random.value(low => 1, high => 100));
        nr2:=round(dbms_random.value(low => 1, high => 100));
    
        insert into useri_magazin_online (user_id, email, nume, prenume, numar_telefon, gen, data_nasterii, adresa_id)
        values (i, names(nr1) || '.' || surnames(nr2) || '@gmail.com', surnames(nr2), names(nr1), phone_numbers(i), decode(mod(nr1,2),0, 'feminin', 'masculin'), 
        to_date(trunc(dbms_random.value(to_char(date '1950-01-01', 'J'), to_char(date '2002-01-01', 'J'))), 'J'),
        round(dbms_random.value(low=>1, high=>200)));
    end loop;
end;
/

select * from useri_magazin_online;
delete from useri_magazin_online
where user_id>0;

set serveroutput on;

declare
begin
    dbms_random.seed(val =>0);
    for i in 1..100 loop
        update useri_magazin_online
        set adresa_id=round(dbms_random.value(low=>1, high=>200));
    end loop;
end;
/

--vouchere
declare
type v_array is varray(100) of varchar(20);
lista_coduri v_array:= v_array('EAS26974R5', '0G89011057', 'P16IAW2L40', '509C0689W0', 'M492914XA1', '666U6OX3PH', 'E379940805', 'YJ665552X0', 'H4V67G8798', 
'00Q9021H86', 'R9731Y32B0', '54J3451873', 'SPNNXL24L7', 'PC1J8XU915', '0P30108G08', '3L930O013P', '1168435413', 'M168XF6JD3', '9MF15R09M1', 
'4720IQ5Z48', 'CEPL69V772', '30282F929V', 'I3556W391G', '3B8J70K492', '70446T9987', 'V12Q7E1N52', 'XG51Q58567', 'A5UB570913', '3I8G7Q77EN', 
'246610X871', 'I41N5I56F6', '734432LI50', '515O16G5I1', '5L0890QL82', '23GG98K8Y6', '34L5AA7SO4', 'N893S61E43', 'TSO6D0OEG5', 'CY09O450L1', 
'4080KI7026', '2877L440U4', '5954XR946Y', '7479405496', '102837U09K', '3CX69N7F71', '4BFA852560', '3IRDU34B02', '9N7009311Z', '489F5BWT93', 
'AJ0S5W22C8', '048PTZ388I', '2LR1N1Q0C4', '08NTC77TLJ', '47X5J5103W', '5ID22V83S1', 'K5199O087H', '825L26PS6J', 'X768R800Y2', 'AU14V2C2Q5', 
'79K3306963', '584SK9B7FB', '90TF5A74E7', '5521763334', '9693R99958', '1859168550', 'CF0725221G', 'X27N94X9C3', 'DG2Q3X6O59', '3T74JTE655', 
'V9S46C1YWL', '12E7O06S3B', '29548UYFDB', '652F02V4YL', '618RJRI7SQ', 'T573D7G35Y', '2S0190B636', '6872JR0VTV', 'L2Z35577L6', '668J4057M7', 
'QC5J4D349M', '271X8K106N', 'J25Y37JXB2', '6H5346WUT4', '6721198E33', 'UH93B78K63', 'LD6EY4K773', 'RKB2993K39', '7049O64AJ7', '948U6HET9O', 
'UNI089P732', 'KGXPP1M94Y', 'M782D1EHZ5', '96O8MO567B', '35001P6AN9', '23635E8K6R', '72M5LE9969', '4R888URDL7', 'FUVZ344790', '446M59E284', 
'837MD472UR');
start_date date;
end_date date;
begin
    dbms_random.seed(val =>0);
    for i in 1..100 loop
        start_date:=to_date(trunc(dbms_random.value(to_char(date '2000-01-01', 'J'), to_char(date '2020-01-01', 'J'))), 'J');
        end_date:=to_date(trunc(dbms_random.value(to_char(start_date, 'J'), to_char(date '2020-01-01', 'J'))), 'J');
    
        insert into vouchere
        values(i, lista_coduri(i), round(dbms_random.value(low=>1, high=>20))*50,  start_date, end_date);
    end loop;
end;
/

select * from vouchere;
delete from vouchere where voucher_id>0;

--zone

select * from zone;
delete from rafturi where raft_id>0;
delete from raioane where raion_id>0;
delete from zone where zona_id>0;

declare
begin
    for i in 1..5 loop
        insert into zone
        values(i, i);
    end loop;
end;
/

-------------------------------------------------------------------------------
6. COLECTIE
-------------------------------------------------------------------------------
function exercitiul_6
return number
as
cei_mai_productivi_indrumatori indexed_by_table_of_info_mentor;
nr_necesar_mentori number;
productivitate_maxima number;
contor_productivi number:=1;
nr_indrumatori number;
indrumatori_cu_productivitate_maxima number;
suma_maririlor_de_salariu number:=0;
marire_salariu number;
begin
    
    --aici nu poate sa imi dea eroare pentru ca am count
    select count(*)
    into nr_indrumatori
    from angajati
    where job_id=8;

    --nici aici nu poate sa imi dea eroare pentru ca am bulk collect into
    select e.indrumator_id, sum(f.pret_facturare*f.numar_produse), max(a.nume), max(a.prenume)
    bulk collect into cei_mai_productivi_indrumatori
    from achizitii_in_magazin e, produse_achizitii f, angajati a
    where e.achizitie_id=f.achizitie_id
    and e.indrumator_id=a.angajat_id
    and e.data_achizitiei>add_months(sysdate, -1)
    and e.data_achizitiei<=sysdate
    group by e.indrumator_id
    order by sum(f.pret_facturare*f.numar_produse) desc;
    
    nr_necesar_mentori:=floor(nr_indrumatori/10);
    dbms_output.put_line('nr necesar mentori: ' || nr_necesar_mentori);
    afisare_mentori();
    
    --daca inca nu am pus numarul necesar de mentori sau daca inca nu am pus toti angajatii cu productivitate maxima
    while mentori.count<nr_necesar_mentori or cei_mai_productivi_indrumatori(contor_productivi).suma=cei_mai_productivi_indrumatori(1).suma loop
        --daca inca nu am pus toti mentorii
        if mentori.count<=nr_necesar_mentori then
            mentori(contor_mentori):=cei_mai_productivi_indrumatori(contor_productivi).id_angajat;
            
            select round(salariu*1/10, 2)
            into marire_salariu
            from angajati
            where angajat_id=mentori(contor_mentori);
            
            update angajati
            set salariu=round(salariu*11/10, 2)
            where angajat_id=mentori(contor_mentori);
            
            suma_maririlor_de_salariu:=suma_maririlor_de_salariu+marire_salariu;
            
            dbms_output.put_line('Angajatul '||cei_mai_productivi_indrumatori(contor_productivi).nume || ' ' || cei_mai_productivi_indrumatori(contor_productivi).prenume || ' a devenit mentor!');
            contor_mentori:=contor_mentori+1;
            if contor_mentori = nr_necesar_mentori+1 then
                contor_mentori:=1;
            end if;
            contor_productivi:=contor_productivi+1;
            
        else
        --daca deja am pus destui pun doar cat timp mai au productivitate maxima
            if cei_mai_productivi_indrumatori(contor_productivi).suma = cei_mai_productivi_indrumatori(1).suma then
                
                --too_many_rows nu se poate pentru ca cheia primara e unica
                update angajati
                set salariu=round(salariu*9/10,2)
                where angajat_id=mentori(contor_mentori);
                
                mentori(contor_mentori):=cei_mai_productivi_indrumatori(contor_productivi).id_angajat;
                
                select salariu*round(1/10,2)
                into marire_salariu
                from angajati
                where angajat_id=mentori(contor_mentori);
                
                update angajati
                set salariu=round(salariu*11/10, 2)
                where angajat_id=mentori(contor_mentori);
                
                suma_maririlor_de_salariu:=suma_maririlor_de_salariu+marire_salariu;
                
                dbms_output.put_line('Angajatul '||cei_mai_productivi_indrumatori(contor_productivi).nume || ' ' || cei_mai_productivi_indrumatori(contor_productivi).prenume || ' a devenit mentor!');  
                
                contor_mentori:=contor_mentori+1;
                if contor_mentori = nr_necesar_mentori+1 then
                    contor_mentori:=1;
                end if;
                contor_productivi:=contor_productivi+1;
            end if;
            
        end if;
        
    end loop;
    
    
    return suma_maririlor_de_salariu;
    
    exception
        when no_data_found then
            raise_application_error(-20000, 'Angajatul nu a fost gasit!');
        when others then
            raise_application_error(-20001, 'Alta eroare!');
end exercitiul_6;

-------
Testare
-------
begin
proiect.contor_mentori:=1;
proiect.mentori.delete;
dbms_output.put_line(proiect.exercitiul_6());
end;
/


-------------------------------------------------------------------------------
7. CURSOR
-------------------------------------------------------------------------------
create or replace procedure exercitiul_7 (user_conectat_id number default null)
is
nr_linii number:=1;
cantitate_user_conectat number:=0;
exista_user number:=0;
begin
--merg prin toate categoriile
    if user_conectat_id is not null then 
        select count(*)
        into exista_user
        from useri_magazin_online
        where user_id=user_conectat_id;
        
        if exista_user=0 then
            raise_application_error(-20006, 'Nu exista un user cu id-ul dat!');
        end if;
    end if;

    for categorie in (select nume_categorie, categorie_id, level
                      from categorii
                      start with categorie_parinte_id is null
                      connect by prior categorie_id=categorie_parinte_id) loop
        dbms_output.put_line('---------------------------------------------------------------------------------------');
        dbms_output.put_line(rpad(' ', (categorie.level-1)*5, ' ') || categorie.level || '. ' || 'Categoria: '  || categorie.nume_categorie);
        dbms_output.put_line('---------------------------------------------------------------------------------------');
        nr_linii:=1; 
        --prin toate produsele din acea categorie
        for produs in ( select max(c.denumire_produs) denumire, sum(b.cantitate) numar, b.produs_id
                        from produse_comenzi b, produse c
                        where b.produs_id=c.produs_id
                        and c.categorie_id=categorie.categorie_id
                        group by b.produs_id
                        order by sum(b.cantitate) desc
                      ) loop
                      
            --afisez doar primele 10 cele mai importante
            if nr_linii<=10 then
                    --ca sa evit eroarea no data found numar mai intai cate produse de acest tip a comandat user-ul conectat
                    if user_conectat_id!=null then
                        select count(*)
                        into cantitate_user_conectat
                        from comenzi a, produse_comenzi b
                        where a.comanda_id=b.comanda_id
                        and b.produs_id=produs.produs_id
                        and a.user_id=user_conectat_id;
                        
                        if cantitate_user_conectat>0 then
                            select sum(b.cantitate)
                            into cantitate_user_conectat
                            from comenzi a, produse_comenzi b
                            where a.comanda_id=b.comanda_id
                            and b.produs_id=produs.produs_id
                            and a.user_id=user_conectat_id
                            group by a.user_id;
                            
                            --daca a comandat produse de acest tip dar mai putin decat media, afisam
                            if cantitate_user_conectat < proiect.bucati(produs.produs_id).fst/proiect.bucati(produs.produs_id).snd then
                                dbms_output.put_line(rpad(' ', categorie.level*5, ' ') || nr_linii||'. Produsul: ' || produs.denumire|| ' numar cumparate: ' || produs.numar);
                                nr_linii:=nr_linii+1;
                            end if;
                            
                        else
                            --daca nu a comandat deloc produse de acelasi tip afisez
                            dbms_output.put_line(rpad(' ', (categorie.level+1)*5, ' ') || nr_linii||'. Produsul: ' || produs.denumire|| ' numar cumparate: ' || produs.numar);
                            nr_linii:=nr_linii+1;
                        end if;
                    else 
                        dbms_output.put_line(rpad(' ', (categorie.level+1)*5, ' ') || nr_linii||'. Produsul: ' || produs.denumire|| ' numar cumparate: ' || produs.numar);
                    end if;
            end if;
        end loop;
    end loop;
end;
--------
Testare
--------
begin
initializare_bucati();
proiect.exercitiul_7(1);
end;
/


-------------------------------------------------------------------------------
8. FUNCTIE
-------------------------------------------------------------------------------
create or replace function gasire_produs (produs_cautat varchar2) return proiect.indexed_by_table_of_componente
as
produs number;
lista proiect.indexed_by_table_of_componente;
begin
    produs:=get_produs_id(produs_cautat);
    
    --nu avem cum sa avem exceptii fiinda avem bulk collect into
    select b.componenta_id, a.denumire_produs, c.raft_id, d.raion_id, e.zona_id
    bulk collect into lista
    from produse a, componente_produse b, rafturi c, raioane d, zone e
    where b.produs_final_id=produs
    and a.produs_id=b.componenta_id
    and a.raft_id=c.raft_id
    and c.raion_id=d.raion_id
    and d.zona_id=e.zona_id;
    
--daca produsul nu e compus il cautam doar pe el
    if lista.count=0 then
        select produs_id, denumire_produs, b.numar, c.numar, d.numar
        bulk collect into lista
        from produse a, rafturi b, raioane c, zone d
        where a.raft_id=b.raft_id
        and b.raion_id=c.raion_id
        and c.zona_id=d.zona_id
        and a.produs_id=produs;
    end if;
    return lista;
end;
/

--unde functia get_produs_id este:
create or replace function get_produs_id(produs_cautat varchar2) return number
as
produs number;
begin
    select produs_id
    into produs
    from produse
    where denumire_produs=produs_cautat;
    
    return produs;
    exception
        when no_data_found then
            raise_application_error(-20001, 'Nu exista niciun produs cu aceasta denumire in magazin!');
        when too_many_rows then
            raise_application_error(-20002, 'Exista mai multe produse cu aceasta denumire in magazin!');
        when others then
            raise_application_error(-20003, 'Alta eroare! Codul erorii: ' || SQLCODE || ', mesajul erorii: ' || SQLERRM);
end;
/

-------
Testare
-------
declare
lista proiect.indexed_by_table_of_componente;
begin
    lista:=proiect.exercitiul_8('Produs 101');
    dbms_output.put_line('Trebuie sa cautati ' || lista.count || ' produse:');
    for i in nvl(lista.first,0)..nvl(lista.last, -1) loop
        dbms_output.put_line('- produsul cu id ' || lista(i).id_produs || ' si denumirea '|| lista(i).denumire_produs
	|| ' la raftul ' || lista(i).raft_id || ' de la raionul ' || lista(i).raion_id || ' din zona ' || lista(i).zona_id);
    end loop;
end;
/
declare
lista proiect.indexed_by_table_of_componente;
begin
    lista:=proiect.exercitiul_8('Produs -10');
    dbms_output.put_line('Trebuie sa cautati ' || lista.count || ' produse:');
    for i in nvl(lista.first,0)..nvl(lista.last, -1) loop
        dbms_output.put_line('- produsul cu id ' || lista(i).id_produs || ' si denumirea '|| lista(i).denumire_produs
	|| ' la raftul ' || lista(i).raft_id || ' de la raionul ' || lista(i).raion_id || ' din zona ' || lista(i).zona_id);
    end loop;
end;
/

----------------------------------------------------------------------------------
PROCEDURA
----------------------------------------------------------------------------------
create or replace procedure exercitiul_9 (prod nested_table1, id_user useri_magazin_online.user_id%type, id_voucher number)
as
id_comanda number;
pret_facturare number;
type v_array is varray(100) of number;
valori v_array;
valoare number;
stoc_produs number;
nr number;
stoc_initial number;
stoc_final number;
begin
    id_comanda:=seq7.nextval;

--se adauga comanda
    insert into comenzi
    values(id_comanda, 0, sysdate, null, id_user, id_voucher, null);
    dbms_output.put_line('S-a adaugat comanda cu id-ul '|| id_comanda); 
    for i in prod.first..prod.last loop
--pentru feicare produs_cerut
        select pret_unitar, stoc_curent
        into pret_facturare, stoc_produs
        from produse
        where produs_id=prod(i).produs_id;

        if stoc_produs>=prod(i).numar_produse then

            select a.valoare
            bulk collect into valori
            from discounturi a, discounturi_produse b
            where a.discount_id=b.discount_id
            and b.produs_id=prod(i).produs_id
            and data_inceput<=sysdate
            and sysdate>=data_final
            order by data_inceput;

            --se aplica discount-urile pe produs
            for valoare in 1..valori.count loop
                pret_facturare:=(100-valoare)*pret_facturare/100;
            end loop;

            --se cauta un discount in data comenzii pe categoria produsului
            select count(*)
            into nr
            from discounturi_categorii a, discounturi b
            where a.discount_id=b.discount_id
            and b.data_inceput<=sysdate
            and b.data_final>=sysdate
            and a.categorie_id=(select categorie_id
                                from produse
                                where produs_id=prod(i).produs_id);
            if nr>0 then                     
                select b.valoare
                into valoare
                from discounturi_categorii a, discounturi b
                where a.discount_id=b.discount_id
                and b.data_inceput<=sysdate
                and b.data_final>=sysdate
                and a.categorie_id=(select categorie_id
                                    from produse
                                    where produs_id=prod(i).produs_id);

                pret_facturare:=(100-valoare)*pret_facturare/100;

            end if;
            insert into produse_comenzi(produs_id, comanda_id, cantitate, pret_facturare)
            values(prod(i).produs_id, id_comanda, prod(i).numar_produse, pret_facturare);
            dbms_output.put_line('S-au comandat '|| prod(i).numar_produse || ' produse cu id-ul '|| prod(i).produs_id);

            select stoc_curent
            into stoc_initial
            from produse
            where produs_id=prod(i).produs_id;

            update produse
            set stoc_curent=stoc_curent-prod(i).numar_produse
            where produs_id=prod(i).produs_id;
            
            stoc_final:=stoc_initial-prod(i).numar_produse;
            
            update produse
            set stoc_curent=floor(stoc_final/(select numar_necesar
                                        from componente_produse
                                        where produs_final_id=produs_id
                                        and componenta_id=prod(i).produs_id))
            where produs_id in (select produs_final_id
                                from componente_produse
                                where produs_final_id=produs_id
                                and componenta_id=prod(i).produs_id);

            stoc_final:=stoc_initial-prod(i).numar_produse;
            dbms_output.put_line('Stoc initial: ' || stoc_initial || ', stoc final : ' || stoc_final);

        else
            dbms_output.put_line('Nu se pot achizitiona '||prod(i).numar_produse || ' exemplare din produsul cu id '|| prod(i).produs_id || ', doar '|| stoc_produs || 'sunt disponibile');
        end if;
    end loop;
    exception
        when no_data_found then
            raise_application_error(-20004, 'Nu exiata produse cu codul dat!');
        when too_many_rows then
            raise_application_error(-20005, 'Nu exiata produse cu codul dat!');
        when others then
            raise_application_error(-20006, 'Alta eroare! Codul erorii: ' || SQLCODE || ', mesajul erorii: ' || SQLERRM);
end;

--------
Testare
--------
declare
prod nested_table1:=nested_table1();
begin
    prod.extend;
    prod(1):=info_prod(61,3);
    exercitiul_9(prod, 3, null);
end;
/

declare
prod nested_table1:=nested_table1();
begin
    prod.extend;
    prod(1):=info_prod(-61,3);
    exercitiul_9(prod, 3, null);
end;
/


-----------------------------------------------------------------------------------
TRIGGER LMD LA NIVEL DE COMANDA
-----------------------------------------------------------------------------------
create or replace trigger inventariere
before insert or update or delete on comenzi
begin
    if to_char(sysdate,'dd/mm') = '31/01' or 
       to_char(sysdate,'dd/mm') = '28/02' or 
       to_char(sysdate,'dd/mm') = '31/03' or
       to_char(sysdate,'dd/mm') = '30/04' or
       to_char(sysdate,'dd/mm') = '31/05' or
       to_char(sysdate,'dd/mm') = '30/06' or
       to_char(sysdate,'dd/mm') = '31/07' or
       to_char(sysdate,'dd/mm') = '31/08' or
       to_char(sysdate,'dd/mm') = '30/09' or
       to_char(sysdate,'dd/mm') = '31/10' or
       to_char(sysdate,'dd/mm') = '30/11' or
       to_char(sysdate,'dd/mm') = '31/12'
       and (to_char(sysdate,'hh24') between 2 and 4)
    then
        raise_application_error(-20007,'Magazinul se afla in proces de inventariere, va rugam plasati comanda dupa ora 04:00.');
    end if;
end;

-------
Testare
-------

insert into comenzi
values(182, 0, sysdate, null, 7, null, null);

-----------------------------------------------------------------------------------
TRIGGER LMD LA NIVEL DE LINIE
-----------------------------------------------------------------------------------
create or replace trigger exercitiul_11 
before
insert or update on discounturi_categorii for each row
declare
nr number;
data_start date;
data_finish date;
begin
    select data_inceput, data_final
    into data_start, data_finish
    from discounturi
    where discount_id=:new.discount_id;
    
    select count(*)
    into nr
    from discounturi_categorii a, discounturi b
    where a.discount_id=b.discount_id
    and a.categorie_id=:new.categorie_id
    and data_start<=b.data_final
    and data_finish>=b.data_inceput;
    
    if nr>0 then
        raise_application_error(-20008, 'Exista deja un discount pe aceasta categorie in intervalul de timp al discount-ului');
    end if;
end;
/

-------
Testare
-------
--functioneaza
insert into discounturi_categorii
values(2,17);
--nu functioneaza
insert into discounturi_categorii
values(85,17);


----------------------------------------------------------------------------------
12. TRIGGER DE TIP LDD
----------------------------------------------------------------------------------
create or replace trigger exercitiul_12
before create or drop or alter on database
begin
if TO_CHAR(SYSDATE,'D') = 1 or TO_CHAR(SYSDATE,'D') = 7 or (TO_CHAR(SYSDATE,'HH24') NOT BETWEEN 8 AND 20)
then
raise_application_error(-20009,'Operatiile asupra bazei de date sunt permise doar in programul de lucru!');
end if;
end;
/

--------
Testare
--------

create table test
(test number);

----------------------------------------------------------------------------------
13. PACHET
----------------------------------------------------------------------------------
create or replace package proiect
is
    type nested_table_comenzi is table of number;
    type nested_table_number is table of number;

--variabile
    contor_mentori number;

    type info_angajat is record (angajat_id number, job_id number);
    type indexed_by_table_of_info_angajat is table of info_angajat index by pls_integer;
    intrari indexed_by_table_of_info_angajat;
    nr_intrari number;
    
--exercitiul 6
    type indexed_by_table_of_number is table of number index by pls_integer;
    type info_mentor is record (id_angajat number, suma number, nume varchar2(200), prenume varchar2(200));
    type indexed_by_table_of_info_mentor is table of info_mentor index by pls_integer;
    mentori indexed_by_table_of_number;
    procedure afisare_mentori;
    function exercitiul_6 return number;
    
--exercitiul 8
    type info_componente is record (id_produs number, denumire_produs varchar2(200), raft_id number, raion_id number, zona_id number);
    type indexed_by_table_of_componente is table of info_componente index by pls_integer;
    function exercitiul_8 (produs_cautat varchar2) return proiect.indexed_by_table_of_componente;
    function get_produs_id(produs_cautat varchar2) return number;
    
--exercitiul 7
    --media numarului de bucati cumparate dintr-un anumit produs
    type number_number is record (fst number, snd number);
    type indexed_by_table_of_number_number is table of number_number index by pls_integer;
    bucati indexed_by_table_of_number_number;
    procedure exercitiul_7 (user_conectat_id number default null);


--exercitiul 9
    procedure exercitiul_9 (prod nested_table1, id_user useri_magazin_online.user_id%type, id_voucher number);

end proiect;

------------------------------------------------------------------------------------
14. PACHET COMPLEX
------------------------------------------------------------------------------------
create or replace package pachet_complex 
is
--recomandarile_userilor
    type info_produs is record (id_produs number, denumire_produs varchar2(200), pret number);
    type nested_table is table of info_produs;
    type info_produs_produse is record (id_produs number, lista_produse nested_table);
    type nested_table_of_nested_table is table of info_produs_produse;
    function recomandarile_userilor return nested_table_of_nested_table;
    
--initializare bucati
    procedure initializare_bucati;
end;

create or replace package body pachet_complex as

function recomandarile_userilor return nested_table_of_nested_table
is
comenzile_in_care_apare_X nested_table_of_number;
comenzile_in_care_apare_Y nested_table_of_number;
intersectie nested_table_of_number;
recomandari_pentru_X nested_table:= nested_table();
tabel_final nested_table_of_nested_table:=nested_table_of_nested_table();
nr number;
valoare number;
begin
    for X in (select produs_id
              from produse
              order by produs_id) loop 

        --bulk collect into nu va ridica exceptia no data found
        --si nici too many rows 
        select comanda_id
        bulk collect into comenzile_in_care_apare_X
        from produse_comenzi
        where produs_id=X.produs_id;

        for Y in (select produs_id, denumire_produs, pret_unitar
                  from produse
                  where produs_id>X.produs_id
                  order by produs_id) loop
            if recomandari_pentru_X.count<20 then
                select comanda_id
                bulk collect into comenzile_in_care_apare_Y
                from produse_comenzi
                where produs_id=Y.produs_id; 

                --intersectam cele 2 nested tables
                intersectie:=comenzile_in_care_apare_x multiset intersect comenzile_in_care_apare_y; 

                --daca mai mult de 3/4 din cumenzile care il contin pe Y il contin si pe X
                if intersectie.count>(comenzile_in_care_apare_Y.count)*1/2 then
                    --dbms_output.put_line('se intra aici');
                    for i in (  select a.valoare
                                from discounturi a, discounturi_produse b
                                where a.discount_id=b.discount_id
                                and a.data_inceput<=sysdate
                                and a.data_final>=sysdate
                                and b.produs_id=Y.produs_id
                                order by a.data_inceput) loop
                        Y.pret_unitar:=Y.pret_unitar * (100-i.valoare)/100;
                    end loop;


                    select count(*)
                    into nr
                    from discounturi a, discounturi_categorii b, produse_categorii c
                    where a.discount_id= b.discount_id
                    and b.categorie_id=c.categorie_id
                    and produs_id=Y.produs_id
                    and a.data_inceput<=sysdate
                    and a.data_final>=sysdate
                    order by a.data_inceput;

                    if nr>0 then
                        select a.valoare
                        into valoare
                        from discounturi a, discounturi_categorii b, produse_categorii c
                        where a.discount_id= b.discount_id
                        and b.categorie_id=c.categorie_id
                        and produs_id=Y.produs_id
                        and a.data_inceput<=sysdate
                        and a.data_final>=sysdate
                        order by a.data_inceput;

                        Y.pret_unitar:=Y.pret_unitar * (100-valoare)/100;
                    end if;

                    recomandari_pentru_X.extend;
                    recomandari_pentru_X(recomandari_pentru_X.count):=info_produs(Y.produs_id, Y.denumire_produs, Y.pret_unitar);
                end if;
            end if;
        end loop;

        tabel_final.extend;
        tabel_final(tabel_final.count):=info_produs_produse(X.produs_id, recomandari_pentru_X);
        recomandari_pentru_x.delete;
    end loop;
    return tabel_final;
end recomandarile_userilor;

procedure initializare_bucati 
as
comenzi_de_la_acelasi_user_pe_acelasi_produs number;
begin
    for i in (select * from produse) loop
        proiect.bucati(i.produs_id).fst:=0;
        proiect.bucati(i.produs_id).snd:=0;
    end loop;

    for i in (select * from produse_comenzi) loop
        select decode((select count(*)
                        from produse_comenzi c, comenzi d
                        where c.comanda_id=d.comanda_id
                        and c.produs_id=i.produs_id
                        and d.user_id=b.user_id), 0, 1, 0) comenzi_de_la_acelasi_user_pe_acelasi_produs
        into comenzi_de_la_acelasi_user_pe_acelasi_produs
        from produse_comenzi a, comenzi b
        where a.comanda_id=b.comanda_id
        and a.comanda_id=i.comanda_id
        and a.produs_id=i.produs_id;
        
        dbms_output.put_line('Numar useri inainte: ' || proiect.bucati(i.produs_id).snd);
        proiect.bucati(i.produs_id).snd:=proiect.bucati(i.produs_id).snd+comenzi_de_la_acelasi_user_pe_acelasi_produs+1;
        proiect.bucati(i.produs_id).fst:=proiect.bucati(i.produs_id).fst+i.cantitate;
        dbms_output.put_line('Dupa: ' || proiect.bucati(i.produs_id).snd);
        dbms_output.put_line(comenzi_de_la_acelasi_user_pe_acelasi_produs);
    end loop;

end initializare_bucati;

end;

--------------------------------------------------------
TRIGGER LA NIVEL DE BAZA DE DATE PENTRU RETINERE MENTORI
--------------------------------------------------------
create or replace trigger on_logon
after logon on schema
declare
begin
--retin valoarea contorului
    select mentor
    into proiect.contor_mentori
    from retinere_mentori
    where pozitie=0;
--si lista de mentori
    select mentor
    bulk collect into proiect.mentori
    from retinere_mentori
    where pozitie>0; 
end;

create or replace trigger on_logoff
before logoff on database
declare
nr_mentori number;
nr_linii number;
begin
    select count(*)
    into nr_linii
    from retinere_mentori;
    
    nr_mentori:=proiect.mentori.count;
    
    if nr_linii-1>=0 then
            update retinere_mentori
            set mentor=proiect.contor_mentori
            where pozitie=0;
        else
            insert into retinere_mentori
            values (0, nr_mentori);
        end if;
    dbms_output.put_line(proiect.mentori.first || ' ' || proiect.mentori.last);
    for i in nvl(proiect.mentori.first,0)..nvl(proiect.mentori.last,-1) loop
        if nr_linii-1>=i then
            update retinere_mentori
            set mentor=proiect.mentori(i)
            where pozitie=i;
        else
            insert into retinere_mentori
            values (i, proiect.mentori(i));
        end if;
    end loop;
    delete from retinere_mentori
    where pozitie>nr_mentori;
    
    dbms_output.put_line('s-a rulat on_logoff');
end;

--------------------------------
TRIGGER CARE SA STEARGA MENTORII
--------------------------------
create or replace trigger update_mentori_cand_se_sterge_un_mentor
after delete on angajati
for each row
begin
    for i in nvl(proiect.mentori.first, 0)..nvl(proiect.mentori.last, -1) loop
        if proiect.mentori(i)=:old.angajat_id then
            for j in i..proiect.mentori.last-1 loop
                proiect.mentori(j):=proiect.mentori(j+1);
            end loop;
            proiect.mentori.delete(proiect.mentori.last);
        end if;
    end loop;

end;

---------------
COMPUND TRIGGER
---------------
create or replace trigger exercitiul_10_compound
for delete on angajati
compound trigger
    
    type info_angajat is record (angajat_id number, job_id number);
    type indexed_by_table_of_info_angajat is table of info_angajat index by pls_integer;
    nr_intrari number:=0;
    intrari indexed_by_table_of_info_angajat;
    nr_comenzi_neanulate number;
    nr_sales_associative number;
    max_nr_achizitii_pe_zi number;
    nr_casieri number;
    nr_customer_service_representative number;
    nr_visual_merchandiser number;
    nr_inventory_control_specialist number;
    nr_retail_security_officer number;
    max_nr_transporturi_pe_zi number;
    nr_indrumatori number;
    nr_soferi number;
    nr_zone number;

    before statement is
    begin
        null;
    end before statement;

    before each row is
    begin
        null;
    end before each row;

    after each row is
    begin
        nr_intrari:=nr_intrari+1;
        intrari(nr_intrari):=info_angajat(:old.angajat_id, :old.job_id);
    end after each row;

    after statement is
    begin
        --pentru id:1
            --toate cererile sunt cu max si count deci nu am erori
            select count(comanda_id)
            into nr_comenzi_neanulate
            from comenzi
            where status_comanda!=3;

            select count(*)
            into nr_sales_associative
            from angajati
            where job_id=1;

        --pentru id:2 si 8
            select max(nr)
            into max_nr_achizitii_pe_zi
            from (select count(*) nr, data_achizitiei
                from achizitii_in_magazin
                where data_achizitiei>=add_months(sysdate, -6)
                group by data_achizitiei);

            select count(*)
            into nr_casieri
            from angajati
            where job_id=2;

        --pentru id:3
            select count(*)
            into nr_customer_service_representative
            from angajati
            where job_id=3;

        --pentru id:4
            select count(*)
            into nr_visual_merchandiser
            from angajati
            where job_id=4;

        --pentru id:5    
            select count(*)
            into nr_inventory_control_specialist
            from angajati
            where job_id=5;

            select count(*)
            into nr_zone
            from zone;

        --pentru id:6
            select count(*)
            into nr_retail_security_officer
            from angajati
            where job_id=6;

        --pentr id:7
            select max(nvl(count(*),0))
            into max_nr_transporturi_pe_zi
            from transporturi a, comenzi b
            where a.transport_id=b.transport_id
            group by data_livrarii;

        --pentru id:8
            select count(*)
            into nr_indrumatori
            from angajati
            where job_id=8;

            for i in 1..nr_intrari loop
                if intrari(i).job_id=1 then
                    if nr_comenzi_neanulate>100*(nr_sales_associative) then
                        raise_application_error(-20004, 'Nu vor ramane destui Sales Associatives!');
                    else
                        nr_sales_associative:=nr_sales_associative-1;
                    end if;
                elsif intrari(i).job_id=2 then
                    if max_nr_achizitii_pe_zi>10*(nr_casieri) then
                        raise_application_error(-20005, 'Nu vor ramane destui casieri!');
                    else
                        nr_casieri:=nr_casieri-1;
                    end if;
                elsif intrari(i).job_id=3 then
                    if nr_customer_service_representative*10<(nr_indrumatori) then
                        raise_application_error(-20006, 'Nu vor ramane destui Customer Service Representatives!');
                    else
                        nr_indrumatori:=nr_indrumatori-1;
                    end if;
                elsif intrari(i).job_id=4 then
                    if (nr_visual_merchandiser-1)<1 then
                        raise_application_error(-20007, 'Nu vor ramane destui Visual Merchandisers!');
                    else
                        nr_visual_merchandiser:=nr_visual_merchandiser-1;
                    end if;
                elsif intrari(i).job_id=5 then
                    if (nr_inventory_control_specialist)<1 then
                        dbms_output.put_line('Nr inventory control specialists ' || nr_inventory_control_specialist);
                        raise_application_error(-20008, 'Nu vor ramane destui Inventory Control Specialists!');
                    else
                        dbms_output.put_line('Inainte: '|| nr_inventory_control_specialist);
                        nr_inventory_control_specialist:=nr_inventory_control_specialist-1;
                        dbms_output.put_line('Dupa: '|| nr_inventory_control_specialist);
                    end if;
                elsif intrari(i).job_id=6 then
                    if (nr_retail_security_officer)*2<nr_zone then
                        raise_application_error(-20009, 'Nu vor ramane destui Retail Security Officers!');
                    else
                        nr_retail_security_officer:=nr_retail_security_officer-1;
                    end if;
                elsif intrari(i).job_id=7 then
                    if max_nr_transporturi_pe_zi>(nr_soferi)*2 then
                        raise_application_error(-20010, 'Nu vor ramane destui Soferi!');
                    else
                        nr_soferi:=nr_soferi-1;
                    end if;
                elsif intrari(i).job_id=8 then
                    if max_nr_achizitii_pe_zi>(nr_indrumatori)*4 then
                        raise_application_error(-20011, 'Nu vor ramane destui Indrumatori!');
                    else
                        nr_indrumatori:=nr_indrumatori-1;
                    end if;
                end if;
            end loop;
    end after statement;

end exercitiul_10_compound;



