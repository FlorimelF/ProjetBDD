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
