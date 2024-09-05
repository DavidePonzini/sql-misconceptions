SELECT IdG, Nome, Cognome,COUNT(DISTINCT IdT) As NumTorni
FROM GIOCATORE G JOIN REGISTRAZIONE R
ON G.IdG = R.IdG
ORDER BY IdG,Nome,Cognome
limit 1;