-- Enola-ROUDAUT
-- Florimel-FLOTTE
-- Salomé-REBOURS

-------------------------------------------------------------------------------------------------------------- SOMMAIRE

------------------------------------------ Tests contraintes structurelles (domaine)
-- 1.   TestIndicePriorité
-- 2.   TestEntre0et1
-- 3.   TestNumSlot
-- 4.   TestNonNegatif
-- 5.   TestDiff0Positif

------------------------------------------------ Tests contraintes non structurelles

-- 1.   VerificationDateExp
-- 2.   VerificationDateDemande
-- 3.   VerificationNiveauAcceptation
-- 4.   IntégrationReactif
-- 5.   VerificationNomRelevé
-- 6.   VerificationDivisionEntiere

-------------------------------------------------------------- Tests automatisations
-- 1.   AutoCalculCoeffSurcout

------------------------------------------------------------------------------------------- Table de résultat des tests

drop table TraceTest;
create table TraceTest (
  nomTest varchar2(100), 
  resultat number(1) check(resultat in (0,1))
);

-----------------------------------------------------------------------------------------------------------------------
------------------------------------------- TESTS CONTRAINTES STRUCTURELLES -------------------------------------------
-----------------------------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------- TestIndicePriorité
-- La valeur doit valoir 1, 2 ou 3

------------------------------------------------------------------------ Indice priorité valide = 2

create or replace procedure TestIndicePriorite as
  CHECK_CONSTRAINT_VIOLATED EXCEPTION;
  pragma exception_init(check_constraint_violated, -2290);
begin
  commit;
  insert into RESULTAT values (1,1,'10-OCT-20');
  insert into REACTIF values (1,55,'reactif');
  insert into TYPERELEVE values (1,(select IDREACTIF from REACTIF where NOMREACTIF ='reactif'),'Colorimétrique');
  insert into EXPERIENCE values (
    1,1,2,1,5,1,'10-SEP-20','10-OCT-20',null,2,'09-SEP-20',2,
    2, -- Insertion priorité valide (prio = 2)
    'technicien','chercheur',3,6,2,null,
    (select IDRELEVE from TYPERELEVE where NOM_RELEVE ='Colorimétrique'),
    (select IDRESULTAT from RESULTAT where DATETRANSMISSION ='10-OCT-20')
  );
  rollback;
  insert into TraceTest values ('TestIndicePriorite', 1);
  commit;
  EXCEPTION
    WHEN CHECK_CONSTRAINT_VIOLATED THEN
      rollback;
      insert into TraceTest values ('TestIndicePriorite', 0);
      commit;
end;
/
begin
  TestIndicePriorite;
end;
/
commit;

---------------------------------------------------------------------- Indice priorité invalide > 3

create or replace procedure TestIndicePrioritePlus as
  CHECK_CONSTRAINT_VIOLATED EXCEPTION;
  pragma exception_init(check_constraint_violated, -2290); -- Permet de capturer les exceptions levées par un "check"
begin
  commit; -- Définition du point de démarrage de début de test
  insert into RESULTAT values (1,1,'10-OCT-20');
  insert into REACTIF values (1,55,'reactif');
  insert into TYPERELEVE values (1,(select IDREACTIF from REACTIF where NOMREACTIF ='reactif'),'Colorimétrique');
  insert into EXPERIENCE values (
    1,1,2,1,5,1,'10-SEP-20','10-OCT-20',null,2,'09-SEP-20',2,
    4, -- Insertion priorité invalide (prio > 3)
    'technicien','chercheur',3,6,2,null,
    (select IDRELEVE from TYPERELEVE where NOM_RELEVE ='Colorimétrique'),
    (select IDRESULTAT from RESULTAT where DATETRANSMISSION ='10-OCT-20')
  ); 
  rollback; -- Suppression de toutes les données de contexte du test
  insert into TraceTest values ('TestIndicePrioritePlus', 0); -- Si rien ne se passe, le test échoue
  commit; -- Validation du résultat du test
  EXCEPTION
    WHEN CHECK_CONSTRAINT_VIOLATED THEN
      rollback; -- Suppression de toutes les données de contexte du test
      insert into TraceTest values ('TestIndicePrioritePlus', 1); -- Si une exception "check" est levée, le test réussi
      commit; -- Validation du résultat du test
end;
/
begin
  TestIndicePrioritePlus;
end;
/
commit;

---------------------------------------------------------------------- Indice priorité invalide < 1

