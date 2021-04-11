-- Enola-ROUDAUT   Florimel-FLOTTE   Salomé-REBOURS

alter table EST_ATTACHE
   drop constraint FK_EST_ATTA_EST_ATTAC_EXPERIEN;

alter table EST_ATTACHE
   drop constraint FK_EST_ATTA_EST_ATTAC_FACTURE;

alter table EXPERIENCE
   drop constraint FK_EXPERIEN_EST_RELEV_TYPERELE;

alter table EXPERIENCE
   drop constraint FK_EXPERIEN_EST_REPRO_EXPERIEN;

alter table EXPERIENCE
   drop constraint FK_EXPERIEN_RESULTE_RESULTAT;

alter table GROUPE
   drop constraint FK_GROUPE_COMPOSE_PLAQUE;

alter table GROUPE
   drop constraint FK_GROUPE_REMPLIE_SOLUTION;

alter table GROUPE
   drop constraint FK_GROUPE_SUBIT_EXPERIEN;

alter table LOTPLAQUE
   drop constraint FK_LOTPLAQU_DEFINI_TYPEPLAQ;

alter table PHOTO
   drop constraint FK_PHOTO_PHOTOGRAP_PLAQUE;

alter table PHOTO
   drop constraint FK_PHOTO_VIENT_DE_PHOTOMET;

alter table PLAQUE
   drop constraint FK_PLAQUE_CONTIENT_LOTPLAQU;

alter table SLOT
   drop constraint FK_SLOT_CORRESPON_GROUPE;

alter table TABLERESULTAT
   drop constraint FK_TABLERES_DETERMINE_PHOTO;

alter table TABLERESULTAT
   drop constraint FK_TABLERES_POSSEDE_SLOT;

alter table TYPERELEVE
   drop constraint FK_TYPERELE_UTILISE_REACTIF;

drop index EST_ATTACHE2_FK;

drop index EST_ATTACHE_FK;

drop table EST_ATTACHE cascade constraints;

drop index EST_RELEVE_FK;

drop index RESULTE_FK;

drop index EST_REPROGRAMME_DE_FK;

drop table EXPERIENCE cascade constraints;

drop table FACTURE cascade constraints;

drop index SUBIT_FK;

drop index REMPLIE_FK;

drop index COMPOSE_FK;

drop table GROUPE cascade constraints;

drop index DEFINI_FK;

drop table LOTPLAQUE cascade constraints;

drop index VIENT_DE_FK;

drop index PHOTOGRAPHIE_FK;

drop table PHOTO cascade constraints;

drop table PHOTOMETRE cascade constraints;

drop index CONTIENT_FK;

drop table PLAQUE cascade constraints;

drop table REACTIF cascade constraints;

drop table RESULTAT cascade constraints;

drop index CORRESPOND_FK;

drop table SLOT cascade constraints;

drop table SOLUTION cascade constraints;

drop index DETERMINE_FK;

drop index POSSEDE_FK;

drop table TABLERESULTAT cascade constraints;

drop table TYPEPLAQUE cascade constraints;

drop index UTILISE_FK;

drop table TYPERELEVE cascade constraints;

/*==============================================================*/
/* Table : EST_ATTACHE                                          */
/*==============================================================*/
create table EST_ATTACHE (
   IDEXPERIENCE         NUMBER                not null,
   IDFACTURE            NUMBER                not null,
   COUT                 NUMBER,
   constraint PK_EST_ATTACHE primary key (IDEXPERIENCE, IDFACTURE)
);

/*==============================================================*/
/* Index : EST_ATTACHE_FK                                       */
/*==============================================================*/
create index EST_ATTACHE_FK on EST_ATTACHE (
   IDEXPERIENCE ASC
);

/*==============================================================*/
/* Index : EST_ATTACHE2_FK                                      */
/*==============================================================*/
create index EST_ATTACHE2_FK on EST_ATTACHE (
   IDFACTURE ASC
);

