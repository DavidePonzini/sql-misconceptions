SELECT DISTINCT IdG
FROM GIOCATORE 
WHERE Nazione = 'Francia'
AND IdG NOT IN (SELECT DISTINCT IdG FROM GIOCAIN NATURAL JOIN REGISTRAZIONE WHERE TestaDiSerie)