SELECT DISTINCT G.Nome, G.Cognome
FROM GIOCATORE G
JOIN GIOCATORE GI ON G.IdG = GI.IdG
JOIN REGISTRAZIONE R ON GI.IdT = R.IdT AND G.IdCat = R.IdCat AND GI.NumRegistrazione = R.NumRegistrazione
JOIN TORNEO T ON R.IdTorneo = T.IdT
WHERE (T.NomeT = 'US Open' AND T.NomeT = 'Australian Open') AND GI.DataI = T.DataI;
