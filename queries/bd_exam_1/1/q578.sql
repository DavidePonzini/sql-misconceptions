SELECT IdG
FROM GIOCAIN G
NATURAL JOIN CATEGORIA NATURAL JOIN GIOCATORE
WHERE CATEGORIA.Genere = 'SINGOLO' AND
GIOCATORE.Genere = 'F' AND EXISTS (SELECT IdG
                                    FROM GIOCAIN
                                    NATURAL JOIN CATEGORIA
                                    NATURAL JOIN GIOCATORE
                                    WHERE GIOCATORE.genere = 'donnna'
                                    AND CATEGORIA.genereCategoria = 'SINGOLO'
                                    AND IdT = G.IdT)
