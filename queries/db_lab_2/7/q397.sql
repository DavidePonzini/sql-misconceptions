SELECT cognome, nome, 'studente' AS qualifica
FROM unicorsi.studenti
UNION
SELECT cognome, nome, 'professore' AS qualifica
FROM unicorsi.professori;