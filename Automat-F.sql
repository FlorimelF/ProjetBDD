/* Trigger Placement des n replicas d'un groupe sur des plaques. 
Un groupe doit être sur la même plaque. 
Tous les roupes d'une même plaque sont sous les mêmes conditions 
(opacimétrique/colorimétrique, suivis dans le temps/non suivis dans 
le temps) */
drop trigger PlacementGroupe;
create trigger PlacementGroupe before insert on GROUPE for each row
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


/*Un niveau de priorité supérieur à 1 a un impact sur le coût de l'expérience :
le prix total d'une expérience e est multiplié par le coefficient (n + d)/n,
où n est le nombre total d'expériences non réalisées et arrivées avant e (e comprise), et d est le nombre d'expériences
doublées par e dans la file d'attente, du fait de sa priorité. */

 /* VERSION 1 PRIORITAIRE*/
drop trigger AutoCalculCoeffSurcout;
create trigger AutoCalculCoeffSurcout before UPDATE or INSERT on EXPERIENCE for each row
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

/* VERSION 2 SI 1 FONCTIONNE PAS*/
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