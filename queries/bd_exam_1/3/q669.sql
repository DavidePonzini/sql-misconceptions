SELECT DISTINCT G.Cognome, G.Nome
FROM GIOCATORE G NATURAL JOIN GIOCAIN NATURAL JOIN GIOCATORE NATURAL JOIN TORNEO T
WHERE NAZIONE = 'ITALIA' AND NomeT = 'US Open'
AND IdG IN (
    SELECT DISTINCT Cognome, Nome
    FROM GIOCATORE NATURAL JOIN REGISTRAZIONE NATURAL JOIN TORNEO
    WHERE NAZIONE = 'ITALIA' AND NomeT = 'Australian Open'
    AND EXTRACT(YEAR FROM DataI) = EXTRACT(YEAR FROM T.DataI)
);