/*==============================================================*/
/* Table : EXPERIENCE                                           */
/*==============================================================*/
create table EXPERIENCE (
   IDEXPERIENCE         NUMBER                not null,
   A1                   NUMBER                not null
      constraint CKC_A1_EXPERIEN check (A1 >= 0),
   A2                   NUMBER                not null
      constraint CKC_A2_EXPERIEN check (A2 >= 0),
   A3                   NUMBER              
      constraint CKC_A3_EXPERIEN check (A3 is null or (A3 between 0 and 1)),
   NBTOTEXP             NUMBER                not null
      constraint CKC_NBTOTEXP_EXPERIEN check (NBTOTEXP >= 0),
   EXPDOUBLE            SMALLINT              not null,
   DEBUTEXP             DATE                  not null,
   FINEXP               DATE                  not null,
   FOBSERVATION         NUMBER              
      constraint CKC_FOBSERVATION_EXPERIEN check (FOBSERVATION is null or (FOBSERVATION >= 1)),
   DUREE                NUMBER                not null
      constraint CKC_DUREE_EXPERIEN check (DUREE >= 1),
   DATECHERCHEUR        DATE                  not null,
   NOMBRERELEVE         NUMBER                not null
      constraint CKC_NOMBRERELEVE_EXPERIEN check (NOMBRERELEVE >= 0),
   INDICEPRIORITE       NUMBER                not null
      constraint CKC_INDICEPRIORITE_EXPERIEN check (INDICEPRIORITE between 1 and 3 and INDICEPRIORITE in (1,2,3)),
   TECHNICIENREALISE    VARCHAR2(255)         not null,
   CHERCHEURDEMANDE     VARCHAR2(255)         not null,
   NBSLOTPOURGROUPE     NUMBER                not null
      constraint CKC_NBSLOTPOURGROUPE_EXPERIEN check (NBSLOTPOURGROUPE between 1 and 384),
   NBMAXREPROGRAMMATION NUMBER                not null
      constraint CKC_NBMAXREPROGRAMMAT_EXPERIEN check (NBMAXREPROGRAMMATION >= 0),
   COEFFSURCOUT         NUMBER                not null
      constraint CKC_COEFFSURCOUT_EXPERIEN check (COEFFSURCOUT >= 0),
   EXP_IDEXPERIENCE     NUMBER,
   IDRELEVE             NUMBER                not null,
   IDRESULTAT           NUMBER                not null,
   constraint PK_EXPERIENCE primary key (IDEXPERIENCE)
);

/*==============================================================*/
/* Index : EST_REPROGRAMME_DE_FK                                */
/*==============================================================*/
create index EST_REPROGRAMME_DE_FK on EXPERIENCE (
   EXP_IDEXPERIENCE ASC
);

/*==============================================================*/
/* Index : RESULTE_FK                                           */
/*==============================================================*/
create index RESULTE_FK on EXPERIENCE (
   IDRESULTAT ASC
);

/*==============================================================*/
/* Index : EST_RELEVE_FK                                        */
/*==============================================================*/
create index EST_RELEVE_FK on EXPERIENCE (
   IDRELEVE ASC
);

/*==============================================================*/
/* Table : FACTURE                                              */
/*==============================================================*/
create table FACTURE (
   IDFACTURE            NUMBER                not null,
   DATEFACTURE          DATE                  not null,
   constraint PK_FACTURE primary key (IDFACTURE)
);

/*==============================================================*/
/* Table : GROUPE                                               */
/*==============================================================*/
create table GROUPE (
   IDGROUPE             NUMBER                not null,
   IDPLAQUE             NUMBER                not null,
   IDSOLUTION           NUMBER                not null,
   IDEXPERIENCE         NUMBER                not null,
   ACCEPTEGROUPE        SMALLINT              not null,
   constraint PK_GROUPE primary key (IDGROUPE)
);

/*==============================================================*/
/* Index : COMPOSE_FK                                           */
/*==============================================================*/
create index COMPOSE_FK on GROUPE (
   IDPLAQUE ASC
);

/*==============================================================*/
/* Index : REMPLIE_FK                                           */
/*==============================================================*/
create index REMPLIE_FK on GROUPE (
   IDSOLUTION ASC
);

/*==============================================================*/
/* Index : SUBIT_FK                                             */
/*==============================================================*/
create index SUBIT_FK on GROUPE (
   IDEXPERIENCE ASC
);

/*==============================================================*/
/* Table : LOTPLAQUE                                            */
/*==============================================================*/
create table LOTPLAQUE (
   IDLOTPLAQUE          NUMBER                not null,
   IDTYPEPLAQUE         NUMBER                not null,
   DATELIVRAISON        DATE                  not null,
   VENDEUR              VARCHAR2(255)         not null,
   MAGASINIER           VARCHAR2(255)         not null,
   FABRIQUANT           VARCHAR2(255)         not null,
   constraint PK_LOTPLAQUE primary key (IDLOTPLAQUE)
);

