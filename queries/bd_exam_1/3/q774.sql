SELECT g.IdG, g.Nome, g.Cognome
FROM GIOCATORE g
WHERE g.Nazione = 'Italia'
  AND EXISTS (
    SELECT 1
    FROM GIOCAIN gi1
    JOIN TORNEO t1 ON gi1.IdT = t1.IdT
    WHERE g.IdG = gi1.IdG
      AND t1.NomeT = 'US Open'
      AND EXTRACT(YEAR FROM t1.DataI) = EXTRACT(YEAR FROM (
        SELECT t2.DataI
        FROM GIOCAIN gi2
        JOIN TORNEO t2 ON gi2.IdT = t2.IdT
        WHERE g.IdG = gi2.IdG
          AND t2.NomeT = 'Australian Open'
      ))
  );
