/** T_IntégrationReactif	
Reactif (NomReactif)	
Si le nom du réactif utilisé existe déjà dans la BDD, 
il n'est pas à nouveau inséré pour éviter les redondances 
(ne pas tenir compte de la casse, ni des accents) 
*/ 
drop table TraceTest;
create table TraceTest (nomTest varchar2(100), resultat number(1) check(resultat in (0,1)));

/**
  Test positif pour 
 */
create or replace procedure Test_PlacementGroupe as
    CHECK_CONSTRAINT_VIOLATED EXCEPTION;
    pragma exception_init(check_constraint_violated, -20001) ;

begin
commit;
  insert into REACTIF values (
    1,
    10,
    'Reactif1'
  );
  insert into REACTIF values (
    2,
    15,
    'Reactif2'
  );
  rollback;
  insert into TraceTest values ('Test_PlacementGroupe',1);
  commit;
  exception
    when check_constraint_violated then
      rollback;
      insert into TraceTest values ('Test_PlacementGroupe',0);
      commit; 
end;
/
begin
  Test_PlacementGroupe;
end;
/
commit;

 /**
  Test negatif pour 
 */
 create or replace procedure Test_PlacementGroupeN as
    CHECK_CONSTRAINT_VIOLATED EXCEPTION;
    pragma exception_init(check_constraint_violated, -20001) ;

begin
commit;
  insert into REACTIF values (
    1,
    10,
    'Reactif1'
  );
  insert into REACTIF values (
    2,
    15,
    'Reactif1'
  );
  rollback;
  insert into TraceTest values ('Test_PlacementGroupeN',0);
  commit;
  exception
    when check_constraint_violated then
      rollback;
      insert into TraceTest values ('Test_PlacementGroupeN',1);
      commit; 
end;
/
begin
  Test_PlacementGroupeN;
end;
/
select * from TraceTest;
commit;

/** AutoCalculCoeffSurcout	Experience (CoeffSurcout)	Un niveau de priorité 
supérieur à 1 a un impact sur le coût de lexpérience :
le prix total d'une expérience e est multiplié par
le coefficient (n + d)/n, où n est le nombre total d'expériences 
non réalisées et arrivées avant e (e comprise), et d est le nombre 
d'expériences doublées par e dans la file d'attente, du fait de sa priorité. **/

drop table TraceTest;
create table TraceTest (nomTest varchar2(100), resultat number(1) check(resultat in (0,1)));
create or replace procedure Test_AutoCalculCoeffSurcout as
    coef NUMBER;
    coef2 NUMBER;
begin
commit;
  insert into RESULTAT values (
    1,
    1,
    TO_DATE( 'October 10, 2020', 'MONTH DD, YYYY' )
  );
  insert into REACTIF values (
    1,
    55,
    'reactif'
  );
  insert into TYPERELEVE values (
    1,
    (select IDREACTIF from REACTIF where NOMREACTIF ='reactif'),
    'releve'
  );
  insert into EXPERIENCE values (
    1,
    1,
    2,
    1,
    5,
    1,
    TO_DATE( 'September 10, 2020', 'MONTH DD, YYYY' ),
    TO_DATE( 'October 10, 2020', 'MONTH DD, YYYY' ),
    2,
    4,
    TO_DATE( 'September 09, 2020', 'MONTH DD, YYYY' ),
    2,
    1, -- indice priorité
    'technicien',
    'chercheur',
    3,
    6,
    1, -- coef
    null,
    (select IDRELEVE from TYPERELEVE where NOM_RELEVE ='releve'),
    (select IDRESULTAT from RESULTAT where DATETRANSMISSION ='10-OCT-20')
  );
    
insert into EXPERIENCE values (
    2,
    1,
    2,
    1,
    5,
    1,
    TO_DATE( 'September 10, 2020', 'MONTH DD, YYYY' ),
    TO_DATE( 'October 10, 2020', 'MONTH DD, YYYY' ),
    2,
    4,
    TO_DATE( 'September 09, 2020', 'MONTH DD, YYYY' ),
    2,
    2, -- indice priorité
    'technicien',
    'chercheur',
    3,
    6,
    0, -- coef
    null,
    (select IDRELEVE from TYPERELEVE where NOM_RELEVE ='releve'),
    (select IDRESULTAT from RESULTAT where DATETRANSMISSION ='10-OCT-20')
  );
  SELECT COEFFSURCOUT into coef FROM EXPERIENCE WHERE IDEXPERIENCE = 1;
  SELECT COEFFSURCOUT into coef2 FROM EXPERIENCE WHERE IDEXPERIENCE = 2;
  if coef=0 and coef2=1.5 then
    rollback;
     insert into TraceTest values ('Test_AutoCalculCoeffSurcout',1);
  else
      rollback;
      insert into TraceTest values ('Test_AutoCalculCoeffSurcout',0);
    end if;
    commit; 
end;
/
begin
  Test_AutoCalculCoeffSurcout;
end;
/
select * from TraceTest;
commit;