-- Table: GIOCATORE
CREATE TABLE GIOCATORE (
    IdG SERIAL PRIMARY KEY,
    Nome VARCHAR(100) NOT NULL,
    Cognome VARCHAR(100) NOT NULL,
    Genere CHAR(1) NOT NULL,
    DataN DATE NOT NULL,
    Nazione VARCHAR(100) NOT NULL
);

CREATE TABLE TORNEO (
    IdT SERIAL PRIMARY KEY,
    NomeT VARCHAR(100) NOT NULL,
    Luogo VARCHAR(100) NOT NULL,
    DataI DATE NOT NULL,
    DataF DATE NOT NULL,
    NumTurni INT NOT NULL,
    Tipo VARCHAR(50) NOT NULL,
    Terreno VARCHAR(50) NOT NULL
);

-- Table: CATEGORIA
CREATE TABLE CATEGORIA (
    IdCat SERIAL PRIMARY KEY,
    NomeCategoria VARCHAR(100) NOT NULL,
    GenereCategoria CHAR(1) NOT NULL
);

-- Table: REGISTRAZIONE
CREATE TABLE REGISTRAZIONE (
    IdT INT REFERENCES TORNEO(IdT) ON DELETE CASCADE,
    IdCat INT REFERENCES CATEGORIA(IdCat) ON DELETE CASCADE,
    NumRegistrazione SERIAL PRIMARY KEY,
    DataRegistrazione DATE NOT NULL,
    TestaDiSerie BOOLEAN NOT NULL,
    UNIQUE (IdT, IdCat, NumRegistrazione)
);

-- Table: GIOCAIN
CREATE TABLE GIOCAIN (
    IdT INT,
    IdCat INT,
    NumRegistrazione INT,
    IdG INT REFERENCES GIOCATORE(IdG) ON DELETE CASCADE,
    PRIMARY KEY (IdT, IdCat, NumRegistrazione, IdG),
    FOREIGN KEY (IdT, IdCat, NumRegistrazione) 
        REFERENCES REGISTRAZIONE(IdT, IdCat, NumRegistrazione) ON DELETE CASCADE
);
