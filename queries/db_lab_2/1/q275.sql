SELECT matricola, cognome, nome, iscrizione
FROM studenti
WHERE iscrizione<2007 AND relatore ISNULL;