create or replace procedure TestIndicePrioriteMoins as
  CHECK_CONSTRAINT_VIOLATED EXCEPTION;
  pragma exception_init(check_constraint_violated, -2290); 
begin
  commit;
  insert into RESULTAT values (1,1,'10-OCT-20');
  insert into REACTIF values (1,55,'reactif');
  insert into TYPERELEVE values (1,(select IDREACTIF from REACTIF where NOMREACTIF ='reactif'),'Colorimétrique');
  insert into EXPERIENCE values (
    1,1,2,1,5,1,'10-SEP-20','10-OCT-20',null,2,'09-SEP-20',2,
    0, -- Insertion priorité invalide (prio < 1)
    'technicien','chercheur',3,6,2,null,
    (select IDRELEVE from TYPERELEVE where NOM_RELEVE ='Colorimétrique'),
    (select IDRESULTAT from RESULTAT where DATETRANSMISSION ='10-OCT-20')
  ); 
  rollback;
  insert into TraceTest values ('TestIndicePrioriteMoins', 0);
  commit;
  EXCEPTION
    WHEN CHECK_CONSTRAINT_VIOLATED THEN
      rollback;
      insert into TraceTest values ('TestIndicePrioriteMoins', 1);
      commit;
end;
/
begin
  TestIndicePrioriteMoins;
end;
/
commit;

-------------------------------------------------------------------- Indice priorité invalide = 2.5

create or replace procedure TestIndicePrioriteEntre as
  CHECK_CONSTRAINT_VIOLATED EXCEPTION;
  pragma exception_init(check_constraint_violated, -2290);
begin
  commit;
  insert into RESULTAT values (1,1,'10-OCT-20');
  insert into REACTIF values (1,55,'reactif');
  insert into TYPERELEVE values (1,(select IDREACTIF from REACTIF where NOMREACTIF ='reactif'),'Colorimétrique');
  insert into EXPERIENCE values (
    1,1,2,1,5,1,'10-SEP-20','10-OCT-20',null,2,'09-SEP-20',2,
    2.5, -- Insertion priorité invalide (prio = 2.5)
    'technicien','chercheur',3,6,2,null,
    (select IDRELEVE from TYPERELEVE where NOM_RELEVE ='Colorimétrique'),
    (select IDRESULTAT from RESULTAT where DATETRANSMISSION ='10-OCT-20')
  );
  rollback;
  insert into TraceTest values ('TestIndicePrioriteEntre', 0);
  commit;
  EXCEPTION
    WHEN CHECK_CONSTRAINT_VIOLATED THEN
      rollback;
      insert into TraceTest values ('TestIndicePrioriteEntre', 1);
      commit;
end;
/
begin
  TestIndicePrioriteEntre;
end;
/
commit;

--------------------------------------------------------------------------------------------------------- TestEntre0et1
-- La valeur doit valoir entre 0 et 1

------------------------------------------------------------------------------ Test a3 valide = 0.5

create or replace procedure TestEntre0et1 as
  CHECK_CONSTRAINT_VIOLATED EXCEPTION;
  pragma exception_init(check_constraint_violated, -2290);
begin
  commit;
  insert into RESULTAT values (1,1,'10-OCT-20');
  insert into REACTIF values (1,55,'reactif');
  insert into TYPERELEVE values (1,(select IDREACTIF from REACTIF where NOMREACTIF ='reactif'),'Colorimétrique');
  insert into EXPERIENCE values (
    1,1,2,
    0.5, -- Insertion a3 valide (a3 = 0.5)
    5,1,'10-SEP-20','10-OCT-20',null,2,'09-SEP-20',2,3,'technicien','chercheur',3,6,2,null,
    (select IDRELEVE from TYPERELEVE where NOM_RELEVE ='Colorimétrique'),
    (select IDRESULTAT from RESULTAT where DATETRANSMISSION ='10-OCT-20')
  );
  rollback;
  insert into TraceTest values ('TestEntre0et1', 1);
  commit;
  EXCEPTION
    WHEN CHECK_CONSTRAINT_VIOLATED THEN
      rollback;
      insert into TraceTest values ('TestEntre0et1', 0);
      commit;
end;
/
begin
  TestEntre0et1;
end;
/
commit;

------------------------------------------------------------------------------ Test a3 invalide < 0

create or replace procedure TestEntre0et1moins as
  CHECK_CONSTRAINT_VIOLATED EXCEPTION;
  pragma exception_init(check_constraint_violated, -2290);
