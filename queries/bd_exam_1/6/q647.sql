SELECT DISTINCT iDG FROM GIOCATORE
NATURAL JOIN GIOCAIN
NATURAL JOIN TORNEO
WHERE COUNT(iDT) = MAX(SELECT COUNT(iDT) FROM TORNEO
NATURAL JOIN GIOCAIN NATURAL JOIN GIOCATORE
GROUP BY GIOCATORE.iDG)