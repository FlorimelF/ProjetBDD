-- Enola-ROUDAUT   Florimel-FLOTTE   Salomé-REBOURS
-- Le script de peuplement doit être lancé après le script de création des contraintes

------------------------------------------------------------------------------------ ORDRE DES PROCEDURES DE PEUPLEMENT

-- 1.   TypePlaque          Table de Dimension      Ok
-- 2.   LotPlaque           Table de relation
-- 3.   Plaque              Table de relation
-- 4.   Photometre          Table de Dimension      OK
-- 5.   Photo               Table de relation
-- 6.   Reactif             Table de Dimension      OK
-- 7.   TypeReleve          Table de relation       OK
-- 8.   Resultat            Table de Dimension
-- 9.   Experience          Table de relation
-- 10.  Facture             Table de Dimension      OK
-- 11.  Est_attache         Table de relation
-- 12.  Solution            Table de Dimension
-- 13.  Groupe              Table de relation
-- 14.  Slot                Table de relation
-- 15.  TableResultat       Table de relation

----------------------------------------------------------------------------------------------------------------------
------------------------------------------ CREATION DE TABLES D'ECHANTILLONS -----------------------------------------
----------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------- ECH_VENDEURS

-- Déclaration table ECH_VENDEURS
drop table Ech_Vendeurs;
create table Ech_Vendeurs (
  IDVENDEUR            NUMBER                not null,
  VENDEUR              VARCHAR(255)          not null,
  constraint PK_VENDEUR primary key (IDVENDEUR)
);

-- Trigger Id table ECH_VENDEURS
drop sequence S_IdVendeur;
create sequence S_IdVendeur start with 1 increment by 1;
create or replace trigger T_IdVendeur before insert on Ech_Vendeurs for each row
begin
  select S_IdVendeur.nextval into :new.IdVendeur from dual;
end;
/

-- Peuplement de la table ECH_VENDEURS
create or replace procedure P_Vendeur(n in number) deterministic as
  Vendeur varchar(255);
begin
  commit;
  for i in 1..n loop
    select
      'Vendeur '||i -- ('Vendeur 1', 'Vendeur 2' ... 'Vendeur n')
    into Vendeur from dual;
    insert into Ech_Vendeurs values(
      null, -- IdVendeur
      Vendeur
    );
  end loop;
end;
/
call P_Vendeur(20);
commit;

------------------------------------------------------------------------------------------------------ ECH_MAGASINIERS

-- Déclaration table ECH_MAGASINIERS
drop table Ech_Magasiniers;
create table Ech_Magasiniers (
  IDMAGASINIER         NUMBER                not null,
  MAGASINIER           VARCHAR(255)          not null,
  constraint PK_MAGASINIER primary key (IDMAGASINIER)
);

-- Trigger Id table ECH_MAGASINIERS
drop sequence S_IdMagasinier;
create sequence S_IdMagasinier start with 1 increment by 1;
create or replace trigger T_IdMagasinier before insert on Ech_Magasiniers for each row
begin
  select S_IdMagasinier.nextval into :new.IdMagasinier from dual;
end;
/

-- Peuplement de la table ECH_MAGASINIERS
create or replace procedure P_Magasinier(n in number) deterministic as
  Magasinier varchar(255);
begin
  commit;
  for i in 1..n loop
    select
      'Magasinier '||i -- ('Magasinier 1', 'Magasinier 2' ... 'Magasinier n')
    into Magasinier from dual;
    insert into Ech_Magasiniers values(
      null, -- IdMagasinier
      Magasinier
    );
  end loop;
end;
/
call P_Magasinier(20);
commit;

------------------------------------------------------------------------------------------------------ ECH_FABRIQUANTS

-- Déclaration table ECH_FABRIQUANTS
drop table Ech_Fabriquants;
create table Ech_Fabriquants (
  IDFABRIQUANT         NUMBER                not null,
  FABRIQUANT           VARCHAR(255)          not null,
  constraint PK_FABRIQUANT primary key (IDFABRIQUANT)
);

-- Trigger Id table ECH_FABRIQUANTS
drop sequence S_IdFabriquant;
create sequence S_IdFabriquant start with 1 increment by 1;
create or replace trigger T_IdFabriquant before insert on Ech_Fabriquants for each row
begin
  select S_IdFabriquant.nextval into :new.IdFabriquant from dual;
end;
/

-- Peuplement de la table ECH_FABRIQUANTS
create or replace procedure P_Fabriquant(n in number) deterministic as
  Fabriquant varchar(255);
begin
  commit;
  for i in 1..n loop
    select
      'Fabriquant '||i -- ('Fabriquant 1', 'Fabriquant 2' ... 'Fabriquant n')
    into Fabriquant from dual;
    insert into Ech_Fabriquants values(
      null, -- IdFabriquant
      Fabriquant
    );
  end loop;
end;
/
call P_Fabriquant(20);
commit;

----------------------------------------------------------------------------------------------------- ECH_NOM_REACTIFS

-- Déclaration table ECH_REACTIF
drop table Ech_Nom_Reactifs;
create table Ech_Nom_Reactifs (
  IDNOMREACTIF         NUMBER                not null,
  NOMREACTIF              VARCHAR(255)          not null,
  constraint PK_NOMREACTIF primary key (IDNOMREACTIF)
);

-- Trigger Id table ECH_REACTIF
drop sequence S_IdNomReactif;
create sequence S_IdNomReactif start with 1 increment by 1;
create or replace trigger T_IdNomReactif before insert on Ech_Nom_Reactifs for each row
begin
  select S_IdNomReactif.nextval into :new.IdNomReactif from dual;
