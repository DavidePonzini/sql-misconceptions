SELECT matricola, cognome, nome
FROM studenti
WHERE relatore isnull AND iscrizione <= 2006
