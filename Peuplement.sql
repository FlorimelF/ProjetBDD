-- Séquence pour l'auto-incrémentation des Id
drop sequence S1;
create sequence S1 start with 1 increment by 1;

---------------------------------------------------------- PHOTOMETRE

-- Trigger Id table PHOTOMETRE
create or replace trigger T_IdPhotometre before insert on Photometre for each row
begin
  select S1.nextval into :new.idPhotometre from dual;
end;
/

-- Peuplement de la table PHOTOMETRE
drop procedure P_Photometre;
create procedure P_Photometre(n in number) deterministic as
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
	    null, -- idPhotometre
	    Dispo, -- Disponible
	    Cout -- CoutPhotometre
	);
  end loop;
end;
/

call P_Photometre(20);
select count(*) from Photometre;
select * from Photometre;

commit;

---------------------------------------------------------- RESULTATS

-- Trigger Id table PHOTOMETRE
create or replace trigger T_IdPhotometre before insert on Photometre for each row
begin
  select S1.nextval into :new.idPhotometre from dual;
end;
/

-- Peuplement de la table PHOTOMETRE
drop procedure P_Photometre;
create procedure P_Photometre(n in number) deterministic as
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
	    null, -- idPhotometre
	    Dispo, -- Disponible
	    Cout -- CoutPhotometre
	);
  end loop;
end;
/

call P_Photometre(20);
select count(*) from Photometre;
select * from Photometre;

commit;