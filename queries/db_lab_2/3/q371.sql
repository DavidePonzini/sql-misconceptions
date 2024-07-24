SELECT Matricola, Cognome, Nome
FROM Studenti
WHERE (Cognome <> 'Serra' AND Cognome <> 'Melogno' AND Cognome <> 'Giunchi') OR (Residenza = 'Genova' OR Residenza = 'La Spezia' OR Residenza = 'Savona')
ORDER BY Matricola DESC