begin
  commit;
  insert into RESULTAT values (1,1,'10-OCT-20');
  insert into REACTIF values (1,55,'reactif');
  insert into TYPERELEVE values (1,(select IDREACTIF from REACTIF where NOMREACTIF ='reactif'),'Colorimétrique');
  insert into EXPERIENCE values (
    1,1,2,
    -1, -- Insertion a3 invalide (a3 = -1 < 0)
    5,1,'10-SEP-20','10-OCT-20',null,2,'09-SEP-20',2,3,'technicien','chercheur',3,6,2,null,
    (select IDRELEVE from TYPERELEVE where NOM_RELEVE ='Colorimétrique'),
    (select IDRESULTAT from RESULTAT where DATETRANSMISSION ='10-OCT-20')
  );
  rollback;
  insert into TraceTest values ('TestEntre0et1moins', 0);
  commit;
  EXCEPTION
    WHEN CHECK_CONSTRAINT_VIOLATED THEN
      rollback;
      insert into TraceTest values ('TestEntre0et1moins', 1);
      commit;
end;
/
begin
  TestEntre0et1moins;
end;
/
commit;

------------------------------------------------------------------------------ Test a3 invalide > 1

create or replace procedure TestEntre0et1plus as
  CHECK_CONSTRAINT_VIOLATED EXCEPTION;
  pragma exception_init(check_constraint_violated, -2290);
begin
  commit;
  insert into RESULTAT values (1,1,'10-OCT-20');
  insert into REACTIF values (1,55,'reactif');
  insert into TYPERELEVE values (1,(select IDREACTIF from REACTIF where NOMREACTIF ='reactif'),'Colorimétrique');
  insert into EXPERIENCE values (
    1,1,2,
    2, -- Insertion a3 invalide (a3 = 2 > 1)
    5,1,'10-SEP-20','10-OCT-20',null,2,'09-SEP-20',2,3,'technicien','chercheur',3,6,2,null,
    (select IDRELEVE from TYPERELEVE where NOM_RELEVE ='Colorimétrique'),
    (select IDRESULTAT from RESULTAT where DATETRANSMISSION ='10-OCT-20')
  );
  rollback;
  insert into TraceTest values ('TestEntre0et1plus', 0);
  commit;
  EXCEPTION
    WHEN CHECK_CONSTRAINT_VIOLATED THEN
      rollback;
      insert into TraceTest values ('TestEntre0et1plus', 1);
      commit;
end;
/
begin
  TestEntre0et1plus;
end;
/
commit;

----------------------------------------------------------------------------------------------------------- TestNumSlot
-- La valeur doit valoir entre 1 et 384 inclus

---------------------------------------------------------------- Test NbSlotPourGroupe valide = 255

create or replace procedure TestNumSlot as
  CHECK_CONSTRAINT_VIOLATED EXCEPTION;
  pragma exception_init(check_constraint_violated, -2290);
begin
  commit;
  insert into RESULTAT values (1,1,'10-OCT-20');
  insert into REACTIF values (1,55,'reactif');
  insert into TYPERELEVE values (1,(select IDREACTIF from REACTIF where NOMREACTIF ='reactif'),'Colorimétrique');
  insert into EXPERIENCE values (
    1,1,2,0.5,5,1,'10-SEP-20','10-OCT-20',null,2,'09-SEP-20',2,3,'technicien','chercheur',
    255, -- Insertion NbSlotPourGroupe valide = 255
    6,2,null,
    (select IDRELEVE from TYPERELEVE where NOM_RELEVE ='Colorimétrique'),
    (select IDRESULTAT from RESULTAT where DATETRANSMISSION ='10-OCT-20')
  );
  rollback;
  insert into TraceTest values ('TestNumSlot', 1);
  commit;
  EXCEPTION
    WHEN CHECK_CONSTRAINT_VIOLATED THEN
      rollback;
      insert into TraceTest values ('TestNumSlot', 0);
      commit;
end;
/
begin
  TestNumSlot;
end;
/
commit;

--------------------------------------------------------------- Test NbSlotPourGroupe invalide = -1

create or replace procedure TestNumSlotMoins as
  CHECK_CONSTRAINT_VIOLATED EXCEPTION;
  pragma exception_init(check_constraint_violated, -2290);
