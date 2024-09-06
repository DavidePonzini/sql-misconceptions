SELECT idT, COUNT(Nazione) AS n 
FROM Giocatore 
JOIN Giocain ON Giocatore.idG = Giocain.idG
GROUP BY idT 
HAVING n >= MAX(
  SELECT idT, COUNT(Nazione) 
  FROM Giocatore 
  JOIN Giocain ON Giocatore.idG = Giocain.idG
  GROUP BY idT
);

