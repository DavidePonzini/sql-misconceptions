SELECT IdT
FROM GIOCAIN
JOIN GIOCATORE G G.IDG = IDG
GROUP BY IdT
HAVING COUNT(Nazione) = ALL(SELECT COUNT (Nazione)
FROM GIOCATORE
GROUP BY IDG)