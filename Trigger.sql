/* Trigger 9 */
drop trigger VerificationDateExp;
create trigger VerificationDateExp before insert on EXPERIENCE for each row
begin
    if :new.DEBUTEXP > :new.FINEXP then
        raise_application_error(-2001, 'Les dates pour l experience ne sont pas dans le bon ordre');
    end if;
end;
/

/* Trigger 12 */
drop trigger VerificationDateDemande;
create trigger VerificationDateDemande before insert on EXPERIENCE for each row
begin
    if :new.DEBUTEXP < :new.DATECHERCHEUR then
        raise_application_error(-2001, 'Les dates ne sont pas dans le bon sens');
    end if;    
end;
/

commit;