/*==============================================================*/
/* Index : DEFINI_FK                                            */
/*==============================================================*/
create index DEFINI_FK on LOTPLAQUE (
   IDTYPEPLAQUE ASC
);

/*==============================================================*/
/* Table : PHOTO                                                */
/*==============================================================*/
create table PHOTO (
   IDPHOTO              NUMBER                not null,
   IDPLAQUE             NUMBER                not null,
   IDPHOTOMETRE         NUMBER                not null,
   constraint PK_PHOTO primary key (IDPHOTO)
);

/*==============================================================*/
/* Index : PHOTOGRAPHIE_FK                                      */
/*==============================================================*/
create index PHOTOGRAPHIE_FK on PHOTO (
   IDPLAQUE ASC
);

/*==============================================================*/
/* Index : VIENT_DE_FK                                          */
/*==============================================================*/
create index VIENT_DE_FK on PHOTO (
   IDPHOTOMETRE ASC
);

/*==============================================================*/
/* Table : PHOTOMETRE                                           */
/*==============================================================*/
create table PHOTOMETRE (
   IDPHOTOMETRE         NUMBER                not null,
   DISPONIBLE           SMALLINT              not null,
   COUTPHOTOMETRE       NUMBER                not null,
   constraint PK_PHOTOMETRE primary key (IDPHOTOMETRE)
);

/*==============================================================*/
/* Table : PLAQUE                                               */
/*==============================================================*/
create table PLAQUE (
   IDPLAQUE             NUMBER                not null,
   IDLOTPLAQUE          NUMBER                not null,
   ACCEPTEPLAQUE        SMALLINT              not null,
   constraint PK_PLAQUE primary key (IDPLAQUE)
);

/*==============================================================*/
/* Index : CONTIENT_FK                                          */
/*==============================================================*/
create index CONTIENT_FK on PLAQUE (
   IDLOTPLAQUE ASC
);

/*==============================================================*/
/* Table : REACTIF                                              */
/*==============================================================*/
create table REACTIF (
   IDREACTIF            NUMBER                not null,
   PRIXREACTIF          NUMBER                not null,
   NOMREACTIF           VARCHAR2(255),
   constraint PK_REACTIF primary key (IDREACTIF)
);

/*==============================================================*/
/* Table : RESULTAT                                             */
/*==============================================================*/
create table RESULTAT (
   IDRESULTAT           NUMBER                not null,
   ACCEPTERESULTAT      SMALLINT              not null,
   DATETRANSMISSION     DATE                  not null,
   constraint PK_RESULTAT primary key (IDRESULTAT)
);

/*==============================================================*/
/* Table : SLOT                                                 */
/*==============================================================*/
create table SLOT (
   IDSLOT               NUMBER                not null,
   IDGROUPE             NUMBER                not null,
   NUMEROSLOT           NUMBER                not null
      constraint CKC_NUMEROSLOT_SLOT check (NUMEROSLOT between 1 and 384),
   constraint PK_SLOT primary key (IDSLOT)
);

/*==============================================================*/
/* Index : CORRESPOND_FK                                        */
/*==============================================================*/
create index CORRESPOND_FK on SLOT (
   IDGROUPE ASC
);

/*==============================================================*/
/* Table : SOLUTION                                             */
/*==============================================================*/
create table SOLUTION (
   IDSOLUTION           NUMBER                not null,
   QN                   NUMBER              
      constraint CKC_QN_SOLUTION check (QN is null or (QN >= 1)),
   QA                   NUMBER                not null
      constraint CKC_QA_SOLUTION check (QA >= 0),
   QC                   NUMBER              
      constraint CKC_QC_SOLUTION check (QC is null or (QC >= 1)),
   constraint PK_SOLUTION primary key (IDSOLUTION)
);

/*==============================================================*/
/* Table : TABLERESULTAT                                        */
/*==============================================================*/
create table TABLERESULTAT (
   IDTABLERESULTAT      NUMBER                not null,
   IDSLOT               NUMBER                not null,
   IDPHOTO              NUMBER                not null,
   Y                    NUMBER                not null,
   X                    NUMBER                not null,
   RD                   NUMBER                not null
      constraint CKC_RD_TABLERES check (RD between 0 and 255),
   RM                   NUMBER                not null
      constraint CKC_RM_TABLERES check (RM between 0 and 255),
   VD                   NUMBER                not null
      constraint CKC_VD_TABLERES check (VD between 0 and 255),
   VM                   NUMBER                not null
      constraint CKC_VM_TABLERES check (VM between 0 and 255),
   TD                   NUMBER                not null
      constraint CKC_TD_TABLERES check (TD between 0 and 255),
   TM                   NUMBER                not null
      constraint CKC_TM_TABLERES check (TM between 0 and 255),
   BD                   NUMBER                not null
      constraint CKC_BD_TABLERES check (BD between 0 and 255),
   BM                   NUMBER                not null
      constraint CKC_BM_TABLERES check (BM between 0 and 255),
   constraint PK_TABLERESULTAT primary key (IDTABLERESULTAT)
);

