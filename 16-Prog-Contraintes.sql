-- Enola-ROUDAUT
-- Florimel-FLOTTE
-- Salomé-REBOURS

/* Trigger 9 */
drop trigger T_VerificationDateExp;
create trigger T_VerificationDateExp before insert on EXPERIENCE for each row
begin
    if :new.DEBUTEXP > :new.FINEXP then
        raise_application_error(-2001, 'Les dates pour l experience ne sont pas dans le bon ordre');
    end if;
end;
/

/* Trigger 12 */
drop trigger T_VerificationDateDemande;
create trigger T_VerificationDateDemande before insert on EXPERIENCE for each row
begin
    if :new.DEBUTEXP < :new.DATECHERCHEUR then
        raise_application_error(-2001, 'Les dates ne sont pas dans le bon sens');
    end if;    
end;
/

commit;


/* Trigger 13 */
drop trigger T_VerificationNiveauAcceptation;
create trigger T_VerificationNiveauAcceptation before insert on EXPERIENCE for each row
begin
    if :new.a1 > :new.a2 then
        raise_application_error(-2001, 'Attention, a1 doit être < ou = de a2');
end if;
end;
/

commit;


/* Empêche les doublons de nom de réactif */
drop trigger T_IntégrationReactif;
create trigger T_IntégrationReactif after insert on REACTIF
declare
nbReac integer:=0;
begin
select count(*) into nbReac from
(select count (*) from REACTIF group by nomReactif having count(*) > 1) maTable;
if nbReac = 1 then
        raise_application_error(-2001, 'Ce nom de réactif existe déjà');
end if;
end;
/
commit;