begin
  commit;
  insert into RESULTAT values (1,1,'10-OCT-20');
  insert into REACTIF values (1,55,'reactif');
  insert into TYPERELEVE values (1,(select IDREACTIF from REACTIF where NOMREACTIF ='reactif'),'Colorimétrique');
  insert into EXPERIENCE values (
    1,1,2,0.5,5,1,'10-SEP-20','10-OCT-20',null,2,'09-SEP-20',2,3,'technicien','chercheur',
    -1, -- Insertion NbSlotPourGroupe invalide = -1 < 1
    6,2,null,
    (select IDRELEVE from TYPERELEVE where NOM_RELEVE ='Colorimétrique'),
    (select IDRESULTAT from RESULTAT where DATETRANSMISSION ='10-OCT-20')
  );
  rollback;
  insert into TraceTest values ('TestNumSlotMoins', 0);
  commit;
  EXCEPTION
    WHEN CHECK_CONSTRAINT_VIOLATED THEN
      rollback;
      insert into TraceTest values ('TestNumSlotMoins', 1);
      commit;
end;
/
begin
  TestNumSlotMoins;
end;
/
commit;

-------------------------------------------------------------- Test NbSlotPourGroupe invalide = 385

create or replace procedure TestNumSlotPlus as
  CHECK_CONSTRAINT_VIOLATED EXCEPTION;
  pragma exception_init(check_constraint_violated, -2290);
begin
  commit;
  insert into RESULTAT values (1,1,'10-OCT-20');
  insert into REACTIF values (1,55,'reactif');
  insert into TYPERELEVE values (1,(select IDREACTIF from REACTIF where NOMREACTIF ='reactif'),'Colorimétrique');
  insert into EXPERIENCE values (
    1,1,2,0.5,5,1,'10-SEP-20','10-OCT-20',null,2,'09-SEP-20',2,3,'technicien','chercheur',
    385, -- Insertion NbSlotPourGroupe invalide = 385 > 384
    6,2,null,
    (select IDRELEVE from TYPERELEVE where NOM_RELEVE ='Colorimétrique'),
    (select IDRESULTAT from RESULTAT where DATETRANSMISSION ='10-OCT-20')
  );
  rollback;
  insert into TraceTest values ('TestNumSlotPlus', 0);
  commit;
  EXCEPTION
    WHEN CHECK_CONSTRAINT_VIOLATED THEN
      rollback;
      insert into TraceTest values ('TestNumSlotPlus', 1);
      commit;
end;
/
begin
  TestNumSlotPlus;
end;
/
commit;

-------------------------------------------------------------------------------------------------------- TestNonNegatif
-- La valeur vaut au minimum 0

-------------------------------------------------------------------------------- Test a1 valide = 0

create or replace procedure TestNonNegatif as
  CHECK_CONSTRAINT_VIOLATED EXCEPTION;
  pragma exception_init(check_constraint_violated, -2290);
begin
  commit;
  insert into RESULTAT values (1,1,'10-OCT-20');
  insert into REACTIF values (1,55,'reactif');
  insert into TYPERELEVE values (1,(select IDREACTIF from REACTIF where NOMREACTIF ='reactif'),'Colorimétrique');
  insert into EXPERIENCE values (
    1,
    0, -- Insertion a1 valide = 0
    2,0.5,5,1,'10-SEP-20','10-OCT-20',null,2,'09-SEP-20',2,3,'technicien','chercheur',255,6,2,null,
    (select IDRELEVE from TYPERELEVE where NOM_RELEVE ='Colorimétrique'),
    (select IDRESULTAT from RESULTAT where DATETRANSMISSION ='10-OCT-20')
  );
  rollback;
  insert into TraceTest values ('TestNonNegatif', 1);
  commit;
  EXCEPTION
    WHEN CHECK_CONSTRAINT_VIOLATED THEN
      rollback;
      insert into TraceTest values ('TestNonNegatif', 0);
      commit;
end;
/
begin
  TestNonNegatif;
end;
/
commit;

----------------------------------------------------------------------------- Test a1 invalide = -1

create or replace procedure TestNonNegatifMoins as
  CHECK_CONSTRAINT_VIOLATED EXCEPTION;
  pragma exception_init(check_constraint_violated, -2290);
begin
  commit;
  insert into RESULTAT values (1,1,'10-OCT-20');
  insert into REACTIF values (1,55,'reactif');
  insert into TYPERELEVE values (1,(select IDREACTIF from REACTIF where NOMREACTIF ='reactif'),'Colorimétrique');
  insert into EXPERIENCE values (
    1,
    -1, -- Insertion a1 invalide = -1
    2,0.5,5,1,'10-SEP-20','10-OCT-20',null,2,'09-SEP-20',2,3,'technicien','chercheur',255,6,2,null,
    (select IDRELEVE from TYPERELEVE where NOM_RELEVE ='Colorimétrique'),
    (select IDRESULTAT from RESULTAT where DATETRANSMISSION ='10-OCT-20')
  );
  rollback;
  insert into TraceTest values ('TestNonNegatifMoins', 0);
  commit;
  EXCEPTION
    WHEN CHECK_CONSTRAINT_VIOLATED THEN
      rollback;
      insert into TraceTest values ('TestNonNegatifMoins', 1);
      commit;
