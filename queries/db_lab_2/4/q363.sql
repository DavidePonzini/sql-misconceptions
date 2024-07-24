SELECT studenti.matricola, studenti.nome, studenti.cognome
FROM studenti
JOIN corsidilaurea ON studenti.corsodilaurea = corsidilaurea.id
WHERE studenti.laurea < '2009-01-11' and NOT NULL;