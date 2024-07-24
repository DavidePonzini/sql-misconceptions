(SELECT studenti.nome, studenti.cognome, 'studente' AS qualifica
FROM unicorsi.studenti)
UNION
(SELECT professori.nome, professori.cognome, 'professore' AS qualifica
FROM unicorsi.professori);