end;
/

-- Peuplement de la table ECH_REACTIF
create or replace procedure P_Nom_Reactif(n in number) deterministic as
  NomReactif varchar(255);
begin
  commit;
  for i in 1..n loop
    select
      'Réactif '||i -- ('Réactif 1', 'Réactif 2' ... 'Réactif n')
    into NomReactif from dual;
    insert into Ech_Nom_Reactifs values(
      null, -- IdNomReactif
      NomReactif
    );
  end loop;
end;
/
call P_Nom_Reactif(20);
commit;

----------------------------------------------------------------------------------------------------------------------
------------------------------------------------ PEUPLEMENT DES TABLES -----------------------------------------------
----------------------------------------------------------------------------------------------------------------------

----------------------------------------------------------------------------------------------------------- TYPEPLAQUE

-- IdPLaque = 1 -> Plaques 96 = 8*12 slots
insert into TypePlaque values(null,round(DBMS_RANDOM.value(10000,30000)));
-- IdPLaque = 2 -> Plaques 384 = 16*24 slots
insert into TypePlaque values(null,round(DBMS_RANDOM.value(10000,30000)));
commit;

select * from TypePlaque;

------------------------------------------------------------------------------------------------------------ LOTPLAQUE

--------------------------------------------------------------------------------------------------------------- PLAQUE

----------------------------------------------------------------------------------------------------------- PHOTOMETRE

create or replace procedure P_Photometre(n in number) deterministic as
  Dispo smallint;
  Cout number;
begin
  commit;
  for i in 1..n loop
    select
      round(DBMS_RANDOM.value(0,1)), -- Disponible (0 : Non / 1 : Oui)
      trunc(DBMS_RANDOM.value(3,15),2) -- CoutPhotometre (3,00€ - 15,00€)
    into Dispo, Cout from dual;
    insert into Photometre values(
      null, -- IdPhotometre
      Dispo, -- Disponible
      Cout -- CoutPhotometre
    );
  end loop;
end;
/
call P_Photometre(20);
commit;

select * from Photometre;

---------------------------------------------------------------------------------------------------------------- PHOTO

-------------------------------------------------------------------------------------------------------------- REACTIF

create or replace procedure P_Reactif(n in number) deterministic as
  Nombre number;
  Prix number;
  Nom varchar(255);
begin
  commit;
  for i in 1..n loop
    Nombre := 1;
    loop -- tant que le nom de réactif a déjà été tiré dans la table d'échantillons (ECH_NOM_REACTIFS)
      exit when Nombre = 0; -- Si pas déjà tiré
      select NomReactif into Nom from (select NomReactif from Ech_Nom_Reactifs order by dbms_random.random) where rownum = 1; -- Tirage
      select count(*) into Nombre from Reactif where NomReactif = Nom; -- Vérification si déjà tiré ou non
    end loop;
    select trunc(DBMS_RANDOM.value(1,50),2) into Prix from dual; -- (1,00€ - 50,00€)
    insert into Reactif values(
      null, -- IdReactif
      Prix, -- PrixReactif
      Nom -- NomReactif
    );
  end loop;
end;
/
call P_Reactif(20);
commit;

select * from Reactif;

----------------------------------------------------------------------------------------------------------- TYPERELEVE

create or replace procedure P_TypeReleve deterministic as
  Nombre number;
  NbReactifs number;
  VIdReactif number;
  VRandom number;
  Nom varchar(255);
begin
  commit;
  select count(*) into NbReactifs from Reactif;
  for i in 1..NbReactifs loop
    Nombre := 1;
    loop -- tant que l'id du réactif a déjà été tiré dans la table REACTIFS
      exit when Nombre = 0; -- Si pas déjà tiré
      select IdReactif into VIdReactif from (select IdReactif from Reactif order by dbms_random.random) where rownum = 1; -- Tirage
      select count(*) into Nombre from TypeReleve where IdReactif = VIdReactif; -- Vérification si déjà tiré ou non
    end loop;
    VRandom := round(DBMS_RANDOM.value(0,1)); -- Tirage du type de relevé
    if VRandom = 0 then 
      Nom := 'Colorimétrique';
    else 
      Nom := 'Opacimétrique';
    end if;
    insert into TypeReleve values(
      null, -- IdReleve
      VIdReactif, -- IdReactif
      Nom -- Nom_Releve
    );
  end loop;
end;
/
call P_TypeReleve; -- On insère autant de lignes qu'on a de réactifs
commit;

select * from TypeReleve;

------------------------------------------------------------------------------------------------------------- RESULTAT

----------------------------------------------------------------------------------------------------------- EXPERIENCE

-------------------------------------------------------------------------------------------------------------- FACTURE

create or replace procedure P_Facture(n in number) deterministic as
  DateFacture date;
  val number;
begin
  commit;
  for i in 1..n loop
    val := round(DBMS_RANDOM.value(0,12*5)); -- Génération d'une date (mois et année, jour toujours le 01) sur 5 ans (01/01/2019 - 01/01/2023)
    select ADD_MONTHS(to_date('01/01/2019','dd-mm-yyyy'), val) into DateFacture from dual;
    insert into Facture values(
      null, -- IdFacture
      DateFacture
    );
  end loop;
end;
/
call P_Facture(20);
commit;

select * from Facture;

---------------------------------------------------------------------------------------------------------- EST_ATTACHE

------------------------------------------------------------------------------------------------------------- SOLUTION

--------------------------------------------------------------------------------------------------------------- GROUPE

----------------------------------------------------------------------------------------------------------------- SLOT

-------------------------------------------------------------------------------------------------------- TABLERESULTAT

