SELECT NomeT
FROM TORNEO NATURAL JOIN REGISTRAZIONE NATURAL JOIN GIOCAIN
NATURAL JOIN GIOCATORE
GROUP BY IdT