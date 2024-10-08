SELECT IdTorneo, COUNT(DISTINCT Nazione)
FROM GIOCAIN G1 JOIN GIOCATORE G
ON g1.idG = G.idG
GROUP BY IdTorneo
HAVING Nazione >= (SELECT Max(Nazione)
FROM (SELECT IdTorneo,COUNT(DISTINCT Nazione) as Nazione
FROM GIOCAIN G1 JOIN GIOCATORE G ON G1.IdG = G.idG
GROUP BY IdTorneo))