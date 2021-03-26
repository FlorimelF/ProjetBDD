/*
 Création de la table qui contient les résultats de test
 */
drop table resultat_test;
create table resultat_test (nomTest varchar2(100), resultat number(1) check(resultat in (0,1)));



/*
  Test Indice Priorité Invalide > 3
 */
create or replace procedure TestIndicePrioritePlus as
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
insert into resultat_test values ('TestIndicePrioritePlus', 0); -- si rien ne se passe, le test échoue
commit; --validation du résultat du test

EXCEPTION
    WHEN CHECK_CONSTRAINT_VIOLATED THEN
		rollback; -- suppression de toutes les données de contexte du test
insert into resultat_test values ('TestIndicePrioritePlus', 1); -- si une exception "check" est levée, le test réussi
commit; --validation du résultat du test
end;
/

begin
TestIndicePrioritePlus;
end;
/


/**
  Test Indice Priorité Invalide <1
 */
create or replace procedure TestIndicePrioriteMoins as
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
insert into resultat_test values ('TestIndicePrioriteMoins', 0); -- si rien ne se passe, le test échoue
commit; --validation du résultat du test

EXCEPTION
    WHEN CHECK_CONSTRAINT_VIOLATED THEN
		rollback; -- suppression de toutes les données de contexte du test
insert into resultat_test values ('TestIndicePrioriteMoins', 1); -- si une exception "check" est levée, le test réussi
commit; --validation du résultat du test
end;
/

begin
TestIndicePrioriteMoins;
end;
/



/**
  Test Indice Priorité invalide = 2.5
 */
create or replace procedure TestIndicePrioriteEntre as
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
insert into resultat_test values ('TestIndicePrioriteEntre', 0); -- si rien ne se passe, le test échoue
commit; --validation du résultat du test

EXCEPTION
    WHEN CHECK_CONSTRAINT_VIOLATED THEN
		rollback; -- suppression de toutes les données de contexte du test
insert into resultat_test values ('TestIndicePrioriteEntre', 1); -- si une exception "check" est levée, le test réussi
commit; --validation du résultat du test
end;
/

begin
TestIndicePrioriteEntre;
end;
/


/**
  Test Indice Priorité valide = 2
 */
create or replace procedure TestIndicePriorite as
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
insert into resultat_test values ('TestIndicePriorite', 1); -- si une exception "check" est levée, le test réussi
commit; --validation du résultat du test

EXCEPTION
    WHEN CHECK_CONSTRAINT_VIOLATED THEN
		rollback; -- suppression de toutes les données de contexte du test
insert into resultat_test values ('TestIndicePriorite', 0); -- si rien ne se passe, le test échoue
commit; --validation du résultat du test
end;
/

begin
TestIndicePriorite;
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

/*
  Test NumSlot valide (NbSlotPourGroupe = 255)
 */
create or replace procedure TestNumSlot as
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
        255,
        6,
        2,
        null,
        (select IDRELEVE from TYPERELEVE where NOM_RELEVE ='releve'),
        (select IDRESULTAT from RESULTAT where DATETRANSMISSION ='10-OCT-20')
    ); -- insertion NbSlotPourGroupe valide (NbSlotPourGroupe = 255)

    rollback; -- suppression de toutes les données de contexte du test
    insert into resultat_test values ('TestNumSlot', 1); -- si une exception "check" est levée, le test réussi
    commit; --validation du résultat du test

EXCEPTION
    WHEN CHECK_CONSTRAINT_VIOLATED THEN
        rollback; -- suppression de toutes les données de contexte du test
        insert into resultat_test values ('TestNumSlot', 0); -- si rien ne se passe, le test échoue
        commit; --validation du résultat du test
end;
/

begin
    TestNumSlot;
end;
/


/*
  Test NumSlot invalide (NbSlotPourGroupe = -1)
 */
