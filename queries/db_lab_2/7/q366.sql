SELECT studenti.cognome, studenti.nome, 'studente'
FROM studenti
UNION
SELECT professori.cognome, professori.nome, 'professore'
FROM professori