SELECT IdG, Nome, COGNOME
FROM GIOCATORE G1
WHERE IdG Not IN (SELECT IdG from GIOCATORE G2 JOIN REGISTRAZIONE R ON G2.IdG R.IdG
where G1.IdG = G2.IdG AND TestaDiSerie = TRUE)