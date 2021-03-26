---------------------------------------------------------------- ORDRE DES PROCEDURES DE PEUPLEMENT

-- 1.   TypePlaque          Table de Dimension
-- 2.   LotPlaque           Table de relation
-- 3.   Plaque              Table de relation
-- 4.   Photometre          Table de Dimension
-- 5.   Photo               Table de relation
-- 6.   Reactif             Table de Dimension
-- 7.   TypeReleve          Table de relation
-- 8.   Resultat            Table de Dimension
-- 9.   Experience          Table de relation
-- 10.  Facture             Table de Dimension
-- 11.  Est_attache         Table de relation
-- 12.  Solution            Table de Dimension
-- 13.  Groupe              Table de relation
-- 14.  Slot                Table de relation
-- 15.  TableResultat       Table de relation

---------------------------------------------------------------------------------------------------
-------------------------------- CREATION DE TABLES D'ECHANTILLONS --------------------------------
---------------------------------------------------------------------------------------------------

-------------------------------------------------------------------------------------- ECH_VENDEURS

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
    for i in 1..n loop
      select
        'Vendeur '||i
      into
        Vendeur
      from dual;
      insert into Ech_Vendeurs values(
        null, -- IdVendeur
        Vendeur
      );
    end loop;
  end;
  /
  call P_Vendeur(20);
  commit;

-- Fin ECH_VENDEURS

----------------------------------------------------------------------------------- ECH_MAGASINIERS

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
    for i in 1..n loop
      select
        'Magasinier '||i
      into
        Magasinier
      from dual;
      insert into Ech_Magasiniers values(
        null, -- IdMagasinier
        Magasinier
      );
    end loop;
  end;
  /
  call P_Magasinier(20);
  commit;

-- Fin ECH_MAGASINIERS

----------------------------------------------------------------------------------- ECH_FABRIQUANTS

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
    for i in 1..n loop
      select
        'Fabriquant '||i
      into
        Fabriquant
      from dual;
      insert into Ech_Fabriquants values(
        null, -- IdFabriquant
        Fabriquant
      );
    end loop;
  end;
  /
  call P_Fabriquant(20);
  commit;

-- Fin ECH_FABRIQUANTS

---------------------------------------------------------------------------------------------------
-------------------------------------- PEUPLEMENT DES TABLES --------------------------------------
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------- TYPEPLAQUE

  insert into TypePlaque values(1,round(DBMS_RANDOM.value(0,1000)));
  insert into TypePlaque values(2,round(DBMS_RANDOM.value(0,1000)));
  commit;

-- Fin TYPEPLAQUE

----------------------------------------------------------------------------------------- LOTPLAQUE -- Pas fini

-- Trigger Id table LOTPLAQUE
drop sequence S_IdLotPlaque;
create sequence S_IdLotPlaque start with 1 increment by 1;
create or replace trigger T_IdLotPlaque before insert on LotPlaque for each row
begin
  select S_IdLotPlaque.nextval into :new.IdLotPlaque from dual;
end;
/

-- Peuplement de la table LOTPLAQUE
create or replace procedure P_LotPlaque(n in number) deterministic as
  DateLivraison date;
  Vendeur varchar(255);
  Magasinier varchar(255);
  Fabriquant varchar(255);
begin
  commit;
  for i in 1..n loop
    select
	    round(DBMS_RANDOM.value(0,1000)), -- Stock
    into
      Stock
    from dual;
    insert into TypePlaque values(
      null, -- IdTypePlaque
      Stock
    );
  end loop;
end;
/
call P_LotPlaque(20);
commit;

-------------------------------------------------------------------------------------------- PLAQUE

---------------------------------------------------------------------------------------- PHOTOMETRE

  -- Trigger Id table PHOTOMETRE
  drop sequence S_IdPhotometre;
  create sequence S_IdPhotometre start with 1 increment by 1;
  create or replace trigger T_IdPhotometre before insert on Photometre for each row
  begin
    select S_IdPhotometre.nextval into :new.IdPhotometre from dual;
  end;
  /

  -- Peuplement de la table PHOTOMETRE
  create or replace procedure P_Photometre(n in number) deterministic as
    Dispo smallint;
    Cout number;
  begin
    for i in 1..n loop
      select
        round(DBMS_RANDOM.value(0,1)), -- Disponible
        trunc(DBMS_RANDOM.value(3,15),2) -- CoutPhotometre
      into
        Dispo,
        Cout
      from dual;
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

-- Fin PHOTOMETRE

--------------------------------------------------------------------------------------------- PHOTO

------------------------------------------------------------------------------------------- REACTIF

---------------------------------------------------------------------------------------- TYPERELEVE

------------------------------------------------------------------------------------------ RESULTAT -- Pas fini

-- Trigger Id table TableResultat
drop sequence S_IdTableResultat;
create sequence S_IdTableResultat start with 1 increment by 1;
create or replace trigger T_IdTableResultat before insert on TableResultats for each row
begin
  select S_IdTableResultat.nextval into :new.IdTableResultat from dual;
end;
/

-- Peuplement de la table TableResultat
create or replace procedure P_TableResultat(n in number) deterministic as
  x number;
  y number;
  Rd number;
  Rm number;
  Vd number;
  Vm number;
  Td number;
  Tm number;
  Bd number;
  Bm number;
begin
  for i in 1..n loop
    select
	    -- Clés étrangères ??
      -- x
      -- y
      -- Rd
      DBMS_RANDOM.value(0,255) -- Rm
      -- Vd
      DBMS_RANDOM.value(0,255) -- Vm
      -- Td
      DBMS_RANDOM.value(0,255) -- Tm
      -- Bd
      DBMS_RANDOM.value(0,255) -- Bm
    into
      x, y, Rd, Rm, Vd, Vm, Td, Tm, Bd, Bm
    from dual;
    insert into Photometre values(
      null, -- IdTableResultat
      x, y, -- oordonnées pixel le plus proche du centre du slot
      Rd, Rm, Vd, Vm, Td, Tm, Bd, Bm -- Moyennes et ecarts-types des niveaux de RVB et transparence
    );
  end loop;
end;
/
call P_TableResultat(20);
commit;

---------------------------------------------------------------------------------------- EXPERIENCE

------------------------------------------------------------------------------------------- FACTURE

--------------------------------------------------------------------------------------- EST_ATTACHE

------------------------------------------------------------------------------------------ SOLUTION

-------------------------------------------------------------------------------------------- GROUPE

---------------------------------------------------------------------------------------------- SLOT

------------------------------------------------------------------------------------- TABLERESULTAT

