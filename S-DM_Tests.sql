/*
 Création de la table qui contient les résultats de test
 */
drop table resultat_test;
create table resultat_test (nomTest varchar2(100), resultat number(1) check(resultat in (0,1)));



/*
  Test Indice Priorité > 3
 */
create or replace procedure TestIndicePriorite1 as
CHECK_CONSTRAINT_VIOLATED EXCEPTION;
pragma exception_init(check_constraint_violated, -2290); --permet de capturer les exceptions levées par un "check"

begin
commit; -- definition du point de démarrage de début de test

insert into RESULTAT values
(
    1,
    1,
    TO_DATE( 'October 10, 2020', 'MONTH DD, YYYY' )
);
insert into REACTIF values
(
    1,
    55,
    'reactif'
);
insert into TYPERELEVE values
(
    1,
    (select IDREACTIF from REACTIF where NOMREACTIF ='reactif'),
    'releve'
);
insert into EXPERIENCE values
(
    1,
    1,
    2,
    1,
    5,
    1,
    TO_DATE( 'September 10, 2020', 'MONTH DD, YYYY' ),
    TO_DATE( 'October 10, 2020', 'MONTH DD, YYYY' ),
    null,
    2,
    TO_DATE( 'September 09, 2020', 'MONTH DD, YYYY' ),
    2,
    4,
    'technicien',
    'chercheur',
    3,
    6,
    2,
    null,
    (select IDRELEVE from TYPERELEVE where NOM_RELEVE ='releve'),
    (select IDRESULTAT from RESULTAT where DATETRANSMISSION ='10-OCT-20')
); -- insertion priorite invalide (prio > 3)

rollback; -- suppression de toutes les données de contexte du test
insert into resultat_test values ('TestIndicePriorite1', 0); -- si rien ne se passe, le test échoue
commit; --validation du résultat du test

EXCEPTION
    WHEN CHECK_CONSTRAINT_VIOLATED THEN
		rollback; -- suppression de toutes les données de contexte du test
insert into resultat_test values ('TestIndicePriorite1', 1); -- si une exception "check" est levée, le test réussi
commit; --validation du résultat du test
end;
/

begin
TestIndicePriorite1;
end;
/


/**
  Test Indice Priorité <1
 */
create or replace procedure TestIndicePriorite2 as
CHECK_CONSTRAINT_VIOLATED EXCEPTION;
pragma exception_init(check_constraint_violated, -2290) ; --permet de capturer les exceptions levées par un "check"

begin
commit; -- definition du point de démarrage de début de test

insert into RESULTAT values
(
    1,
    1,
    TO_DATE( 'October 10, 2020', 'MONTH DD, YYYY' )
);
insert into REACTIF values
(
    1,
    55,
    'reactif'
);
insert into TYPERELEVE values
(
    1,
    (select IDREACTIF from REACTIF where NOMREACTIF ='reactif'),
    'releve'
);
insert into EXPERIENCE values
(
    1,
    1,
    2,
    1,
    5,
    1,
    TO_DATE( 'September 10, 2020', 'MONTH DD, YYYY' ),
    TO_DATE( 'October 10, 2020', 'MONTH DD, YYYY' ),
    null,
    2,
    TO_DATE( 'September 09, 2020', 'MONTH DD, YYYY' ),
    2,
    0,
    'technicien',
    'chercheur',
    3,
    6,
    2,
    null,
    (select IDRELEVE from TYPERELEVE where NOM_RELEVE ='releve'),
    (select IDRESULTAT from RESULTAT where DATETRANSMISSION ='10-OCT-20')
); -- insertion priorite invalide (prio < 1)

rollback; -- suppression de toutes les données de contexte du test
insert into resultat_test values ('TestIndicePriorite2', 0); -- si rien ne se passe, le test échoue
commit; --validation du résultat du test

EXCEPTION
    WHEN CHECK_CONSTRAINT_VIOLATED THEN
		rollback; -- suppression de toutes les données de contexte du test
insert into resultat_test values ('TestIndicePriorite2', 1); -- si une exception "check" est levée, le test réussi
commit; --validation du résultat du test
end;
/

begin
TestIndicePriorite2;
end;
/



/**
  Test Indice Priorité à 2.5
 */
create or replace procedure TestIndicePriorite3 as
CHECK_CONSTRAINT_VIOLATED EXCEPTION;
pragma exception_init(check_constraint_violated, -2290) ; --permet de capturer les exceptions levées par un "check"

begin
commit; -- definition du point de démarrage de début de test

