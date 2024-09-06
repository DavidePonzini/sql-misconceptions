SELECT giocain.idT
FROM giocain
JOIN giocatore ON giocain.idG = giocatore.idG
GROUP BY giocain.idT
HAVING COUNT(DISTINCT giocatore.Nazione) >= ALL (
    SELECT COUNT(DISTINCT gt.Nazione)
    FROM giocain AS gm
    JOIN giocatore AS gt ON gm.idG = gt.idG
    WHERE gt.Nazione IS NOT NULL
    GROUP BY gm.idT
);