/*==============================================================*/
/* Index : POSSEDE_FK                                           */
/*==============================================================*/
create index POSSEDE_FK on TABLERESULTAT (
   IDSLOT ASC
);

/*==============================================================*/
/* Index : DETERMINE_FK                                         */
/*==============================================================*/
create index DETERMINE_FK on TABLERESULTAT (
   IDPHOTO ASC
);

/*==============================================================*/
/* Table : TYPEPLAQUE                                           */
/*==============================================================*/
create table TYPEPLAQUE (
   IDTYPEPLAQUE         NUMBER                not null,
   STOCK                NUMBER                not null,
   constraint PK_TYPEPLAQUE primary key (IDTYPEPLAQUE)
);

/*==============================================================*/
/* Table : TYPERELEVE                                           */
/*==============================================================*/
create table TYPERELEVE (
   IDRELEVE             NUMBER                not null,
   IDREACTIF            NUMBER                not null,
   NOM_RELEVE           VARCHAR2(255),
   constraint PK_TYPERELEVE primary key (IDRELEVE)
);

/*==============================================================*/
/* Index : UTILISE_FK                                           */
/*==============================================================*/
create index UTILISE_FK on TYPERELEVE (
   IDREACTIF ASC
);

alter table EST_ATTACHE
   add constraint FK_EST_ATTA_EST_ATTAC_EXPERIEN foreign key (IDEXPERIENCE)
      references EXPERIENCE (IDEXPERIENCE);

alter table EST_ATTACHE
   add constraint FK_EST_ATTA_EST_ATTAC_FACTURE foreign key (IDFACTURE)
      references FACTURE (IDFACTURE);

alter table EXPERIENCE
   add constraint FK_EXPERIEN_EST_RELEV_TYPERELE foreign key (IDRELEVE)
      references TYPERELEVE (IDRELEVE);

alter table EXPERIENCE
   add constraint FK_EXPERIEN_EST_REPRO_EXPERIEN foreign key (EXP_IDEXPERIENCE)
      references EXPERIENCE (IDEXPERIENCE);

alter table EXPERIENCE
   add constraint FK_EXPERIEN_RESULTE_RESULTAT foreign key (IDRESULTAT)
      references RESULTAT (IDRESULTAT);

alter table GROUPE
   add constraint FK_GROUPE_COMPOSE_PLAQUE foreign key (IDPLAQUE)
      references PLAQUE (IDPLAQUE);

alter table GROUPE
   add constraint FK_GROUPE_REMPLIE_SOLUTION foreign key (IDSOLUTION)
      references SOLUTION (IDSOLUTION);

alter table GROUPE
   add constraint FK_GROUPE_SUBIT_EXPERIEN foreign key (IDEXPERIENCE)
      references EXPERIENCE (IDEXPERIENCE);

alter table LOTPLAQUE
   add constraint FK_LOTPLAQU_DEFINI_TYPEPLAQ foreign key (IDTYPEPLAQUE)
      references TYPEPLAQUE (IDTYPEPLAQUE);

alter table PHOTO
   add constraint FK_PHOTO_PHOTOGRAP_PLAQUE foreign key (IDPLAQUE)
      references PLAQUE (IDPLAQUE);

alter table PHOTO
   add constraint FK_PHOTO_VIENT_DE_PHOTOMET foreign key (IDPHOTOMETRE)
      references PHOTOMETRE (IDPHOTOMETRE);

alter table PLAQUE
   add constraint FK_PLAQUE_CONTIENT_LOTPLAQU foreign key (IDLOTPLAQUE)
      references LOTPLAQUE (IDLOTPLAQUE);

alter table SLOT
   add constraint FK_SLOT_CORRESPON_GROUPE foreign key (IDGROUPE)
      references GROUPE (IDGROUPE);

alter table TABLERESULTAT
   add constraint FK_TABLERES_DETERMINE_PHOTO foreign key (IDPHOTO)
      references PHOTO (IDPHOTO);

