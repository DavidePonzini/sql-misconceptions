SELECT Cognome, Nome, 'studente' AS Qualifica
FROM Studenti
UNION ALL
SELECT Cognome, Nome, 'professore' AS Qualifica
FROM Professori;