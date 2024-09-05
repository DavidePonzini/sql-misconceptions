SELECT * 
FROM GIOCATORI 
WHERE IdG = (
    SELECT DISTINCT IdG 
    FROM (
        SELECT IdG, DataI as D1 
        FROM (
            SELECT * 
            FROM TORNEO 
            WHERE NomeT = 'US OPEN'
        ) 
        NATURAL JOIN REGISTR 
        NATURAL JOIN GIOCAIN 
        NATURAL JOIN GIOCATORE
    ) JOIN (
        SELECT IdG, DataI as D2 
        FROM (
            SELECT * 
            FROM TORNEO 
            WHERE NomeT = 'Austn open'
        ) 
        NATURAL JOIN REGISTR 
        NATURAL JOIN GIOCAIN 
        NATURAL JOIN GIOCATORE
    ) 
    ON D1 = D2
);
