SELECT Matricola, Cognome, Nome
FROM Studenti
WHERE Iscrizione < 2007
  AND Relatore IS NULL;
