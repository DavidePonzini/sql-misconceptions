SELECT DISTINCT IdG
FROM GIOCATORE NATURAL JOIN GIOCAIN NATURAL JOIN REGISTRAZIONE
WHERE Nome = 'Francia' AND IdG NOT IN (SELECT DISTINCT IdG FROM GIOCATORE NATURAL JOIN GIOCAIN NATURAL JOIN REGISTRAZIONE WHERE Nome = 'Francia' AND TestaDiSerie = TRUE)