-- Enola-ROUDAUT   Florimel-FLOTTE   Salomé-REBOURS
-- Le script de peuplement doit être lancé après le script de création des contraintes

-------------------------------------------------------------------------------------------------------------- SOMMAIRE

------------------------------------------------------------------------ Contraintes

-- 1.   T_VerificationDateExp
-- 2.   T_VerificationDateDemande
-- 3.   T_VerificationNiveauAcceptation
-- 4.   T_IntégrationReactif
-- 5.   T_VerificationNomRelevé
-- 6.   T_VerificationDivisionEntiere

-------------------------------------------------------------------- Automatisations

-- 1.   AutoPlacementGroupe
-- 2.   AutoCalculCoeffSurcout    Fonctionne pas 

----------------------------------------------------------------------------------------------------------------------
----------------------------------------------------- CONTRAINTES ----------------------------------------------------
----------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------- T_VerificationDateExp
-- DébutExp <= FinExp

create or replace trigger T_VerificationDateExp before insert on EXPERIENCE for each row
begin
  if :new.DEBUTEXP > :new.FINEXP then
    raise_application_error(-20001, 'Les dates de début et de fin pour une expérience ne sont pas cohérentes');
  end if;
end;
/
commit;

--------------------------------------------------------------------------------------------- T_VerificationDateDemande
-- DateChercheur (Date de demande de l'expérience) <= DébutExp
  
create or replace trigger T_VerificationDateDemande before insert on EXPERIENCE for each row
begin
  if :new.DEBUTEXP < :new.DATECHERCHEUR then
    raise_application_error(-20002, 'Les dates de demande et de début pour une expérience ne sont pas cohérentes');
  end if;    
end;
/
commit;

--------------------------------------------------------------------------------------- T_VerificationNiveauAcceptation
-- Les niveaux d'acceptation a1 et a2 sont tels que a1 <= a2

create or replace trigger T_VerificationNiveauAcceptation before insert on EXPERIENCE for each row
begin
  if :new.a1 > :new.a2 then
    raise_application_error(-20003, 'Attention, a1 doit être < ou = de a2');
  end if;
end;
/
commit;

-------------------------------------------------------------------------------------------------- T_IntégrationReactif
-- Eviter les redondances de réactifs : 
-- Si le nom du réactif est déjà dans la BDD, il n'est pas à nouveau inséré
-- (ne pas tenir compte de la casse, ni des accents)

create or replace trigger T_IntégrationReactif after insert on REACTIF
declare
  nbReac integer:=0;
begin
  select count(*) into nbReac from (select count (*) from REACTIF group by upper(nomReactif) having count(*) > 1) maTable;
  if nbReac = 1 then
    raise_application_error(-20004, 'Ce réactif existe déjà');
  end if;
end;
/
commit;

----------------------------------------------------------------------------------------------- T_VérificationNomRelevé
-- Nom_Relevé doit contenir "Colorimétrique" ou "Opacimétrique" exclusivement

create or replace trigger T_VérificationNomRelevé before insert on TYPERELEVE for each row
declare
  nom1 VARCHAR(20):='Colorimétrique';
  nom2 VARCHAR(20):='Opacimétrique';
begin
  if upper(:new.Nom_releve) <> upper(nom1) and upper(:new.Nom_releve) <> upper(nom2) then
    raise_application_error(-20005, 'Le nom du releve doit contenir "Colorimétrique" ou "Opacimétrique" exclusivement');
  end if;
end;
/
commit;

----------------------------------------------------------------------------------------- T_VerificationDivisionEntiere
-- Durée et fObservation sont tels que d/f donne un résultat entier

create or replace trigger T_VerificationDivisionEntiere before insert on EXPERIENCE for each row
begin
  if :new.fObservation <> null then
    if mod(:new.Duree,:new.fObservation) <> 0 then
      raise_application_error(-20006, 'd/f ne donne pas un résultat entier');
    end if;
  end if;
end;
/
commit;

----------------------------------------------------------------------------------------------------------------------
--------------------------------------------------- AUTOMATISATIONS --------------------------------------------------
----------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------- AutoPlacementGroupe
-- Placement des n replicas d'un groupe sur des plaques
-- Un groupe doit être sur la même plaque
-- Tous les groupes d'une même plaque sont sous les mêmes conditions 
-- (opacimétrique/colorimétrique, suivis dans le temps/non suivis dans le temps)

create or replace trigger PlacementGroupe before insert on GROUPE for each row
declare
  nb NUMBER;
  NbSlotOcc NUMBER;
begin
  SELECT NBSLOTPOURGROUPE 
    INTO nb 
    FROM GROUPE 
    NATURAL JOIN EXPERIENCE
    WHERE IDEXPERIENCE = :new.IDEXPERIENCE;
  for i in (SELECT IDPLAQUE, IDTYPEPLAQUE FROM PLAQUE NATURAL JOIN LOTPLAQUE) loop
    SELECT SUM(NBSLOTPOURGROUPE) 
      INTO NbSlotOcc 
      FROM EXPERIENCE 
      NATURAL JOIN GROUPE 
      WHERE IDPLAQUE = i.IDPLAQUE;
    if i.IDTYPEPLAQUE = 0 then
      if NbSlotOcc <= 96 - nb then
        :new.IDPLAQUE := i.IDPLAQUE;
        EXIT;
      end if;
    else
      if NbSlotOcc <= 384 - nb then
        :new.IDPLAQUE := i.IDPLAQUE;
        EXIT;
      end if;
    end if;
  end loop;
end;
/

------------------------------------------------------------------------------------------------- AutoCalculCoeffSurcout
-- Un niveau de priorité supérieur à 1 a un impact sur le coût de l'expérience
-- Le prix total d'une expérience e est multiplié par le coefficient (n + d)/n
-- n le nombre total d'expériences non réalisées et arrivées avant e (e comprise)
-- d le nombre d'expériences doublées par e dans la file d'attente, du fait de sa priorité

-- Fonctionne pas 

-- VERSION 1 PRIORITAIRE 

create or replace trigger AutoCalculCoeffSurcout before UPDATE or INSERT on EXPERIENCE for each row
declare
  nbN number;
  nbE number;
begin
  for i in (SELECT * FROM EXPERIENCE WHERE IndicePriorite > 1) loop
    SELECT COUNT(*) +1 into nbN
      FROM EXPERIENCE
      WHERE (
        SELECT dateChercheur
        FROM EXPERIENCE
        JOIN RESULTAT USING (idResultat)
        WHERE indicePriorite>1 and AccepteResultat=0) < i.dateChercheur;
    SELECT COUNT(*) into nbE
      FROM EXPERIENCE
      WHERE (SELECT IndicePriorite FROM EXPERIENCE) < i.IndicePriorite;
    UPDATE EXPERIENCE SET coeffSurcout = (nbN+nbE)/nbN
      WHERE IdExperience=i.IdExperience;
  end loop;
end;
/

-- VERSION 2 (SI 1 FONCTIONNE PAS)

drop trigger AutoCalculCoeffSurcout;
create or replace trigger AutoCalculCoeffSurcout before UPDATE or INSERT on EXPERIENCE for each row
declare
  nbN NUMBER;
  nbE NUMBER;
begin
  if :new.IndicePriorite>1 then
    SELECT COUNT(*) +1 into nbN
    FROM EXPERIENCE
    WHERE (
      SELECT dateChercheur
      FROM EXPERIENCE
      JOIN RESULTAT USING (idResultat)
      WHERE indicePriorite>1 and AccepteResultat=0) < :new.dateChercheur;
    SELECT COUNT(*) into nbE
    FROM EXPERIENCE
    WHERE (SELECT IndicePriorite FROM EXPERIENCE) < :new.IndicePriorite;
    UPDATE EXPERIENCE SET coeffSurcout = (nbN+nbE)/nbN
    WHERE IdExperience=:new.IdExperience;
  end if;
end;
/