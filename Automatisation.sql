/* Automatisation pour l'indice de priorité*/
drop trigger AutoIndicePriorité;
create trigger AutoIndicePriorité before insert on EXPERIENCE for each row
begin

    for i in 1..(select count(*) from EXPERIENCE ) loop
        select
end;
/




