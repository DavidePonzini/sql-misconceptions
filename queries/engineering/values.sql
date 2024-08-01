-- Insert data into Categoria
INSERT INTO Categoria (idCat, nome) VALUES
(1, 'Bevande'),
(2, 'Cibo'),
(3, 'Elettronica');

-- Insert data into Prodotto
INSERT INTO Prodotto (idProd, nome, fornitore, idCat, prezzo) VALUES
(1, 'Coca Cola', 'Coca Cola Company', 1, 1.50),
(2, 'Pepsi', 'PepsiCo', 1, 1.40),
(3, 'Acqua', 'Nestle', 1, 0.80),
(4, 'Pizza', 'Local Pizzeria', 2, 8.50),
(5, 'TV', 'Sony', 3, 499.99);

-- Insert data into Cliente
INSERT INTO Cliente (idClient, nome, indirizzo, città, nazione) VALUES
(1234, 'Mario Rossi', 'Via Roma 1', 'Venezia', 'Italia'),
(5678, 'Luigi Verdi', 'Via Milano 2', 'Brescia', 'Italia'),
(9101, 'Giulia Bianchi', 'Via Napoli 3', 'Roma', 'Italia');

-- Insert data into Ordine
INSERT INTO Ordine (idOrd, idClient, data) VALUES
(1, 1234, '2023-05-21'),
(2, 5678, '2024-06-15'),
(3, 1234, '2024-01-10'),
(4, 9101, '2023-07-22');

-- Insert data into DettaglioOrdine
INSERT INTO DettaglioOrdine (idOrd, idProd, quantità) VALUES
(1, 1, 5),
(1, 2, 3),
(2, 3, 10),
(3, 4, 1),
(4, 5, 2);