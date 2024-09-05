SELECT DISTINCT IdT
FROM TORNEO NATURAL JOIN GIOCAIN NATURAL JOIN GIOCATORE
GROUP BY IdT
HAVING COUNT(DISTINCT Nazione) >= ALL(SELECT COUNT(DISTINCT Nazione)
FROM TORNEO NATURAL JOIN GIOCAIN NATURAL JOIN GIOCATORE
GROUP BY IdT)