end;
/
begin
  TestNonNegatifMoins;
end;
/
commit;

------------------------------------------------------------------------------------------------------ TestDiff0Positif
-- La valeur doit être strictement positive

-------------------------------------------------------------------------------- Test fObservation valide = 1

create or replace procedure TestDiff0Positif as
  CHECK_CONSTRAINT_VIOLATED EXCEPTION;
  pragma exception_init(check_constraint_violated, -2290);
begin
  commit;
  insert into RESULTAT values (1,1,'10-OCT-20');
  insert into REACTIF values (1,55,'reactif');
  insert into TYPERELEVE values (1,(select IDREACTIF from REACTIF where NOMREACTIF ='reactif'),'Colorimétrique');
  insert into EXPERIENCE values (
    1,0,2,0.5,5,1,'10-SEP-20','10-OCT-20',
    1, -- Insertion fObservation valide = 1
    2,'09-SEP-20',2,3,'technicien','chercheur',255,6,2,null,
    (select IDRELEVE from TYPERELEVE where NOM_RELEVE ='Colorimétrique'),
    (select IDRESULTAT from RESULTAT where DATETRANSMISSION ='10-OCT-20')
  );
  rollback;
  insert into TraceTest values ('TestDiff0Positif', 1);
  commit;
  EXCEPTION
    WHEN CHECK_CONSTRAINT_VIOLATED THEN
      rollback;
      insert into TraceTest values ('TestDiff0Positif', 0);
      commit;
end;
/
begin
  TestDiff0Positif;
end;
/
commit;

------------------------------------------------------------------------------ Test fObservation invalide = 0

create or replace procedure TestDiff0PositifMoins as
  CHECK_CONSTRAINT_VIOLATED EXCEPTION;
  pragma exception_init(check_constraint_violated, -2290);
begin
  commit;
  insert into RESULTAT values (1,1,'10-OCT-20');
  insert into REACTIF values (1,55,'reactif');
  insert into TYPERELEVE values (1,(select IDREACTIF from REACTIF where NOMREACTIF ='reactif'),'Colorimétrique');
  insert into EXPERIENCE values (
    1,0,2,0.5,5,1,'10-SEP-20','10-OCT-20',
    0, -- Insertion fObservation invalide = 0
    2,'09-SEP-20',2,3,'technicien','chercheur',255,6,2,null,
    (select IDRELEVE from TYPERELEVE where NOM_RELEVE ='Colorimétrique'),
    (select IDRESULTAT from RESULTAT where DATETRANSMISSION ='10-OCT-20')
  );
  rollback;
  insert into TraceTest values ('TestDiff0PositifMoins', 0);
  commit;
  EXCEPTION
    WHEN CHECK_CONSTRAINT_VIOLATED THEN
      rollback;
      insert into TraceTest values ('TestDiff0PositifMoins', 1);
      commit;
end;
/
begin
  TestDiff0PositifMoins;
end;
/
commit;

-----------------------------------------------------------------------------------------------------------------------
----------------------------------------- TESTS CONTRAINTES NON STRUCTURELLES -----------------------------------------
-----------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------- VerificationDateExp
-- DébutExp <= FinExp

-------------------------------------------------------------------------------------- Test positif

create or replace procedure testP_VerificationDateExp as
    check_constraint_violated exception;
    pragma exception_init(check_constraint_violated, -20001);
begin
  commit;
  insert into RESULTAT values (1,1,'10-OCT-20');
  insert into REACTIF values (1,55,'reactif');
  insert into TYPERELEVE values (1,1,'Colorimétrique');
  insert into EXPERIENCE values (
    1,1,2,1,5,1,
    '10-SEP-20','10-OCT-20', -- Insertion DébutExp < FinExp
    null,2,'09-SEP-20',2,3,'technicien','chercheur',3,6,2,null,
    (select IDRELEVE from TYPERELEVE where NOM_RELEVE ='Colorimétrique'),
    (select IDRESULTAT from RESULTAT where DATETRANSMISSION ='10-OCT-20')
  );
  rollback;
  insert into TraceTest values ('testP_VerificationDateExp',1);
  commit;
  exception
    when check_constraint_violated then
      rollback;
      insert into TraceTest values ('testP_VerificationDateExp',0);
      commit;
