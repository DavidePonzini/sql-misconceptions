SELECT studenti.matricola, studenti.nome, studenti.cognome
FROM studenti
WHERE studenti.iscrizione < '2007' AND studenti.relatore IS NULL;