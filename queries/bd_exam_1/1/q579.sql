SELECT IdG FROM
(SELECT DISTINCT IdG
FROM GIOCATORE NATURAL JOIN GIOCAIN NATURAL JOIN REGISTRAZIONE
NATURAL JOIN CATEGORIA
WHERE genere = 'Femmina' AND NomeCategoria = 'Singoli')
NATURAL JOIN
(SELECT DISTINCT IdG
FROM GIOCATORE NATURAL JOIN GIOCAIN NATURAL JOIN REGISTRAZIONE
WHERE genere = 'Femmina' AND NomeCategoria = 'Doppi')
WHERE A.IdT = B.IdT