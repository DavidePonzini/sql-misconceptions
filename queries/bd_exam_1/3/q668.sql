SELECT IdG
FROM GIOCATORE NATURAL JOIN GIOCAIN NATURAL JOIN CATEGORIA
WHERE NAZIONE = 'ITALIA' AND NomeCategoria = 'US Open'
INTERSECT
SELECT IdG
FROM GIOCATORE NATURAL JOIN GIOCAIN NATURAL JOIN CATEGORIA
WHERE NAZIONE = 'ITALIA' AND NomeCategoria = 'Australian Open';
