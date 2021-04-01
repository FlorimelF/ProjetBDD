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

