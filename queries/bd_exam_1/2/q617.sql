SELECT IdG FROM GIOCATORE
NATURAL JOIN GIOCAIN
NATURAL JOIN REGISTRAZIONE
WHERE Nazione = 'Francia' ^ NOT TestaDiSerie