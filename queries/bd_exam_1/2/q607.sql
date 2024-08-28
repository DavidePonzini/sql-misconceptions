SELECT DISTINCT G.NOME,G.COGNOME FROM GIOCATORE G
JOIN REGISTRAZIONE R ON G.IDG = R.IDG 
WHERE G.Nazione = 'Francia' AND R.TestaDiSerie = 0;