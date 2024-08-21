SELECT IdG
FROM GIOCAIN NATURAL JOIN REGISTRAZIONE
WHERE (IdT,IdCat) Not IN (SELECT IdT,IdCat
                          FROM REGISTRAZIONE
                          WHERE TestaDiSerie=true)