SELECT Nome, Cognome
FROM GIOCATORE
WHERE NAZIONE = "Germania"
AND IdG NOT IN (
    SELECT IdG
    FROM TORNEO
    JOIN REGISTRAZIONE idt = Idt
    JOIN GIOCAIN Nome = Nome
    WHERE NomeT = 'Wimbledon'
);
