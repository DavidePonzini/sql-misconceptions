SELECT studenti.cognome, studenti.nome, 'studente'
FROM unicorsi.studenti
UNION
SELECT professori.cognome, professori.nome, 'professore'
FROM unicorsi.professori