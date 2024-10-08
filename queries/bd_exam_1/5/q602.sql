SELECT IdT, COUNT(DISTINCT Nazione) as NNAZ
FROM GIOCAIN
NATURAL JOIN GIOCATORE
GROUP BY IdT
HAVING NNAZ > (SELECT IdT, COUNT(DISTINCT NNAZ)
FROM GIOCAIN NATURAL JOIN GIOCATORE
GROUP BY idT)