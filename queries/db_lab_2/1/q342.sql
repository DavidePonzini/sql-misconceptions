SELECT matricola, cognome, nome
FROM unicorsi.studenti
WHERE relatore isnull AND iscrizione <= 2006
