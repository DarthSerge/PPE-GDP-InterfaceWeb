#------------------------------------------------------------
#        Script MySQL.
#------------------------------------------------------------


CREATE TABLE personnel(
        pers_id       int (11) Auto_increment  NOT NULL ,
        pers_nom      Varchar (50) ,
        pers_prenom   Varchar (50) ,
        pers_email    Varchar (250) ,
        pers_password Varchar (75) ,
        pt_id         Int ,
        lig_id        Int ,
        PRIMARY KEY (pers_id )
)ENGINE=InnoDB;


CREATE TABLE personnel_type(
        pt_id      int (11) Auto_increment  NOT NULL ,
        pt_libelle Varchar (50) ,
        PRIMARY KEY (pt_id )
)ENGINE=InnoDB;


CREATE TABLE Ligue(
        lig_id      int (11) Auto_increment  NOT NULL ,
        lig_libelle Varchar (100) ,
        PRIMARY KEY (lig_id )
)ENGINE=InnoDB;

ALTER TABLE personnel ADD CONSTRAINT FK_personnel_pt_id FOREIGN KEY (pt_id) REFERENCES personnel_type(pt_id);
ALTER TABLE personnel ADD CONSTRAINT FK_personnel_lig_id FOREIGN KEY (lig_id) REFERENCES Ligue(lig_id);
