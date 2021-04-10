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