insert into RESULTAT values
(
    1,
    1,
    TO_DATE( 'October 10, 2020', 'MONTH DD, YYYY' )
);
insert into REACTIF values
(
    1,
    55,
    'reactif'
);
insert into TYPERELEVE values
(
    1,
    (select IDREACTIF from REACTIF where NOMREACTIF ='reactif'),
    'releve'
);
insert into EXPERIENCE values
(
    1,
    1,
    2,
    1,
    5,
    1,
    TO_DATE( 'September 10, 2020', 'MONTH DD, YYYY' ),
    TO_DATE( 'October 10, 2020', 'MONTH DD, YYYY' ),
    null,
    2,
    TO_DATE( 'September 09, 2020', 'MONTH DD, YYYY' ),
    2,
    0,
    'technicien',
    'chercheur',
    2.5,
    6,
    2,
    null,
    (select IDRELEVE from TYPERELEVE where NOM_RELEVE ='releve'),
    (select IDRESULTAT from RESULTAT where DATETRANSMISSION ='10-OCT-20')
); -- insertion priorite invalide (prio = 2.5)

rollback; -- suppression de toutes les données de contexte du test
insert into resultat_test values ('TestIndicePriorite3', 0); -- si rien ne se passe, le test échoue
commit; --validation du résultat du test

EXCEPTION
    WHEN CHECK_CONSTRAINT_VIOLATED THEN
		rollback; -- suppression de toutes les données de contexte du test
insert into resultat_test values ('TestIndicePriorite3', 1); -- si une exception "check" est levée, le test réussi
commit; --validation du résultat du test
end;
/

begin
TestIndicePriorite3;
end;
/


/**
  Test Indice Priorité valide = 2
 */
create or replace procedure TestIndicePriorite4 as
CHECK_CONSTRAINT_VIOLATED EXCEPTION;
pragma exception_init(check_constraint_violated, -2290) ; --permet de capturer les exceptions levées par un "check"

begin
commit; -- definition du point de démarrage de début de test

insert into RESULTAT values
(
    1,
    1,
    TO_DATE( 'October 10, 2020', 'MONTH DD, YYYY' )
);
insert into REACTIF values
(
    1,
    55,
    'reactif'
);
insert into TYPERELEVE values
(
    1,
    (select IDREACTIF from REACTIF where NOMREACTIF ='reactif'),
    'releve'
);
insert into EXPERIENCE values
(
    1,
    1,
    2,
    1,
    5,
    1,
    TO_DATE( 'September 10, 2020', 'MONTH DD, YYYY' ),
    TO_DATE( 'October 10, 2020', 'MONTH DD, YYYY' ),
    null,
    2,
    TO_DATE( 'September 09, 2020', 'MONTH DD, YYYY' ),
    2,
    3,
    'technicien',
    'chercheur',
    3,
    6,
    2,
    null,
    (select IDRELEVE from TYPERELEVE where NOM_RELEVE ='releve'),
    (select IDRESULTAT from RESULTAT where DATETRANSMISSION ='10-OCT-20')
); -- insertion priorite valide (prio = 2)

rollback; -- suppression de toutes les données de contexte du test
insert into resultat_test values ('TestIndicePriorite4', 1); -- si une exception "check" est levée, le test réussi
commit; --validation du résultat du test

EXCEPTION
    WHEN CHECK_CONSTRAINT_VIOLATED THEN
		rollback; -- suppression de toutes les données de contexte du test
insert into resultat_test values ('TestIndicePriorite4', 0); -- si rien ne se passe, le test échoue
commit; --validation du résultat du test
end;
/

begin
TestIndicePriorite4;
end;
/


/*
  Test a3 <0
 */
create or replace procedure TestEntre0et1moins as
CHECK_CONSTRAINT_VIOLATED EXCEPTION;
pragma exception_init(check_constraint_violated, -2290) ; --permet de capturer les exceptions levées par un "check"

begin
commit; -- definition du point de démarrage de début de test

insert into RESULTAT values
(
    1,
    1,
    TO_DATE( 'October 10, 2020', 'MONTH DD, YYYY' )
);
insert into REACTIF values
(
    1,
    55,
    'reactif'
);
insert into TYPERELEVE values
(
    1,
    (select IDREACTIF from REACTIF where NOMREACTIF ='reactif'),
    'releve'
);
insert into EXPERIENCE values
(
    1,
    1,
    2,
    -1,
    5,
    1,
    TO_DATE( 'September 10, 2020', 'MONTH DD, YYYY' ),
    TO_DATE( 'October 10, 2020', 'MONTH DD, YYYY' ),
    null,
    2,
    TO_DATE( 'September 09, 2020', 'MONTH DD, YYYY' ),
    2,
    3,
    'technicien',
    'chercheur',
    3,
    6,
    2,
    null,
    (select IDRELEVE from TYPERELEVE where NOM_RELEVE ='releve'),
    (select IDRESULTAT from RESULTAT where DATETRANSMISSION ='10-OCT-20')
); -- insertion a3 invalide (a3 < 0)

