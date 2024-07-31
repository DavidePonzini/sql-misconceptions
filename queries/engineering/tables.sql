CREATE TABLE Categoria (
    idCat SERIAL PRIMARY KEY,
    nome VARCHAR(255) NOT NULL
);

CREATE TABLE Prodotto (
    idProd SERIAL PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    fornitore VARCHAR(255),
    idCat INT,
    prezzo DECIMAL(10, 2),
    FOREIGN KEY (idCat) REFERENCES Categoria(idCat)
);

CREATE TABLE Cliente (
    idClient SERIAL PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    indirizzo VARCHAR(255),
    città VARCHAR(255),
    nazione VARCHAR(255)
);

CREATE TABLE Ordine (
    idOrd SERIAL PRIMARY KEY,
    idClient INT,
    data DATE,
    FOREIGN KEY (idClient) REFERENCES Cliente(idClient)
);

CREATE TABLE DettaglioOrdine (
    idOrd INT,
    idProd INT,
    quantità INT,
    PRIMARY KEY (idOrd, idProd),
    FOREIGN KEY (idOrd) REFERENCES Ordine(idOrd),
    FOREIGN KEY (idProd) REFERENCES Prodotto(idProd)
);
