SELECT Cognome AS LastName, Nome AS FirstName, 'professore' AS Status
FROM Professori

UNION ALL

SELECT Cognome AS LastName, Nome AS FirstName, 'studente' AS Status
FROM Studenti;
