SELECT Nome, Cognome, 'Studente' as Qualifica
FROM Studenti 

UNION 

SELECT Nome, Cognome, 'Professore' as Qualifica
FROM Professori;