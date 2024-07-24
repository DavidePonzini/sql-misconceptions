SELECT Cognome, Nome, 'Studente' AS Qualifica 
FROM unicorsi.Studenti
UNION
SELECT Cognome, Nome, 'Professore' AS Qualifica 
FROM unicorsi.Professori;