alter table TABLERESULTAT
   add constraint FK_TABLERES_POSSEDE_SLOT foreign key (IDSLOT)
      references SLOT (IDSLOT);

alter table TYPERELEVE
   add constraint FK_TYPERELE_UTILISE_REACTIF foreign key (IDREACTIF)
      references REACTIF (IDREACTIF);

----------------------------------------------------------------------------------------- Automatisation clés primaires

-- 1.   TypePlaque
drop sequence S_IdTypePlaque;
create sequence S_IdTypePlaque start with 1 increment by 1;
create or replace trigger T_IdTypePlaque before insert on TypePlaque for each row
begin
  select S_IdTypePlaque.nextval into :new.IdTypePlaque from dual;
end;
/

-- 2.   LotPlaque
drop sequence S_IdLotPlaque;
create sequence S_IdLotPlaque start with 1 increment by 1;
create or replace trigger T_IdLotPlaque before insert on LotPlaque for each row
begin
  select S_IdLotPlaque.nextval into :new.IdLotPlaque from dual;
end;
/

-- 3.   Plaque
drop sequence S_IdPlaque;
create sequence S_IdPlaque start with 1 increment by 1;
create or replace trigger T_IdPlaque before insert on Plaque for each row
begin
  select S_IdPlaque.nextval into :new.IdPlaque from dual;
end;
/

-- 4.   Photometre
drop sequence S_IdPhotometre;
create sequence S_IdPhotometre start with 1 increment by 1;
create or replace trigger T_IdPhotometre before insert on Photometre for each row
begin
  select S_IdPhotometre.nextval into :new.IdPhotometre from dual;
end;
/

-- 5.   Photo
drop sequence S_IdPhoto;
create sequence S_IdPhoto start with 1 increment by 1;
create or replace trigger T_IdPhoto before insert on Photo for each row
begin
  select S_IdPhoto.nextval into :new.IdPhoto from dual;
end;
/

-- 6.   Reactif
drop sequence S_IdReactif;
create sequence S_IdReactif start with 1 increment by 1;
create or replace trigger T_IdReactif before insert on Reactif for each row
begin
  select S_IdReactif.nextval into :new.IdReactif from dual;
end;
/

-- 7.   TypeReleve
drop sequence S_IdTypeReleve;
create sequence S_IdTypeReleve start with 1 increment by 1;
create or replace trigger T_IdTypeReleve before insert on TypeReleve for each row
begin
  select S_IdTypeReleve.nextval into :new.IdReleve from dual;
end;
/

-- 8.   Resultat
drop sequence S_IdResultat;
create sequence S_IdResultat start with 1 increment by 1;
create or replace trigger T_IdResultat before insert on Resultat for each row
begin
  select S_IdResultat.nextval into :new.IdResultat from dual;
end;
/

-- 9.   Experience
drop sequence S_IdExperience;
create sequence S_IdExperience start with 1 increment by 1;
create or replace trigger T_IdExperience before insert on Experience for each row
begin
  select S_IdExperience.nextval into :new.IdExperience from dual;
end;
/

-- 10.  Facture
drop sequence S_IdFacture;
create sequence S_IdFacture start with 1 increment by 1;
create or replace trigger T_IdFacture before insert on Facture for each row
begin
  select S_IdFacture.nextval into :new.IdFacture from dual;
end;
/

-- 11.  Solution
drop sequence S_IdSolution;
create sequence S_IdSolution start with 1 increment by 1;
create or replace trigger T_IdSolution before insert on Solution for each row
begin
  select S_IdSolution.nextval into :new.IdSolution from dual;
end;
/

-- 12.  Groupe
drop sequence S_IdGroupe;
create sequence S_IdGroupe start with 1 increment by 1;
create or replace trigger T_IdGroupe before insert on Groupe for each row
begin
  select S_IdGroupe.nextval into :new.IdGroupe from dual;
end;
/

-- 13.  Slot
drop sequence S_IdSlot;
create sequence S_IdSlot start with 1 increment by 1;
create or replace trigger T_IdSlot before insert on Slot for each row
begin
  select S_IdSlot.nextval into :new.IdSlot from dual;
end;
/

-- 14.  TableResultat
drop sequence S_IdTableResultat;
create sequence S_IdTableResultat start with 1 increment by 1;
create or replace trigger T_IdTableResultat before insert on TableResultat for each row
begin
  select S_IdTableResultat.nextval into :new.IdTableResultat from dual;
end;
/
