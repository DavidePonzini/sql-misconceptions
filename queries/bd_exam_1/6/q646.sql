SELECT IDG
FROM GIOCAIN NATURAL JOIN GIOCATORE
NATURAL JOIN REGISTRAZIONE NATURAL JOIN TORNEO
WHERE EXISTS (select MAX)