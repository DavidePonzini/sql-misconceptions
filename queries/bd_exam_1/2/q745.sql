SELECT G.Nome, G.Cognome
FROM GIOCATORE G
JOIN GIOCAIN GI ON G.IdG = GI.IdG
JOIN REGISTRAZIONE R ON GI.IdT = R.IdT AND GI.IdCat = R.IdCat AND GI.NumRegistrazione = R.NumRegistrazione
WHERE G.Nazione = 'France'
AND R.TestaDiSerie = FALSE
AND G.IdG NOT IN (
    SELECT GI.IdG
    FROM REGISTRAZIONE R
    JOIN GIOCAIN GI ON R.IdT = GI.IdT AND R.IdCat = GI.IdCat AND R.NumRegistrazione = GI.NumRegistrazione
    WHERE R.TestaDiSerie = TRUE
);
