/*==============================================================*/
/* Test pour le trigger VerificationNomRelevé                   */
/*==============================================================*/

drop table TraceTest;
create table TraceTest (
    nomTest varchar2(100),
    resultat number
);

/* Test Positif */

create or replace procedure TestP_VerificationNomReleve as
    check_constraint_violated exception;
    pragma exception_init(check_constraint_violated, -2290);
begin
    commit;
    insert into REACTIF values
        (
            1,
            25,
            'ReactifNumero1'
        );
    insert into TYPERELEVE values
        (
            1,
            1,
            'colorometrique'
        );
    rollback;
    insert into TraceTest values ('TestP_VerificationNomReleve',1);
    commit;
    exception
        when check_constraint_violated then
            rollback;
            insert into TraceTest values ('TestP_VerificationNomReleve',0);
            commit;
end;
/

begin
TestP_VerificationNomReleve;
end;
/
select * from TraceTest;


/*Test negatif -- cas ou le nom est faux*/
create or replace procedure TestN_VerificationNomReleve as
    check_constraint_violated exception;
    pragma exception_init(check_constraint_violated, -2290);
begin
    commit;
    insert into REACTIF values
        (
            1,
            25,
            'ReactifNumero1'
        );
    insert into TYPERELEVE values
        (
            1,
            1,
            'releveNonPrevu'
        );
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

select * from TraceTest;
commit;