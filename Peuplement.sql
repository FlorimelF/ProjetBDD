---------------------------------------------------------------- ORDRE DES PROCEDURES DE PEUPLEMENT

-- 1.   TypePlaque
-- 2.   LotPlaque
-- 3.   Plaque
-- 4.   Photometre
-- 5.   Photo
-- 6.   Reactif
-- 7.   TypeReleve
-- 8.   Resultat
-- 9.   Experience
-- 10.  Facture
-- 11.  Est_attache
-- 12.  Solution
-- 13.  Groupe
-- 14.  Slot
-- 15.  TableResultat

---------------------------------------------------------------------------------------- TYPEPLAQUE

----------------------------------------------------------------------------------------- LOTPLAQUE

-------------------------------------------------------------------------------------------- PLAQUE

---------------------------------------------------------------------------------------- PHOTOMETRE -- Ok

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

