SELECT s.Nome, s.Cognome, p.Cognome AS "Cognome Relatore"
FROM unicorsi.Studenti s
JOIN unicorsi.Professori p ON s.Relatore = p.id
ORDER BY s.Cognome, s.Nome;