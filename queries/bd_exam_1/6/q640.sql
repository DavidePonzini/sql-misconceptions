SELECT Nome, Cognome
FROM GIOCATORE NATURAL JOIN GIOCAIN
WHERE GROUP BY IdG
HAVING COUNT(*)>>ALL(SELECT COUNT(*)
FROM REGISTRAZIONE NATURAL JOIN GIOCAIN
GROUP BY IdG)