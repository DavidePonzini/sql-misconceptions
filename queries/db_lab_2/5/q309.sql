SELECT s.Nome, s.Cognome, p.Cognome AS "Cognome Relatore"
FROM Studenti s
JOIN Professori p ON s.Relatore = p.id
ORDER BY s.Cognome, s.Nome;