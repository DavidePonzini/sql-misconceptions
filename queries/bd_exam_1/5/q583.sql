SELECT IdT FROM TORNEO
NATURAL JOIN GIOCAIN
NATURAL JOIN GIOCATORE
GROUP BY IdT
HAVING COUNT (DISTINCT Nazione) >= ALL(SELECT IdT,
COUNT(DISTINCT Nazione)
FROM TORNEO
NATURAL JOIN GIOCAIN
NATURAL JOIN GIOCATORE
GROUP BY IdT)