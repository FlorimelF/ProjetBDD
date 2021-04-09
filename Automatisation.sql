drop trigger AutoCalculCoeffSurcout;
create trigger AutoCalculCoeffSurcout for UPDATE or INSERT on EXPERIENCE
declare
    priorite
begin
for i in (SELECT * FROM EXPERIENCE WHERE IndicePriorite > 1) loop
    SELECT COUNT(*) into nbN FROM EXPERIENCE WHERE
end loop;

end;
/
Un niveau de priorité supérieur à 1 a un impact sur le coût de l'expérience :
le prix total d'une expérience e est multiplié par le coefficient (n + d)/n,
où n est le nombre total d'expériences en attente de programmation à l'arrivée de e (e comprise),
et d est le nombre d'expériences
doublées par e dans la file d'attente, du fait de sa priorité.