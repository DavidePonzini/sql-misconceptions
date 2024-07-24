SELECT Matricola, Nome, Cognome
FROM unicorsi.Studenti
WHERE Cognome NOT IN ('Serra', 'Melogno', 'Giunchi')
OR Residenza IN ('Genova', 'La Spezia', 'Savona')
ORDER BY Matricola DESC;