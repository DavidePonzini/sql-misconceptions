SELECT Cognome, Nome, 'Studente' AS Qualifica 
FROM Studenti
UNION
SELECT Cognome, Nome, 'Professore' AS Qualifica 
FROM Professori;