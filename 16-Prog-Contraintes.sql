-- Enola-ROUDAUT
-- Florimel-FLOTTE
-- Salomé-REBOURS

------------------------------------------------------------------------------------------ SOMMAIRE

-- 1.   T_VerificationDateExp
-- 2.   T_VerificationDateDemande
-- 3.   T_VerificationNiveauAcceptation
-- 4.   T_IntégrationReactif

----------------------------------------------------------------------------- T_VerificationDateExp
-- DébutExp <= FinExp

create or replace trigger T_VerificationDateExp before insert on EXPERIENCE for each row
begin
  if :new.DEBUTEXP > :new.FINEXP then
    raise_application_error(-20001, 'Les dates de début et de fin pour une expérience ne sont pas cohérentes');
end if;
end;
/
commit;

------------------------------------------------------------------------- T_VerificationDateDemande
-- DateChercheur (Date de demande de l'expérience) <= DébutExp
  
create or replace trigger T_VerificationDateDemande before insert on EXPERIENCE for each row
begin
  if :new.DEBUTEXP < :new.DATECHERCHEUR then
    raise_application_error(-20001, 'Les dates de demande et de début pour une expérience ne sont pas cohérentes');
  end if;    
end;
/
commit;

------------------------------------------------------------------- T_VerificationNiveauAcceptation
-- Les niveaux d'acceptation a1 et a2 sont tels que a1 <= a2

create or replace trigger T_VerificationNiveauAcceptation before insert on EXPERIENCE for each row
begin
  if :new.a1 > :new.a2 then
    raise_application_error(-20001, 'Attention, a1 doit être < ou = de a2');
end if;
end;
/
commit;

------------------------------------------------------------------------------ T_IntégrationReactif
-- Eviter les redondances de réactifs : 
-- Si le nom du réactif est déjà dans la BDD, il n'est pas à nouveau inséré
-- (ne pas tenir compte de la casse, ni des accents)

create or replace trigger T_IntégrationReactif after insert on REACTIF
declare
  nbReac integer:=0;
begin
  select count(*) into nbReac from (select count (*) from REACTIF group by upper(nomReactif) having count(*) > 1) maTable;
  if nbReac = 1 then
    raise_application_error(-20001, 'Ce réactif existe déjà');
  end if;
end;
/
commit;

------------------------------------------------------------------------------ T_VérificationNomRelevé
-- Nom_Relevé doit contenir "Colorimétrique" ou "Opacimétrique" exclusivement

create or replace trigger T_VérificationNomRelevé before insert on TYPERELEVE for each row
declare
nom1 VARCHAR(20):='Colorimétrique';
nom2 VARCHAR(20):='Opacimétrique';
begin
if upper(:new.Nom_releve) <> upper(nom1) or upper(:new.Nom_releve) <> upper(nom2) then
    raise_application_error(-20001, 'Le nom du releve doit contenir "Colorimétrique" ou "Opacimétrique" exclusivement');
end if;
end;
/
commit;

------------------------------------------------------------------------------ T_IntégrationReactif
-- Eviter les redondances de réactifs : 
-- Si le nom du réactif est déjà dans la BDD, il n'est pas à nouveau inséré
-- (ne pas tenir compte de la casse, ni des accents)

create or replace trigger T_IntégrationReactif after insert on REACTIF
declare
  nbReac integer:=0;
begin
  select count() into nbReac from (select count () from REACTIF group by upper(nomReactif) having count(*) > 1) maTable;
  if nbReac = 1 then
    raise_application_error(-20001, 'Ce réactif existe déjà');
  end if;
end;
/
commit;

--------------------------------------------------------------------------- T_VérificationNomRelevé
-- Nom_Relevé doit contenir "Colorimétrique" ou "Opacimétrique" exclusivement

create or replace trigger T_VérificationNomRelevé before insert on TYPERELEVE for each row
declare
  nom1 VARCHAR(20):='Colorimétrique';
  nom2 VARCHAR(20):='Opacimétrique';
begin
  if upper(:new.Nom_releve) <> upper(nom1) or upper(:new.Nom_releve) <> upper(nom2) then
    raise_application_error(-20001, 'Le nom du releve doit contenir "Colorimétrique" ou "Opacimétrique" exclusivement');
  end if;
end;
/
commit;
