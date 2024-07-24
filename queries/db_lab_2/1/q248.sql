SELECT matricola, nome, cognome
FROM unicorsi.studenti
WHERE iscrizione < 2007 AND relatore IS NULL