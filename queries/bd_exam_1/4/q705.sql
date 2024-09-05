SELECT IdG
FROM GIOCATORE
NATURAL JOIN GIOCAIN
WHERE Nazione = 'tedeschi'  or Nazione = 'tedesche'
HAVING IdG NOT IN (
    SELECT IdT
    FROM TORNEO
    WHERE LUOGO = 'Wimbledon'
);
