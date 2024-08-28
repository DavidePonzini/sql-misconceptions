INSERT INTO GIOCATORE (Nome, Cognome, Genere, DataN, Nazione)
VALUES
('Marie', 'Dupont', 'f', '1990-05-15', 'Francia'),
('Sophie', 'Rossi', 'f', '1992-08-20', 'Italia'),
('Klara', 'Müller', 'f', '1993-11-30', 'Germania');

INSERT INTO TORNEO (NomeT, Luogo, DataI, DataF, NumTurni, Tipo, Terreno)
VALUES
('US Open', 'New York', '2024-08-26', '2024-09-08', 7, 'Grand Slam', 'Cemento'),
('Australian Open', 'Melbourne', '2024-01-15', '2024-01-28', 7, 'Grand Slam', 'Cemento'),
('Wimbledon', 'London', '2024-06-24', '2024-07-14', 7, 'Grand Slam', 'Erba');

INSERT INTO CATEGORIA (NomeCategoria, GenereCategoria)
VALUES
('singolo', 'f'),
('doppio', 'f');

INSERT INTO REGISTRAZIONE (IdT, IdCat, DataRegistrazione, TestaDiSerie)
VALUES
(1, 1, '2024-08-01', TRUE),
(1, 2, '2024-08-01', FALSE),
(2, 1, '2024-01-01', TRUE),
(2, 2, '2024-01-01', FALSE),
(3, 1, '2024-06-01', TRUE),
(3, 2, '2024-06-01', FALSE);

INSERT INTO GIOCAIN (IdT, IdCat, NumRegistrazione, IdG)
VALUES
(1, 1, 1, 1),
(1, 2, 2, 1),
(2, 1, 3, 2),
(2, 2, 4, 2),
(3, 1, 5, 3),
(3, 2, 6, 3);