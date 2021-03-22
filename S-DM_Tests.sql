/*==============================================================*/
/* Création de la table qui contient les résultats              */
/*==============================================================*/

drop table resultat_test;
create table resultat_test (nomTest varchar2(100), resultat number(1) check(resultat in (0,1)));



create or replace procedure TIndicePriorite1 as
begin
commit; -- definition du point de démarrage de début de test

insert into RESULTAT values (1, 1, '10-10-2020');
insert into REACTIF values (1, 55, 'reactif');
insert into TYPERELEVE values (1, (select IDREACTIF from REACTIF where NOMREACTIF ='reactif'), 'releve');
insert into EXPERIENCE values (1, 1, 2, 3, 5, 1, '10-09-2020', '10-10-2020', null, 2, '09-09-2020', 2, 4, 'technicien', 'chercheur', 3, 6, 2, null, (select IDRELEVE from TYPERELEVE where NOM_RELEVE ='releve'), (select IDRESULTAT from RESULTAT where DATETRANSMISSION ='10-10-2020')); -- insertion priorite invalide (prio > 3)

rollback; -- suppression de toutes les données de contexte du test
insert into resultat_test values ('TIndicePriorite1', 0); -- si rien ne se passe, le test échoue
commit; --validation du résulat du test

EXCEPTION
    WHEN CHECK_CONSTRAINT_VIOLATED THEN
		rollback; -- suppression de toutes les données de contexte du test
insert into resultat_test values ('TIndicePriorite1', 1); -- si une exception "check" est levée, le test réussi
commit; --validation du résulat du test
end;
/