SELECT Matricola, Nome, Cognome
FROM unicorsi.Studenti
WHERE Iscrizione < 2007 AND Relatore IS NULL;