end;
/
begin
  testP_VerificationDateExp;
end;
/
commit;

-------------------------------------------------------------------------------------- Test négatif

create or replace procedure testN_VerificationDateExp as
    check_constraint_violated exception;
    pragma exception_init(check_constraint_violated, -20001);
begin
  commit;
  insert into RESULTAT values (1,1,'10-OCT-20');
  insert into REACTIF values (1,55,'reactif');
  insert into TYPERELEVE values (1,1,'Colorimétrique');
  insert into EXPERIENCE values (
    1,1,2,1,5,1,
    '10-OCT-20','10-SEP-20', -- Insertion DébutExp < FinExp
    null,2,'09-SEP-20',2,3,'technicien','chercheur',3,6,2,null,
    (select IDRELEVE from TYPERELEVE where NOM_RELEVE ='Colorimétrique'),
    (select IDRESULTAT from RESULTAT where DATETRANSMISSION ='10-OCT-20')
  );
  rollback;
  insert into TraceTest values ('testN_VerificationDateExp',0);
  commit;
  exception
    when check_constraint_violated then
      rollback;
      insert into TraceTest values ('testN_VerificationDateExp',1);
      commit;
end;
/
begin
  testN_VerificationDateExp;
end;
/
commit;

----------------------------------------------------------------------------------------------- VerificationDateDemande
-- DateChercheur <= DébutExp

-------------------------------------------------------------------------------------- Test positif

create or replace procedure testP_VerificationDateDemande as
    check_constraint_violated exception;
    pragma exception_init(check_constraint_violated, -20002);
begin
  commit;
  insert into RESULTAT values (1,1,'10-OCT-20');
  insert into REACTIF values (1,55,'reactif');
  insert into TYPERELEVE values (1,1,'Colorimétrique');
  insert into EXPERIENCE values (
    1,1,2,1,5,1,
    '10-SEP-20', -- Insertion DébutExp
    '10-OCT-20',2,4,
    '09-SEP-20', -- Insertion DateChercheur
    2,3,'technicien','chercheur',3,6,2,null,
    (select IDRELEVE from TYPERELEVE where NOM_RELEVE ='Colorimétrique'),
    (select IDRESULTAT from RESULTAT where DATETRANSMISSION ='10-OCT-20')
  );
  rollback;
  insert into TraceTest values ('testP_VerificationDateDemande',1);
  commit;
  exception
    when check_constraint_violated then
      rollback;
      insert into TraceTest values ('testP_VerificationDateDemande',0);
      commit;
end;
/
begin
  testP_VerificationDateDemande;
end;
/
commit;

-------------------------------------------------------------------------------------- Test négatif

create or replace procedure testN_VerificationDateDemande as
  check_constraint_violated exception;
  pragma exception_init(check_constraint_violated, -20002);
begin
  commit;
  insert into RESULTAT values (1,1,'10-OCT-20');
  insert into REACTIF values (1,55,'reactif');
  insert into TYPERELEVE values (1,1,'Colorimétrique');
  insert into EXPERIENCE values (
    1,1,2,1,5,1,
    '10-SEP-20', -- Insertion DébutExp
    '10-OCT-20',2,4,
    '12-SEP-20', -- Insertion DateChercheur
    2,3,'technicien','chercheur',3,6,2,null,
    (select IDRELEVE from TYPERELEVE where NOM_RELEVE ='Colorimétrique'),
    (select IDRESULTAT from RESULTAT where DATETRANSMISSION ='10-OCT-20')
  );
  rollback;
  insert into TraceTest values ('testN_VerificationDateDemande',0);
  commit;
  exception
    when check_constraint_violated then
      rollback;
      insert into TraceTest values ('testN_VerificationDateDemande',1);
      commit; 
end;
/
begin
  testN_VerificationDateDemande;
end;
/
commit;

----------------------------------------------------------------------------------------- VerificationNiveauAcceptation
-- Les niveaux d'acceptation a1 et a2 sont tels que a1 <= a2

-------------------------------------------------------------------------------------- Test positif

create or replace procedure testP_VerificationNiveauAcceptation as
    check_constraint_violated exception;
    pragma exception_init(check_constraint_violated, -20003);
