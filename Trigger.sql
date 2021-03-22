create trigger VerificationDateExp before insert on EXPERIENCE for each row
begin
    if :new.DEBUTEXP > :new.FINEXP then
        raise_application_error(-2001, 'Les dates pour l experience ne sont pas dans le bon ordre');
end;