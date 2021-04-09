drop table resultat_test;
create table resultat_test (nomTest varchar2(100), resultat number(1) check(resultat in (0,1)));


/**
  Test positif pour T_VerificationDateExp DébutExp < FinExp
 */
create or replace procedure Test_T_VerificationDateExpPositif as
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
); -- insertion valide DebutExp<FinExp

rollback; -- suppression de toutes les données de contexte du test
insert into resultat_test values ('Test_T_VerificationDateExpPositif', 1); -- si une exception "check" est levée, le test réussi
commit; --validation du résultat du test

EXCEPTION
    WHEN CHECK_CONSTRAINT_VIOLATED THEN
		rollback; -- suppression de toutes les données de contexte du test
insert into resultat_test values ('Test_T_VerificationDateExpPositif', 0); -- si rien ne se passe, le test échoue
commit; --validation du résultat du test
end;
/

begin
Test_T_VerificationDateExpPositif;
end;
/


/**
  Test negatif pour T_VerificationDateExp DébutExp > FinExp
 */
create or replace procedure Test_T_VerificationDateExpNegatif as
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
    TO_DATE( 'October 10, 2020', 'MONTH DD, YYYY' ),
    TO_DATE( 'September 10, 2020', 'MONTH DD, YYYY' ),
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
); -- insertion Invalide DebutExp>FinExp

rollback; -- suppression de toutes les données de contexte du test
insert into resultat_test values ('Test_T_VerificationDateExpNegatif', 0); -- si rien ne se passe, le test échoue
commit; --validation du résultat du test

EXCEPTION
    WHEN CHECK_CONSTRAINT_VIOLATED THEN
		rollback; -- suppression de toutes les données de contexte du test
        insert into resultat_test values ('Test_T_VerificationDateExpNegatif', 1); -- si une exception "check" est levée, le test réussi
commit; --validation du résultat du test
end;
/

begin
Test_T_VerificationDateExpNegatif;
end;
/

select * from resultat_test;
commit;