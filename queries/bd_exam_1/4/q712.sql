SELECT *
FROM GIOCATORE
WHERE NAZIONE = 'Germania'
AND IdG NOT IN (
    SELECT IdG
    FROM GIOCATORE
    NATURAL JOIN GIOCAIN
    NATURAL JOIN REGISTRAZIONE
    NATURAL JOIN TORNEO
    WHERE TORNEO.LUOGO = 'Wimbledon'
);