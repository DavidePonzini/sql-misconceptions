SELECT idT
FROM giocatore g
NATURAL JOIN giocain gio
NATURAL JOIN torneo T
GROUP BY idT
HAVING COUNT(DISTINCT Nazione) > ALL (
    SELECT COUNT(DISTINCT Nazione)
    FROM giocatore
    NATURAL JOIN giocain
    NATURAL JOIN torneo
    WHERE T.idT <> idT
    GROUP BY idT
);