create or replace procedure TestNumSlotMoins as
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
        -1,
        6,
        2,
        null,
        (select IDRELEVE from TYPERELEVE where NOM_RELEVE ='releve'),
        (select IDRESULTAT from RESULTAT where DATETRANSMISSION ='10-OCT-20')
    ); -- insertion NbSlotPourGroupe invalide (NbSlotPourGroupe = -1)

    rollback; -- suppression de toutes les données de contexte du test
    insert into resultat_test values ('TestNumSlotMoins', 0); -- si rien ne se passe, le test échoue
    commit; --validation du résultat du test

EXCEPTION
    WHEN CHECK_CONSTRAINT_VIOLATED THEN
        rollback; -- suppression de toutes les données de contexte du test
        insert into resultat_test values ('TestNumSlotMoins', 1); -- si une exception "check" est levée, le test réussi
        commit; --validation du résultat du test
end;
/

begin
    TestNumSlotMoins;
end;
/


/*
  Test NumSlot invalide (NbSlotPourGroupe = 385)
 */
create or replace procedure TestNumSlotPlus as
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
        385,
        6,
        2,
        null,
        (select IDRELEVE from TYPERELEVE where NOM_RELEVE ='releve'),
        (select IDRESULTAT from RESULTAT where DATETRANSMISSION ='10-OCT-20')
    ); -- insertion NbSlotPourGroupe invalide (NbSlotPourGroupe = 385)

    rollback; -- suppression de toutes les données de contexte du test
    insert into resultat_test values ('TestNumSlotPlus', 0); -- si rien ne se passe, le test échoue
    commit; --validation du résultat du test

EXCEPTION
    WHEN CHECK_CONSTRAINT_VIOLATED THEN
        rollback; -- suppression de toutes les données de contexte du test
        insert into resultat_test values ('TestNumSlotPlus', 1); -- si une exception "check" est levée, le test réussi
        commit; --validation du résultat du test
end;
/

begin
    TestNumSlotPlus;
end;
/

/*
  Test a1 invalide (a1 = -1)
 */
create or replace procedure TestNonNegatifMoins as
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
        -1,
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
        255,
        6,
        2,
        null,
        (select IDRELEVE from TYPERELEVE where NOM_RELEVE ='releve'),
        (select IDRESULTAT from RESULTAT where DATETRANSMISSION ='10-OCT-20')
    ); -- insertion a1 invalide (a1 = -1)

    rollback; -- suppression de toutes les données de contexte du test
    insert into resultat_test values ('TestNonNegatifMoins', 0); -- si rien ne se passe, le test échoue
    commit; --validation du résultat du test

EXCEPTION
    WHEN CHECK_CONSTRAINT_VIOLATED THEN
        rollback; -- suppression de toutes les données de contexte du test
        insert into resultat_test values ('TestNonNegatifMoins', 1); -- si une exception "check" est levée, le test réussi
        commit; --validation du résultat du test
end;
/

begin
    TestNonNegatifMoins;
end;
/

/*
  Test a1 valide (a1 = 1)
 */
create or replace procedure TestNonNegatif as
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
        255,
        6,
        2,
        null,
        (select IDRELEVE from TYPERELEVE where NOM_RELEVE ='releve'),
        (select IDRESULTAT from RESULTAT where DATETRANSMISSION ='10-OCT-20')
    ); -- insertion a1 valide (a1 = 1)

    rollback; -- suppression de toutes les données de contexte du test
    insert into resultat_test values ('TestNonNegatif', 1); -- si une exception "check" est levée, le test réussi
    commit; --validation du résultat du test

EXCEPTION
    WHEN CHECK_CONSTRAINT_VIOLATED THEN
        rollback; -- suppression de toutes les données de contexte du test
        insert into resultat_test values ('TestNonNegatif', 0); -- si rien ne se passe, le test échoue
        commit; --validation du résultat du test
end;
/

begin
    TestNonNegatif;
end;
/

SELECT * FROM resultat_test;