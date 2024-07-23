set datestyle to "MDY";

CREATE TABLE Professori(
Id decimal(5,0) PRIMARY KEY,
Cognome varchar(30) NOT NULL,
Nome varchar(30) NOT NULL,
Stipendio decimal(8,2) NOT NULL DEFAULT 15000 CHECK (Stipendio >=0)
);

CREATE TABLE CorsiDiLaurea(
id decimal(3,0) PRIMARY KEY,
Facolta varchar(50) NOT NULL,
Denominazione varchar(50) NOT NULL,
Attivazione char(9) NOT NULL,
UNIQUE(Facolta, Denominazione)
);

CREATE TABLE Corsi(
Id char(10) PRIMARY KEY,
CorsoDiLaurea decimal(3) NOT NULL REFERENCES CorsiDiLaurea (id) ON UPDATE CASCADE,
Denominazione varchar(50) NOT NULL,
Professore decimal(5,0)  REFERENCES Professori (id) ON DELETE NO ACTION ON UPDATE CASCADE,
Attivato boolean NOT NULL DEFAULT FALSE,
UNIQUE (CorsoDiLaurea, Denominazione)
);

CREATE TABLE Studenti(
Matricola varchar(10) PRIMARY KEY,
Cognome varchar(30) NOT NULL,
Nome varchar(30) NOT NULL,
Residenza varchar(30) NOT NULL,
DataNascita date NOT NULL,
LuogoNascita varchar(30) NOT NULL,
CorsoDiLaurea decimal(3,0)  REFERENCES CorsiDiLaurea (id) ON UPDATE CASCADE NOT NULL,
Iscrizione integer NOT NULL,
Relatore decimal(5,0)  REFERENCES Professori (id) ON UPDATE CASCADE,
Laurea date,
UNIQUE(Cognome,Nome,DataNascita, LuogoNascita, CORSODILAUREA)
);

CREATE TABLE Esami(
Studente varchar(10) REFERENCES Studenti 
(matricola) ON UPDATE CASCADE, /* aggiunto update*/
Corso char(10)  REFERENCES Corsi (id) ON UPDATE NO ACTION, /* aggiunto update*/
Data date,
Voto decimal(2,0) NOT NULL check (Voto  between 1 and 33),
PRIMARY KEY(Studente,Corso,Data)
);

CREATE TABLE PianiDiStudio(
Studente varchar(10) REFERENCES Studenti (matricola) ON UPDATE CASCADE, /* aggiunto update*/
AnnoAccademico integer not null,
Anno decimal(1,0) check (Anno  between 1 and 6),
PRIMARY KEY(Studente,AnnoAccademico,Anno)
);
