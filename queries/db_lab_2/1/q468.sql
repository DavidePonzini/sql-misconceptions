SELECT Matricola, Nome, Cognome
FROM Studenti
WHERE Iscrizione < 2007
  AND Relatore IS NULL;
