(SELECT studenti.nome, studenti.cognome, 'studente' AS qualifica
FROM studenti)
UNION
(SELECT professori.nome, professori.cognome, 'professore' AS qualifica
FROM professori);
