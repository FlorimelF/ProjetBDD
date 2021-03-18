
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
