SELECT DISTINCT IdG
FROM GIOCATORI
WHERE NAZIONE = 'Germania'
AND IdG NOT IN (
    SELECT DISTINCT IdG
    FROM TORNEO NATURAL JOIN REGISTRAZIONE
    WHERE NomeT = 'Wimbledon'
);
