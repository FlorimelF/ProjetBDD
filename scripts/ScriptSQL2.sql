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