begin
  commit;
  insert into RESULTAT values (1,1,'10-OCT-20');
  insert into REACTIF values (1,55,'reactif');
  insert into TYPERELEVE values (1,1,'Colorimétrique');
  insert into EXPERIENCE values (
    1,
    1,2, -- Insertion valide a1 < a2
    1,5,1,'10-SEP-20','10-OCT-20',null,2,'09-SEP-20',2,3,'technicien','chercheur',3,6,2,null,
    (select IDRELEVE from TYPERELEVE where NOM_RELEVE ='Colorimétrique'),
    (select IDRESULTAT from RESULTAT where DATETRANSMISSION ='10-OCT-20')
  );
  rollback;
  insert into TraceTest values ('testP_VerificationNiveauAcceptation',1);
  commit;
  exception
    when check_constraint_violated then
      rollback;
      insert into TraceTest values ('testP_VerificationNiveauAcceptation',0);
      commit;
end;
/
begin
  testP_VerificationNiveauAcceptation;
end;
/
commit;

-------------------------------------------------------------------------------------- Test négatif

create or replace procedure testN_VerificationNiveauAcceptation as
    check_constraint_violated exception;
    pragma exception_init(check_constraint_violated, -20003);
begin
  commit;
  insert into RESULTAT values (1,1,'10-OCT-20');
  insert into REACTIF values (1,55,'reactif');
  insert into TYPERELEVE values (1,1,'Colorimétrique');
  insert into EXPERIENCE values (
    1,
    3,2, -- Insertion invalide a1 > a2
    1,5,1,'10-SEP-20','10-OCT-20',null,2,'09-SEP-20',2,3,'technicien','chercheur',3,6,2,null,
    (select IDRELEVE from TYPERELEVE where NOM_RELEVE ='Colorimétrique'),
    (select IDRESULTAT from RESULTAT where DATETRANSMISSION ='10-OCT-20')
  );
  rollback;
  insert into TraceTest values ('testN_VerificationNiveauAcceptation',0);
  commit;
  exception
    when check_constraint_violated then
      rollback;
      insert into TraceTest values ('testN_VerificationNiveauAcceptation',1);
      commit;
end;
/
begin
  testN_VerificationNiveauAcceptation;
end;
/
commit;

---------------------------------------------------------------------------------------------------- IntégrationReactif
-- Eviter les redondances de réactifs : 
-- Si le nom du réactif est déjà dans la BDD, il n'est pas à nouveau inséré
-- (ne pas tenir compte de la casse, ni des accents)

-------------------------------------------------------------------------------------- Test positif

create or replace procedure TestP_IntégrationReactif as
  CHECK_CONSTRAINT_VIOLATED EXCEPTION;
  pragma exception_init(check_constraint_violated, -20004) ;  
begin
  commit;
  insert into REACTIF values (1,10,'Reactif1');
  insert into REACTIF values (2,15,'Reactif2');
  rollback;
  insert into TraceTest values ('TestP_IntégrationReactif',1);
  commit;
  exception
    when check_constraint_violated then
      rollback;
      insert into TraceTest values ('TestP_IntégrationReactif',0);
      commit; 
end;
/
begin
  TestP_IntégrationReactif;
end;
/
commit;

-------------------------------------------------------------------------------------- Test négatif

create or replace procedure TestN_IntégrationReactif as
  CHECK_CONSTRAINT_VIOLATED EXCEPTION;
  pragma exception_init(check_constraint_violated, -20004) ;
begin
  commit;
  insert into REACTIF values (1,10,'Reactif1');
  insert into REACTIF values (2,15,'Reactif1');
  rollback;
  insert into TraceTest values ('TestN_IntégrationReactif',0);
  commit;
  exception
    when check_constraint_violated then
      rollback;
      insert into TraceTest values ('TestN_IntégrationReactif',1);
      commit; 
end;
/
begin
  TestN_IntégrationReactif;
end;
/
commit;

------------------------------------------------------------------------------------------------- VerificationNomRelevé
-- Nom_Relevé doit contenir "Colorimétrique" ou "Opacimétrique" exclusivement

--------------------------------------------------------------------- Test positif "Colorimétrique"

create or replace procedure TestP_VerificationNomReleve1 as
  check_constraint_violated exception;
  pragma exception_init(check_constraint_violated, -20005);
begin
  commit;
  insert into REACTIF values (1,25,'ReactifNumero1');
  insert into TYPERELEVE values (1,1,'Colorimétrique'); -- Nom_Relevé valide
  rollback;
  insert into TraceTest values ('TestP_VerificationNomReleve1',1);
  commit;
  exception
    when check_constraint_violated then
      rollback;
      insert into TraceTest values ('TestP_VerificationNomReleve1',0);
      commit;
