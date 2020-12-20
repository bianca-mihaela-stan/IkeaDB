--am aflat ca daca scriu doar number(8)
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