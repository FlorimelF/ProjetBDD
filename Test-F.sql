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
            'colorimetrique'
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
--select * from TraceTest;


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

--select * from TraceTest;
commit;

/*==============================================================*/
/* Test pour le trigger VerificationDivisionEntiere             */
/*==============================================================*/

drop table TraceTest;
create table TraceTest (
    nomTest varchar2(100),
    resultat number
);

/*Test positif*/
create or replace procedure TestP_VerificationDivisionEntiere as
    check_constraint_violated exception;
    pragma exception_init(check_constraint_violated, -2290);
begin
    commit;
    -- remplissage des tables pour les clés étrangères
    insert into RESULTAT values
        (
            1,
            1,
            TO_DATE( 'October 10, 2020', 'MONTH DD, YYYY' )
        );
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
            'colorimetrique'
        );
    -- Remplissage de la table d'interet c'est à dire experience :
    insert into EXPERIENCE values
        (
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
            4,
            'technicien',
            'chercheur',
            3,
            1,
            2,
            null,
            (select IDRELEVE from TYPERELEVE where NOM_RELEVE ='colorimetrique'),
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

select * from TraceTest;
commit;

/*Test negatif*/
create or replace procedure TestN_VerificationDivisionEntiere as
    check_constraint_violated exception;
    pragma exception_init(check_constraint_violated, -2290);
begin
    commit;
    -- remplissage des tables pour les clés étrangères
    insert into RESULTAT values
        (
            1,
            1,
            TO_DATE( 'October 10, 2020', 'MONTH DD, YYYY' )
        );
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
            'colorimetrique'
        );
=
    -- Remplissage de la table d'interet c'est à dire experience :
    insert into EXPERIENCE values
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
                2,
                3,
                TO_DATE( 'September 09, 2020', 'MONTH DD, YYYY' ),
                2,
                3,
                'technicien',
                'chercheur',
                3,
                6,
                2,
                null,
                (select IDRELEVE from TYPERELEVE where NOM_RELEVE ='colorimetrique'),
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

select * from TraceTest;
commit;