end;
/
begin
  TestP_VerificationNomReleve1;
end;
/
commit;

-------------------------------------------------------------------- Test positif 2 "opacimetrique"

create or replace procedure TestP_VerificationNomReleve2 as
  check_constraint_violated exception;
  pragma exception_init(check_constraint_violated, -20005);
begin
  commit;
  insert into REACTIF values (1,25,'ReactifNumero1');
  insert into TYPERELEVE values (1,1,'Opacimétrique'); -- Nom_Relevé valide
  rollback;
  insert into TraceTest values ('TestP_VerificationNomReleve2',1);
  commit;
  exception
    when check_constraint_violated then
      rollback;
      insert into TraceTest values ('TestP_VerificationNomReleve2',0);
      commit;
end;
/
begin
  TestP_VerificationNomReleve2;
end;
/
commit;

-------------------------------------------------------------------------------------- Test négatif

create or replace procedure TestN_VerificationNomReleve as
  check_constraint_violated exception;
  pragma exception_init(check_constraint_violated, -20005);
begin
  commit;
  insert into REACTIF values (1,25,'ReactifNumero1');
  insert into TYPERELEVE values (1,1,'releveNonPrevu'); -- Nom_Relevé invalide
  rollback;
  insert into TraceTest values ('TestN_VerificationNomReleve',0);
  commit;
  exception
    when check_constraint_violated then
      rollback;
      insert into TraceTest values ('TestN_VerificationNomReleve',1);
      commit;
end;
/
begin
  TestN_VerificationNomReleve;
end;
/
commit;

------------------------------------------------------------------------------------------- VerificationDivisionEntiere
-- Durée et fObservation sont tels que d/f donne un résultat entier

-------------------------------------------------------------------------------------- Test positif

create or replace procedure TestP_VerificationDivisionEntiere as
    check_constraint_violated exception;
    pragma exception_init(check_constraint_violated, -20006);
begin
  commit;
  insert into RESULTAT values (1,1,'10-OCT-20');
  insert into REACTIF values (1,55,'ReactifNumero1');
  insert into TYPERELEVE values (1,1,'Colorimétrique');
  insert into EXPERIENCE values (
    1,1,2,1,5,1,'10-SEP-20','10-OCT-20',
    2,4, -- Insertion Durée et fObservation valides (4/2=2)
    '09-SEP-20',2,3,'technicien','chercheur',3,6,2,null,
    (select IDRELEVE from TYPERELEVE where NOM_RELEVE ='Colorimétrique'),
    (select IDRESULTAT from RESULTAT where DATETRANSMISSION ='10-OCT-20')
  );
  rollback;
  insert into TraceTest values ('TestP_VerificationDivisionEntiere',1);
  commit;
  exception
    when check_constraint_violated then
      rollback;
      insert into TraceTest values ('TestP_VerificationDivisionEntiere',0);
      commit;
end;
/
begin
  TestP_VerificationDivisionEntiere;
end;
/
commit;

-------------------------------------------------------------------------------------- Test négatif

create or replace procedure TestN_VerificationDivisionEntiere as
    check_constraint_violated exception;
    pragma exception_init(check_constraint_violated, -20006);
begin
  commit;
  insert into RESULTAT values (1,1,'10-OCT-20');
  insert into REACTIF values (1,55,'ReactifNumero1');
  insert into TYPERELEVE values (1,1,'Colorimétrique');
  insert into EXPERIENCE values (
    1,1,2,1,5,1,'10-SEP-20','10-OCT-20',
    2,3, -- Insertion Durée et fObservation valides (3/2=1,5)
    '09-SEP-20',2,3,'technicien','chercheur',3,6,2,null,
    (select IDRELEVE from TYPERELEVE where NOM_RELEVE ='Colorimétrique'),
    (select IDRESULTAT from RESULTAT where DATETRANSMISSION ='10-OCT-20')
  );
  rollback;
  insert into TraceTest values ('TestN_VerificationDivisionEntiere',0);
  commit;
  exception
    when check_constraint_violated then
      rollback;
      insert into TraceTest values ('TestN_VerificationDivisionEntiere',1);
      commit;
end;
/
begin
  TestN_VerificationDivisionEntiere;
end;
/
commit;

-----------------------------------------------------------------------------------------------------------------------
------------------------------------------ TESTS CONTRAINTES AUTOMATISATIONS ------------------------------------------
-----------------------------------------------------------------------------------------------------------------------















select * from TraceTest;
commit;