rollback; -- suppression de toutes les données de contexte du test
insert into resultat_test values ('TestEntre0et1moins', 0); -- si rien ne se passe, le test échoue
commit; --validation du résultat du test

EXCEPTION
    WHEN CHECK_CONSTRAINT_VIOLATED THEN
		rollback; -- suppression de toutes les données de contexte du test
insert into resultat_test values ('TestEntre0et1moins', 1); -- si une exception "check" est levée, le test réussi
commit; --validation du résultat du test
end;
/

begin
TestEntre0et1moins;
end;
/


/*
  Test a3 >1
 */
create or replace procedure TestEntre0et1plus as
CHECK_CONSTRAINT_VIOLATED EXCEPTION;
pragma exception_init(check_constraint_violated, -2290) ; --permet de capturer les exceptions levées par un "check"

begin
commit; -- definition du point de démarrage de début de test

insert into RESULTAT values
(
    1,
    1,
    TO_DATE( 'October 10, 2020', 'MONTH DD, YYYY' )
);
insert into REACTIF values
(
    1,
    55,
    'reactif'
);
insert into TYPERELEVE values
(
    1,
    (select IDREACTIF from REACTIF where NOMREACTIF ='reactif'),
    'releve'
);
insert into EXPERIENCE values
(
    1,
    1,
    2,
    2,
    5,
    1,
    TO_DATE( 'September 10, 2020', 'MONTH DD, YYYY' ),
    TO_DATE( 'October 10, 2020', 'MONTH DD, YYYY' ),
    null,
    2,
    TO_DATE( 'September 09, 2020', 'MONTH DD, YYYY' ),
    2,
    3,
    'technicien',
    'chercheur',
    3,
    6,
    2,
    null,
    (select IDRELEVE from TYPERELEVE where NOM_RELEVE ='releve'),
    (select IDRESULTAT from RESULTAT where DATETRANSMISSION ='10-OCT-20')
); -- insertion a3 invalide (a3 > 1)

rollback; -- suppression de toutes les données de contexte du test
insert into resultat_test values ('TestEntre0et1plus', 0); -- si rien ne se passe, le test échoue
commit; --validation du résultat du test

EXCEPTION
    WHEN CHECK_CONSTRAINT_VIOLATED THEN
		rollback; -- suppression de toutes les données de contexte du test
insert into resultat_test values ('TestEntre0et1plus', 1); -- si une exception "check" est levée, le test réussi
commit; --validation du résultat du test
end;
/

begin
TestEntre0et1plus;
end;
/

/*
  Test a3 valide (a3 = 0.5)
 */
create or replace procedure TestEntre0et1 as
CHECK_CONSTRAINT_VIOLATED EXCEPTION;
pragma exception_init(check_constraint_violated, -2290) ; --permet de capturer les exceptions levées par un "check"

begin
commit; -- definition du point de démarrage de début de test

insert into RESULTAT values
(
    1,
    1,
    TO_DATE( 'October 10, 2020', 'MONTH DD, YYYY' )
);
insert into REACTIF values
(
    1,
    55,
    'reactif'
);
insert into TYPERELEVE values
(
    1,
    (select IDREACTIF from REACTIF where NOMREACTIF ='reactif'),
    'releve'
);
insert into EXPERIENCE values
(
    1,
    1,
    2,
    0.5,
    5,
    1,
    TO_DATE( 'September 10, 2020', 'MONTH DD, YYYY' ),
    TO_DATE( 'October 10, 2020', 'MONTH DD, YYYY' ),
    null,
    2,
    TO_DATE( 'September 09, 2020', 'MONTH DD, YYYY' ),
    2,
    3,
    'technicien',
    'chercheur',
    3,
    6,
    2,
    null,
    (select IDRELEVE from TYPERELEVE where NOM_RELEVE ='releve'),
    (select IDRESULTAT from RESULTAT where DATETRANSMISSION ='10-OCT-20')
); -- insertion a3 valide (a3 = 0.5)

rollback; -- suppression de toutes les données de contexte du test
insert into resultat_test values ('TestEntre0et1', 1); -- si une exception "check" est levée, le test réussi
commit; --validation du résultat du test

EXCEPTION
    WHEN CHECK_CONSTRAINT_VIOLATED THEN
		rollback; -- suppression de toutes les données de contexte du test
insert into resultat_test values ('TestEntre0et1', 0); -- si rien ne se passe, le test échoue
commit; --validation du résultat du test
end;
/

begin
TestEntre0et1;
end;
/